-- ------------------------------------------------------------------------------- 
--   Génération des triggers de la base 
--   de données : Sous_mod
--   (4/12/2012 19:46:18)
-- ------------------------------------------------------------------------------- 

-- ------------------------------------------------------------------------------- 
--   Table : ETABLISSEMENT
-- ------------------------------------------------------------------------------- 

drop trigger TD_ETABLISSEMENT;

-- Trigger de suppression ----------------------------------------------
create trigger TD_ETABLISSEMENT
after delete on ETABLISSEMENT for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de ETABLISSEMENT s'il existe des
     -- occurrences correspondantes de la table ETUDIANT.

     select count(*) into numrows
     from ETUDIANT
     where
          ETUDIANT.DEGRÉ = :old.DEGRÉ;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "ETABLISSEMENT". Des occurrences de "ETUDIANT" existent.');
     end if;

end;
/

drop trigger TU_ETABLISSEMENT;

-- Trigger de modification ----------------------------------------------
create trigger TU_ETABLISSEMENT
after update on ETABLISSEMENT for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de ETABLISSEMENT sur les 
     -- occurrences correspondantes de la table ETUDIANT.

     if
          :old.DEGRÉ <> :new.DEGRÉ
     then
          update ETUDIANT
          set
               ETUDIANT.DEGRÉ = :new.DEGRÉ
          where
               ETUDIANT.DEGRÉ = :old.DEGRÉ;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : MOIS
-- ------------------------------------------------------------------------------- 

drop trigger TD_MOIS;

-- Trigger de suppression ----------------------------------------------
create trigger TD_MOIS
after delete on MOIS for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table ROULER.

     delete from ROULER
     where
          ROULER.N°MOIS = :old.N°MOIS;

end;
/

drop trigger TU_MOIS;

-- Trigger de modification ----------------------------------------------
create trigger TU_MOIS
after update on MOIS for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de MOIS sur les 
     -- occurrences correspondantes de la table ROULER.

     if
          :old.N°MOIS <> :new.N°MOIS
     then
          update ROULER
          set
               ROULER.N°MOIS = :new.N°MOIS
          where
               ROULER.N°MOIS = :old.N°MOIS;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : ETUDIANT
-- ------------------------------------------------------------------------------- 

drop trigger TU_ETUDIANT;

-- Trigger de modification ----------------------------------------------
create trigger TU_ETUDIANT
after update on ETUDIANT for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table ETUDIANT s'il n'existe pas d'occurrence correspondante de la 
     -- table ETABLISSEMENT.

     if
          :old.N°_CLIENT <> :new.N°_CLIENT
     then
          select count(*) into numrows
          from ETABLISSEMENT
          where
               :new.DEGRÉ = ETABLISSEMENT.DEGRÉ;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "ETUDIANT" car "ETABLISSEMENT" n''existe pas.');
          end if;
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- CLIENT.

     if
          :old.N°_CLIENT <> :new.N°_CLIENT
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "CLIENT" interdite.');
     end if;

end;
/

drop trigger TI_ETUDIANT;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_ETUDIANT
after insert on ETUDIANT for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ETUDIANT 
     -- s'il n'existe pas d'occurrence correspondante dans la table ETABLISSEMENT.

     select count(*) into numrows
     from ETABLISSEMENT
     where
          :new.DEGRÉ = ETABLISSEMENT.DEGRÉ;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ETUDIANT" car "ETABLISSEMENT" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ETUDIANT 
     -- s'il n'existe pas d'occurrence correspondante dans la table CLIENT.

     select count(*) into numrows
     from CLIENT
     where
          :new.N°_CLIENT = CLIENT.N°_CLIENT;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ETUDIANT" car "CLIENT" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : MOTO
-- ------------------------------------------------------------------------------- 

drop trigger TU_MOTO;

-- Trigger de modification ----------------------------------------------
create trigger TU_MOTO
after update on MOTO for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- MODÉLE.

     if
          :old.CODE_MODÉLE <> :new.CODE_MODÉLE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "MODÉLE" interdite.');
     end if;

end;
/

drop trigger TI_MOTO;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_MOTO
after insert on MOTO for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de MOTO 
     -- s'il n'existe pas d'occurrence correspondante dans la table MODÉLE.

     select count(*) into numrows
     from MODÉLE
     where
          :new.CODE_MODÉLE = MODÉLE.CODE_MODÉLE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "MOTO" car "MODÉLE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : EXAM
-- ------------------------------------------------------------------------------- 

drop trigger TD_EXAM;

-- Trigger de suppression ----------------------------------------------
create trigger TD_EXAM
after delete on EXAM for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table EXAM_CODE.

     delete from EXAM_CODE
     where
          EXAM_CODE.ID_EXAM = :old.ID_EXAM;
     -- Supprimer les occurrences correspondantes de la table EXAM_PERMIS.

     delete from EXAM_PERMIS
     where
          EXAM_PERMIS.ID_EXAM = :old.ID_EXAM;

end;
/

drop trigger TU_EXAM;

-- Trigger de modification ----------------------------------------------
create trigger TU_EXAM
after update on EXAM for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table EXAM s'il n'existe pas d'occurrence correspondante de la 
     -- table TYPE_EXAM.

     if
          :old.ID_EXAM <> :new.ID_EXAM
     then
          select count(*) into numrows
          from TYPE_EXAM
          where
               :new.CODE_TYPE = TYPE_EXAM.CODE_TYPE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "EXAM" car "TYPE_EXAM" n''existe pas.');
          end if;
     end if;
     -- Répercuter la modification de la clé primaire de EXAM sur les 
     -- occurrences correspondantes de la table EXAM_CODE.

     if
          :old.ID_EXAM <> :new.ID_EXAM
     then
          update EXAM_CODE
          set
               EXAM_CODE.ID_EXAM = :new.ID_EXAM
          where
               EXAM_CODE.ID_EXAM = :old.ID_EXAM;
     end if;
     -- Répercuter la modification de la clé primaire de EXAM sur les 
     -- occurrences correspondantes de la table EXAM_PERMIS.

     if
          :old.ID_EXAM <> :new.ID_EXAM
     then
          update EXAM_PERMIS
          set
               EXAM_PERMIS.ID_EXAM = :new.ID_EXAM
          where
               EXAM_PERMIS.ID_EXAM = :old.ID_EXAM;
     end if;

end;
/

drop trigger TI_EXAM;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_EXAM
after insert on EXAM for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de EXAM 
     -- s'il n'existe pas d'occurrence correspondante dans la table TYPE_EXAM.

     select count(*) into numrows
     from TYPE_EXAM
     where
          :new.CODE_TYPE = TYPE_EXAM.CODE_TYPE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "EXAM" car "TYPE_EXAM" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : VOITURE
-- ------------------------------------------------------------------------------- 

drop trigger TU_VOITURE;

-- Trigger de modification ----------------------------------------------
create trigger TU_VOITURE
after update on VOITURE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- MODÉLE.

     if
          :old.CODE_MODÉLE <> :new.CODE_MODÉLE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "MODÉLE" interdite.');
     end if;

end;
/

drop trigger TI_VOITURE;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_VOITURE
after insert on VOITURE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VOITURE 
     -- s'il n'existe pas d'occurrence correspondante dans la table MODÉLE.

     select count(*) into numrows
     from MODÉLE
     where
          :new.CODE_MODÉLE = MODÉLE.CODE_MODÉLE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VOITURE" car "MODÉLE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : SALARIÉ
-- ------------------------------------------------------------------------------- 

drop trigger TU_SALARIÉ;

-- Trigger de modification ----------------------------------------------
create trigger TU_SALARIÉ
after update on SALARIÉ for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- CLIENT.

     if
          :old.N°_CLIENT <> :new.N°_CLIENT
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "CLIENT" interdite.');
     end if;

end;
/

drop trigger TI_SALARIÉ;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_SALARIÉ
after insert on SALARIÉ for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de SALARIÉ 
     -- s'il n'existe pas d'occurrence correspondante dans la table CLIENT.

     select count(*) into numrows
     from CLIENT
     where
          :new.N°_CLIENT = CLIENT.N°_CLIENT;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "SALARIÉ" car "CLIENT" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : MODÉLE
-- ------------------------------------------------------------------------------- 

drop trigger TD_MODÉLE;

-- Trigger de suppression ----------------------------------------------
create trigger TD_MODÉLE
after delete on MODÉLE for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de MODÉLE s'il existe des
     -- occurrences correspondantes de la table VÉHICULE.

     select count(*) into numrows
     from VÉHICULE
     where
          VÉHICULE.CODE_MODÉLE = :old.CODE_MODÉLE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "MODÉLE". Des occurrences de "VÉHICULE" existent.');
     end if;
     -- Supprimer les occurrences correspondantes de la table PLANNING.

     delete from PLANNING
     where
          PLANNING.CODE_MODÉLE = :old.CODE_MODÉLE;
     -- Supprimer les occurrences correspondantes de la table MOTO.

     delete from MOTO
     where
          MOTO.CODE_MODÉLE = :old.CODE_MODÉLE;
     -- Supprimer les occurrences correspondantes de la table VOITURE.

     delete from VOITURE
     where
          VOITURE.CODE_MODÉLE = :old.CODE_MODÉLE;

end;
/

drop trigger TU_MODÉLE;

-- Trigger de modification ----------------------------------------------
create trigger TU_MODÉLE
after update on MODÉLE for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de MODÉLE sur les 
     -- occurrences correspondantes de la table VÉHICULE.

     if
          :old.CODE_MODÉLE <> :new.CODE_MODÉLE
     then
          update VÉHICULE
          set
               VÉHICULE.CODE_MODÉLE = :new.CODE_MODÉLE
          where
               VÉHICULE.CODE_MODÉLE = :old.CODE_MODÉLE;
     end if;
     -- Répercuter la modification de la clé primaire de MODÉLE sur les 
     -- occurrences correspondantes de la table PLANNING.

     if
          :old.CODE_MODÉLE <> :new.CODE_MODÉLE
     then
          update PLANNING
          set
               PLANNING.CODE_MODÉLE = :new.CODE_MODÉLE
          where
               PLANNING.CODE_MODÉLE = :old.CODE_MODÉLE;
     end if;
     -- Répercuter la modification de la clé primaire de MODÉLE sur les 
     -- occurrences correspondantes de la table MOTO.

     if
          :old.CODE_MODÉLE <> :new.CODE_MODÉLE
     then
          update MOTO
          set
               MOTO.CODE_MODÉLE = :new.CODE_MODÉLE
          where
               MOTO.CODE_MODÉLE = :old.CODE_MODÉLE;
     end if;
     -- Répercuter la modification de la clé primaire de MODÉLE sur les 
     -- occurrences correspondantes de la table VOITURE.

     if
          :old.CODE_MODÉLE <> :new.CODE_MODÉLE
     then
          update VOITURE
          set
               VOITURE.CODE_MODÉLE = :new.CODE_MODÉLE
          where
               VOITURE.CODE_MODÉLE = :old.CODE_MODÉLE;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : VÉHICULE
-- ------------------------------------------------------------------------------- 

drop trigger TD_VÉHICULE;

-- Trigger de suppression ----------------------------------------------
create trigger TD_VÉHICULE
after delete on VÉHICULE for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table ROULER.

     delete from ROULER
     where
          ROULER.N°VÉHICULE = :old.N°VÉHICULE;
     -- Supprimer les occurrences correspondantes de la table ULTILISER.

     delete from ULTILISER
     where
          ULTILISER.N°VÉHICULE = :old.N°VÉHICULE;

end;
/

drop trigger TU_VÉHICULE;

-- Trigger de modification ----------------------------------------------
create trigger TU_VÉHICULE
after update on VÉHICULE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle, interdire la modification de la clé étrangère de la 
     -- table VÉHICULE s'il n'existe pas d'occurrence correspondante de la 
     -- table MODÉLE.

     if
          :old.N°VÉHICULE <> :new.N°VÉHICULE
     then
          select count(*) into numrows
          from MODÉLE
          where
               :new.CODE_MODÉLE = MODÉLE.CODE_MODÉLE;
          if 
               (
               numrows = 0 
               )
          then
               raise_application_error(
               -20007,
               'Impossible de mettre à jour "VÉHICULE" car "MODÉLE" n''existe pas.');
          end if;
     end if;
     -- Répercuter la modification de la clé primaire de VÉHICULE sur les 
     -- occurrences correspondantes de la table ROULER.

     if
          :old.N°VÉHICULE <> :new.N°VÉHICULE
     then
          update ROULER
          set
               ROULER.N°VÉHICULE = :new.N°VÉHICULE
          where
               ROULER.N°VÉHICULE = :old.N°VÉHICULE;
     end if;
     -- Répercuter la modification de la clé primaire de VÉHICULE sur les 
     -- occurrences correspondantes de la table ULTILISER.

     if
          :old.N°VÉHICULE <> :new.N°VÉHICULE
     then
          update ULTILISER
          set
               ULTILISER.N°VÉHICULE = :new.N°VÉHICULE
          where
               ULTILISER.N°VÉHICULE = :old.N°VÉHICULE;
     end if;

end;
/

drop trigger TI_VÉHICULE;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_VÉHICULE
after insert on VÉHICULE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de VÉHICULE 
     -- s'il n'existe pas d'occurrence correspondante dans la table MODÉLE.

     select count(*) into numrows
     from MODÉLE
     where
          :new.CODE_MODÉLE = MODÉLE.CODE_MODÉLE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "VÉHICULE" car "MODÉLE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : CLIENT
-- ------------------------------------------------------------------------------- 

drop trigger TD_CLIENT;

-- Trigger de suppression ----------------------------------------------
create trigger TD_CLIENT
after delete on CLIENT for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table EXAM_CODE.

     delete from EXAM_CODE
     where
          EXAM_CODE.N°_CLIENT = :old.N°_CLIENT;
     -- Supprimer les occurrences correspondantes de la table PLANNING.

     delete from PLANNING
     where
          PLANNING.N°_CLIENT = :old.N°_CLIENT;
     -- Supprimer les occurrences correspondantes de la table EXAM_PERMIS.

     delete from EXAM_PERMIS
     where
          EXAM_PERMIS.N°_CLIENT = :old.N°_CLIENT;
     -- Supprimer les occurrences correspondantes de la table ETUDIANT.

     delete from ETUDIANT
     where
          ETUDIANT.N°_CLIENT = :old.N°_CLIENT;
     -- Supprimer les occurrences correspondantes de la table SALARIÉ.

     delete from SALARIÉ
     where
          SALARIÉ.N°_CLIENT = :old.N°_CLIENT;

end;
/

drop trigger TU_CLIENT;

-- Trigger de modification ----------------------------------------------
create trigger TU_CLIENT
after update on CLIENT for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de CLIENT sur les 
     -- occurrences correspondantes de la table EXAM_CODE.

     if
          :old.N°_CLIENT <> :new.N°_CLIENT
     then
          update EXAM_CODE
          set
               EXAM_CODE.N°_CLIENT = :new.N°_CLIENT
          where
               EXAM_CODE.N°_CLIENT = :old.N°_CLIENT;
     end if;
     -- Répercuter la modification de la clé primaire de CLIENT sur les 
     -- occurrences correspondantes de la table PLANNING.

     if
          :old.N°_CLIENT <> :new.N°_CLIENT
     then
          update PLANNING
          set
               PLANNING.N°_CLIENT = :new.N°_CLIENT
          where
               PLANNING.N°_CLIENT = :old.N°_CLIENT;
     end if;
     -- Répercuter la modification de la clé primaire de CLIENT sur les 
     -- occurrences correspondantes de la table EXAM_PERMIS.

     if
          :old.N°_CLIENT <> :new.N°_CLIENT
     then
          update EXAM_PERMIS
          set
               EXAM_PERMIS.N°_CLIENT = :new.N°_CLIENT
          where
               EXAM_PERMIS.N°_CLIENT = :old.N°_CLIENT;
     end if;
     -- Répercuter la modification de la clé primaire de CLIENT sur les 
     -- occurrences correspondantes de la table ETUDIANT.

     if
          :old.N°_CLIENT <> :new.N°_CLIENT
     then
          update ETUDIANT
          set
               ETUDIANT.N°_CLIENT = :new.N°_CLIENT
          where
               ETUDIANT.N°_CLIENT = :old.N°_CLIENT;
     end if;
     -- Répercuter la modification de la clé primaire de CLIENT sur les 
     -- occurrences correspondantes de la table SALARIÉ.

     if
          :old.N°_CLIENT <> :new.N°_CLIENT
     then
          update SALARIÉ
          set
               SALARIÉ.N°_CLIENT = :new.N°_CLIENT
          where
               SALARIÉ.N°_CLIENT = :old.N°_CLIENT;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : MONITEUR
-- ------------------------------------------------------------------------------- 

drop trigger TD_MONITEUR;

-- Trigger de suppression ----------------------------------------------
create trigger TD_MONITEUR
after delete on MONITEUR for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table PLANNING.

     delete from PLANNING
     where
          PLANNING.N°MONITEUR = :old.N°MONITEUR;

end;
/

drop trigger TU_MONITEUR;

-- Trigger de modification ----------------------------------------------
create trigger TU_MONITEUR
after update on MONITEUR for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de MONITEUR sur les 
     -- occurrences correspondantes de la table PLANNING.

     if
          :old.N°MONITEUR <> :new.N°MONITEUR
     then
          update PLANNING
          set
               PLANNING.N°MONITEUR = :new.N°MONITEUR
          where
               PLANNING.N°MONITEUR = :old.N°MONITEUR;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : LEÇON
-- ------------------------------------------------------------------------------- 

drop trigger TD_LEÇON;

-- Trigger de suppression ----------------------------------------------
create trigger TD_LEÇON
after delete on LEÇON for each row
declare numrows INTEGER;
begin

     -- Supprimer les occurrences correspondantes de la table ULTILISER.

     delete from ULTILISER
     where
          ULTILISER.N°LEÇON = :old.N°LEÇON;
     -- Supprimer les occurrences correspondantes de la table PLANNING.

     delete from PLANNING
     where
          PLANNING.N°LEÇON = :old.N°LEÇON;
     -- Supprimer les occurrences correspondantes de la table H_N°LEÇON_LEÇON.

     delete from H_N°LEÇON_LEÇON
     where
          H_N°LEÇON_LEÇON.N°LEÇON = :old.N°LEÇON;

end;
/

drop trigger TU_LEÇON;

-- Trigger de modification ----------------------------------------------
create trigger TU_LEÇON
after update on LEÇON for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de LEÇON sur les 
     -- occurrences correspondantes de la table ULTILISER.

     if
          :old.N°LEÇON <> :new.N°LEÇON
     then
          update ULTILISER
          set
               ULTILISER.N°LEÇON = :new.N°LEÇON
          where
               ULTILISER.N°LEÇON = :old.N°LEÇON;
     end if;
     -- Répercuter la modification de la clé primaire de LEÇON sur les 
     -- occurrences correspondantes de la table PLANNING.

     if
          :old.N°LEÇON <> :new.N°LEÇON
     then
          update PLANNING
          set
               PLANNING.N°LEÇON = :new.N°LEÇON
          where
               PLANNING.N°LEÇON = :old.N°LEÇON;
     end if;
     -- Répercuter la modification de la clé primaire de LEÇON sur les 
     -- occurrences correspondantes de la table H_N°LEÇON_LEÇON.

     if
          :old.N°LEÇON <> :new.N°LEÇON
     then
          update H_N°LEÇON_LEÇON
          set
               H_N°LEÇON_LEÇON.N°LEÇON = :new.N°LEÇON
          where
               H_N°LEÇON_LEÇON.N°LEÇON = :old.N°LEÇON;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : TYPE_EXAM
-- ------------------------------------------------------------------------------- 

drop trigger TD_TYPE_EXAM;

-- Trigger de suppression ----------------------------------------------
create trigger TD_TYPE_EXAM
after delete on TYPE_EXAM for each row
declare numrows INTEGER;
begin

     -- Interdire la suppression d'une occurrence de TYPE_EXAM s'il existe des
     -- occurrences correspondantes de la table EXAM.

     select count(*) into numrows
     from EXAM
     where
          EXAM.CODE_TYPE = :old.CODE_TYPE;
     if (numrows > 0) then
          raise_application_error(
          -20001,
          'Impossible de supprimer "TYPE_EXAM". Des occurrences de "EXAM" existent.');
     end if;

end;
/

drop trigger TU_TYPE_EXAM;

-- Trigger de modification ----------------------------------------------
create trigger TU_TYPE_EXAM
after update on TYPE_EXAM for each row
declare numrows INTEGER;
begin

     -- Répercuter la modification de la clé primaire de TYPE_EXAM sur les 
     -- occurrences correspondantes de la table EXAM.

     if
          :old.CODE_TYPE <> :new.CODE_TYPE
     then
          update EXAM
          set
               EXAM.CODE_TYPE = :new.CODE_TYPE
          where
               EXAM.CODE_TYPE = :old.CODE_TYPE;
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : ROULER
-- ------------------------------------------------------------------------------- 

drop trigger TU_ROULER;

-- Trigger de modification ----------------------------------------------
create trigger TU_ROULER
after update on ROULER for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- MOIS.

     if
          :old.N°MOIS <> :new.N°MOIS or 
          :old.N°VÉHICULE <> :new.N°VÉHICULE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "MOIS" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- VÉHICULE.

     if
          :old.N°MOIS <> :new.N°MOIS or 
          :old.N°VÉHICULE <> :new.N°VÉHICULE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "VÉHICULE" interdite.');
     end if;

end;
/

drop trigger TI_ROULER;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_ROULER
after insert on ROULER for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ROULER 
     -- s'il n'existe pas d'occurrence correspondante dans la table MOIS.

     select count(*) into numrows
     from MOIS
     where
          :new.N°MOIS = MOIS.N°MOIS;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ROULER" car "MOIS" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ROULER 
     -- s'il n'existe pas d'occurrence correspondante dans la table VÉHICULE.

     select count(*) into numrows
     from VÉHICULE
     where
          :new.N°VÉHICULE = VÉHICULE.N°VÉHICULE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ROULER" car "VÉHICULE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : EXAM_CODE
-- ------------------------------------------------------------------------------- 

drop trigger TU_EXAM_CODE;

-- Trigger de modification ----------------------------------------------
create trigger TU_EXAM_CODE
after update on EXAM_CODE for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- EXAM.

     if
          :old.ID_EXAM <> :new.ID_EXAM or 
          :old.N°_CLIENT <> :new.N°_CLIENT
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "EXAM" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- CLIENT.

     if
          :old.ID_EXAM <> :new.ID_EXAM or 
          :old.N°_CLIENT <> :new.N°_CLIENT
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "CLIENT" interdite.');
     end if;

end;
/

drop trigger TI_EXAM_CODE;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_EXAM_CODE
after insert on EXAM_CODE for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de EXAM_CODE 
     -- s'il n'existe pas d'occurrence correspondante dans la table EXAM.

     select count(*) into numrows
     from EXAM
     where
          :new.ID_EXAM = EXAM.ID_EXAM;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "EXAM_CODE" car "EXAM" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de EXAM_CODE 
     -- s'il n'existe pas d'occurrence correspondante dans la table CLIENT.

     select count(*) into numrows
     from CLIENT
     where
          :new.N°_CLIENT = CLIENT.N°_CLIENT;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "EXAM_CODE" car "CLIENT" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : ULTILISER
-- ------------------------------------------------------------------------------- 

drop trigger TU_ULTILISER;

-- Trigger de modification ----------------------------------------------
create trigger TU_ULTILISER
after update on ULTILISER for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- LEÇON.

     if
          :old.N°LEÇON <> :new.N°LEÇON or 
          :old.N°VÉHICULE <> :new.N°VÉHICULE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "LEÇON" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- VÉHICULE.

     if
          :old.N°LEÇON <> :new.N°LEÇON or 
          :old.N°VÉHICULE <> :new.N°VÉHICULE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "VÉHICULE" interdite.');
     end if;

end;
/

drop trigger TI_ULTILISER;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_ULTILISER
after insert on ULTILISER for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ULTILISER 
     -- s'il n'existe pas d'occurrence correspondante dans la table LEÇON.

     select count(*) into numrows
     from LEÇON
     where
          :new.N°LEÇON = LEÇON.N°LEÇON;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ULTILISER" car "LEÇON" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de ULTILISER 
     -- s'il n'existe pas d'occurrence correspondante dans la table VÉHICULE.

     select count(*) into numrows
     from VÉHICULE
     where
          :new.N°VÉHICULE = VÉHICULE.N°VÉHICULE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "ULTILISER" car "VÉHICULE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : PLANNING
-- ------------------------------------------------------------------------------- 

drop trigger TU_PLANNING;

-- Trigger de modification ----------------------------------------------
create trigger TU_PLANNING
after update on PLANNING for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- LEÇON.

     if
          :old.N°LEÇON <> :new.N°LEÇON or 
          :old.N°_CLIENT <> :new.N°_CLIENT or 
          :old.N°MONITEUR <> :new.N°MONITEUR or 
          :old.CODE_MODÉLE <> :new.CODE_MODÉLE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "LEÇON" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- CLIENT.

     if
          :old.N°LEÇON <> :new.N°LEÇON or 
          :old.N°_CLIENT <> :new.N°_CLIENT or 
          :old.N°MONITEUR <> :new.N°MONITEUR or 
          :old.CODE_MODÉLE <> :new.CODE_MODÉLE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "CLIENT" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- MONITEUR.

     if
          :old.N°LEÇON <> :new.N°LEÇON or 
          :old.N°_CLIENT <> :new.N°_CLIENT or 
          :old.N°MONITEUR <> :new.N°MONITEUR or 
          :old.CODE_MODÉLE <> :new.CODE_MODÉLE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "MONITEUR" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- MODÉLE.

     if
          :old.N°LEÇON <> :new.N°LEÇON or 
          :old.N°_CLIENT <> :new.N°_CLIENT or 
          :old.N°MONITEUR <> :new.N°MONITEUR or 
          :old.CODE_MODÉLE <> :new.CODE_MODÉLE
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "MODÉLE" interdite.');
     end if;

end;
/

drop trigger TI_PLANNING;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_PLANNING
after insert on PLANNING for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de PLANNING 
     -- s'il n'existe pas d'occurrence correspondante dans la table LEÇON.

     select count(*) into numrows
     from LEÇON
     where
          :new.N°LEÇON = LEÇON.N°LEÇON;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "PLANNING" car "LEÇON" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de PLANNING 
     -- s'il n'existe pas d'occurrence correspondante dans la table CLIENT.

     select count(*) into numrows
     from CLIENT
     where
          :new.N°_CLIENT = CLIENT.N°_CLIENT;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "PLANNING" car "CLIENT" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de PLANNING 
     -- s'il n'existe pas d'occurrence correspondante dans la table MONITEUR.

     select count(*) into numrows
     from MONITEUR
     where
          :new.N°MONITEUR = MONITEUR.N°MONITEUR;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "PLANNING" car "MONITEUR" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de PLANNING 
     -- s'il n'existe pas d'occurrence correspondante dans la table MODÉLE.

     select count(*) into numrows
     from MODÉLE
     where
          :new.CODE_MODÉLE = MODÉLE.CODE_MODÉLE;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "PLANNING" car "MODÉLE" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : EXAM_PERMIS
-- ------------------------------------------------------------------------------- 

drop trigger TU_EXAM_PERMIS;

-- Trigger de modification ----------------------------------------------
create trigger TU_EXAM_PERMIS
after update on EXAM_PERMIS for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- CLIENT.

     if
          :old.N°_CLIENT <> :new.N°_CLIENT or 
          :old.ID_EXAM <> :new.ID_EXAM
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "CLIENT" interdite.');
     end if;
     -- Interdire la modification de la clé étrangère référençant la table 
     -- EXAM.

     if
          :old.N°_CLIENT <> :new.N°_CLIENT or 
          :old.ID_EXAM <> :new.ID_EXAM
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "EXAM" interdite.');
     end if;

end;
/

drop trigger TI_EXAM_PERMIS;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_EXAM_PERMIS
after insert on EXAM_PERMIS for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de EXAM_PERMIS 
     -- s'il n'existe pas d'occurrence correspondante dans la table CLIENT.

     select count(*) into numrows
     from CLIENT
     where
          :new.N°_CLIENT = CLIENT.N°_CLIENT;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "EXAM_PERMIS" car "CLIENT" n''existe pas.');
     end if;
     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de EXAM_PERMIS 
     -- s'il n'existe pas d'occurrence correspondante dans la table EXAM.

     select count(*) into numrows
     from EXAM
     where
          :new.ID_EXAM = EXAM.ID_EXAM;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "EXAM_PERMIS" car "EXAM" n''existe pas.');
     end if;

end;
/



-- ------------------------------------------------------------------------------- 
--   Table : H_N°LEÇON_LEÇON
-- ------------------------------------------------------------------------------- 

drop trigger TU_H_N°LEÇON_LEÇON;

-- Trigger de modification ----------------------------------------------
create trigger TU_H_N°LEÇON_LEÇON
after update on H_N°LEÇON_LEÇON for each row
declare numrows INTEGER;
begin

     -- Interdire la modification de la clé étrangère référençant la table 
     -- LEÇON.

     if
          :old.N°LEÇON <> :new.N°LEÇON or 
          :old.DATE_HISTO <> :new.DATE_HISTO
     then
               raise_application_error(
               -20008,
               'Modification de la clé étrangère référençant "LEÇON" interdite.');
     end if;

end;
/

drop trigger TI_H_N°LEÇON_LEÇON;

-- Trigger d'insertion ----------------------------------------------
create trigger TI_H_N°LEÇON_LEÇON
after insert on H_N°LEÇON_LEÇON for each row
declare numrows INTEGER;
begin

     -- Sauf valeur nulle autorisée, interdire la création d'une occurrence de H_N°LEÇON_LEÇON 
     -- s'il n'existe pas d'occurrence correspondante dans la table LEÇON.

     select count(*) into numrows
     from LEÇON
     where
          :new.N°LEÇON = LEÇON.N°LEÇON;
     if 
          (
          numrows = 0 
          )
     then
          raise_application_error(
               -20002,
               'Impossible d''ajouter "H_N°LEÇON_LEÇON" car "LEÇON" n''existe pas.');
     end if;

end;
/



