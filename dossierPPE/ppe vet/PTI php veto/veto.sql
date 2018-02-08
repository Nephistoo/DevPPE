-- MySQL dump 10.13  Distrib 5.1.32, for Win32 (ia32)
--
-- Host: localhost    Database: veto
-- ------------------------------------------------------
-- Server version	5.1.32-community-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `animal`
--

DROP TABLE IF EXISTS `animal`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `animal` (
  `numa` int(11) NOT NULL AUTO_INCREMENT,
  `noma` char(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datenaissa` date DEFAULT NULL,
  `tatouage` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `numr` int(11) NOT NULL,
  `nump` int(11) NOT NULL,
  PRIMARY KEY (`numa`),
  KEY `numr` (`numr`),
  KEY `nump` (`nump`),
  CONSTRAINT `animal_ibfk_1` FOREIGN KEY (`numr`) REFERENCES `race` (`numr`),
  CONSTRAINT `animal_ibfk_2` FOREIGN KEY (`nump`) REFERENCES `proprietaire` (`nump`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `animal`
--

LOCK TABLES `animal` WRITE;
/*!40000 ALTER TABLE `animal` DISABLE KEYS */;
INSERT INTO `animal` VALUES (2,'Elan','1980-10-02','ERT502','',3,3),(3,'Démon','1985-06-05',NULL,'',3,3),(4,'Zoé','2000-12-09','Zen245','',3,3),(5,'Nina','1996-01-14','DFG001','5_photo.jpg',2,1),(6,'Niok','2000-08-01','OIU115','',15,1),(7,'Jeune alf','2001-03-30','AM324','',14,2),(8,'Pollen','2007-09-27','JF851','',4,2),(9,'Jafna','1996-05-23','BNJ145','',5,4),(10,'Fabel','1995-10-24','BNA485','',5,4),(11,'Tanis','1994-06-30','BUI416','',16,4),(12,'Rio','1994-06-30','KIU521','',5,4),(13,'Bipsie','1985-04-06','DZE445','',8,5),(14,'Bouboule','1995-01-01','MPO444','',6,5),(15,'Nouki','2009-05-18','HMQ8308','',9,6),(24,'frfthrtd','2001-01-01','jyhgjgf','25_photo.jpg',2,1),(25,'TATA','1980-10-01','lfdkjk','26_photo.jpg',2,1),(26,'trcu','2001-01-01','utuyf','27_photo.jpg',2,1),(27,'ghujg','2001-01-01','jugjhg','28_photo.jpg',2,1);
/*!40000 ALTER TABLE `animal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultation`
--

DROP TABLE IF EXISTS `consultation`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `consultation` (
  `numc` int(11) NOT NULL AUTO_INCREMENT,
  `datec` date DEFAULT NULL,
  `heurec` time DEFAULT NULL,
  `prixc` decimal(13,2) DEFAULT NULL,
  `numa` int(11) NOT NULL,
  PRIMARY KEY (`numc`),
  KEY `numa` (`numa`),
  CONSTRAINT `consultation_ibfk_1` FOREIGN KEY (`numa`) REFERENCES `animal` (`numa`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `consultation`
--

LOCK TABLES `consultation` WRITE;
/*!40000 ALTER TABLE `consultation` DISABLE KEYS */;
INSERT INTO `consultation` VALUES (2,'2000-12-07','12:00:00','341.25',6),(3,'2001-09-05','09:15:00','425.00',2),(4,'1995-06-24','18:00:00','446.00',7),(5,'1998-05-10','12:30:00','275.00',10),(6,'1996-10-03','15:00:00','436.00',11),(7,'2003-06-22','09:15:00','215.00',10),(8,'1998-05-10','08:30:00','285.00',14),(9,'2000-11-02','14:30:00','393.00',4),(10,'1999-02-12','10:00:00','381.00',9),(11,'2000-11-07','13:15:00','268.80',15),(12,'1995-05-04','15:30:00','403.00',2),(13,'1996-08-26','09:30:00','341.25',15),(14,'1996-08-26','09:30:00','325.00',12),(15,'1995-05-04','15:30:00','423.15',5),(16,'1995-07-06','12:15:00','239.40',5),(17,'2004-10-18','11:00:00','295.05',15),(18,'2002-01-29','09:15:00','413.00',12),(23,'2001-10-05','10:10:00','200.00',2);
/*!40000 ALTER TABLE `consultation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicament`
--

DROP TABLE IF EXISTS `medicament`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `medicament` (
  `numm` int(11) NOT NULL AUTO_INCREMENT,
  `nomm` char(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prixm` decimal(13,2) DEFAULT NULL,
  PRIMARY KEY (`numm`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `medicament`
--

LOCK TABLES `medicament` WRITE;
/*!40000 ALTER TABLE `medicament` DISABLE KEYS */;
INSERT INTO `medicament` VALUES (1,'Vermifuge pate','35.00'),(2,'Vermifuge cachet','40.00'),(3,'Vaccin rage','86.00'),(4,'Vaccin Leucose','119.00'),(5,'Diuretique','45.00'),(6,'Croquettes 10 Kg','350.00');
/*!40000 ALTER TABLE `medicament` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescrire`
--

DROP TABLE IF EXISTS `prescrire`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `prescrire` (
  `numm` int(11) NOT NULL,
  `numc` int(11) NOT NULL,
  `posologie` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quantite` int(2) DEFAULT NULL,
  PRIMARY KEY (`numm`,`numc`),
  KEY `numc` (`numc`),
  CONSTRAINT `prescrire_ibfk_1` FOREIGN KEY (`numm`) REFERENCES `medicament` (`numm`),
  CONSTRAINT `prescrire_ibfk_2` FOREIGN KEY (`numc`) REFERENCES `consultation` (`numc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `prescrire`
--

LOCK TABLES `prescrire` WRITE;
/*!40000 ALTER TABLE `prescrire` DISABLE KEYS */;
INSERT INTO `prescrire` VALUES (1,2,'1/jour',2),(1,5,'1/jour',3),(2,15,'1 dose/jour',10),(3,5,'Dose unique',1),(3,11,'1',1),(5,2,'2/jour',5),(5,5,'2/jour',15),(6,6,'1/repas',7),(6,8,'1/repas',7),(6,15,'1/repas',5);
/*!40000 ALTER TABLE `prescrire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proprietaire`
--

DROP TABLE IF EXISTS `proprietaire`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `proprietaire` (
  `nump` int(11) NOT NULL AUTO_INCREMENT,
  `nomp` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prenomp` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `adrp` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `codep` int(5) DEFAULT NULL,
  `villep` char(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telp` int(10) DEFAULT NULL,
  PRIMARY KEY (`nump`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `proprietaire`
--

LOCK TABLES `proprietaire` WRITE;
/*!40000 ALTER TABLE `proprietaire` DISABLE KEYS */;
INSERT INTO `proprietaire` VALUES (1,'Février','Jean-Yves','13, rue de la republique',21000,'Dijon',328785965),(2,'Février','Frédérique','19, rue de la gare',98765,'Cnedville',145855844),(3,'Mars','Josette','4, rue des arbres',54000,'Nancy',478965877),(4,'Javelas','Henri','29, avenue de la libération',45000,'Orleans',269854789),(5,'Loriette','Sylvain','4, avenue fleurie',95000,'Cergy',125697842),(6,'Février','Jean-Yves','87, square des amis',14000,'Caen',257845454);
/*!40000 ALTER TABLE `proprietaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `race`
--

DROP TABLE IF EXISTS `race`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `race` (
  `numr` int(11) NOT NULL AUTO_INCREMENT,
  `nomr` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `poids` int(3) DEFAULT NULL,
  PRIMARY KEY (`numr`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `race`
--

LOCK TABLES `race` WRITE;
/*!40000 ALTER TABLE `race` DISABLE KEYS */;
INSERT INTO `race` VALUES (2,'Teckel sympa',7),(3,'Yorkshire',2),(4,'Chat gouttière',5),(5,'Saluki',20),(6,'Caniche royal',25),(8,'Caniche nain',5),(9,'Bâtard',NULL),(14,'Lapin bélier nain',6),(15,'Chat sphinx',3),(16,'Persan',3);
/*!40000 ALTER TABLE `race` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_user` (
  `id_user` int(2) NOT NULL,
  `login` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mdp` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_user`
--

LOCK TABLES `t_user` WRITE;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` VALUES (1,'admin','5f4dcc3b5aa765d61d8327deb882cf99');
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-06-10 20:55:18
