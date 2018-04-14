<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="https://v40.pingendo.com/assets/4.0.0/default/theme.css" type="text/css"> </head>

<body>
  <div class="py-5 bg-secondary">
    <div class="container">
      <div class="row bg-secondary"></div>
      <div class="row">
        <div class="col-md-12">
             <?php
    $a=$_POST['prixmin'];
    $b=$_POST['prixmax'];
    $c=$_POST['NumTypePro'];
    $d=$_POST['NomPro'];

    try
        {

        $bdd = new PDO('mysql:host=localhost;dbname=BDD', 'root', '');
        // connection a la base de donnees via Mysql

        }
     catch (Exception $e)
     // on capture l'erreur (l'exception)
         {

                 die('Erreur :' .$e->getMessage()); // en cas d'erreur, on affiche un message avec arret de l'execution de la page 
               } 
                 $reponse = $bdd->prepare("SELECT * FROM produit WHERE PrixPro between prixmin=? and prixmax=? and NumTypePro=? and NomPro like %?% ")or die(print_r($bdd->errorInfo()));
            $reponse->execute(array($a, $b, $c, $d)); 
            while($enreg=$reponse->fetch()) { ?>
             
          <table>
            <tbody>
              <tr>
                <th class="w-25 px-4" id="imageproduit">Image Produit</th>
                <th id="nomproduit" class="px-5 w-25">Nom Produit</th>
                <th id="prixproduit" class="px-5">Prix Produit</th>
                <th id="Commentaire" class="px-5">Commentaire</th>
              </tr>
              <tr>
                <td>
                  <img src=Image/<?php echo $enreg['NumPro']?> class="px-5"> </td>
                <td class="px-5">
                  
                  <p class="lead"><?php echo $enreg['NomPro']?> </p>
                </td>
                <td class="px-5">
                  
                  <h1 class=""><?php echo $enreg['PrixPro']; ?></h1>
                </td>
                <td class="px-5">
                  
                  <p class=""><?php echo $enreg['ComPro']; ?></p>
                </td>
              </tr>
            </tbody>
          </table>
          <?php } ?>
        </div>
      </div>
    </div>
  </div>
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <pingendo onclick="window.open('https://pingendo.com/', '_blank')" style="cursor:pointer;position: fixed;bottom: 10px;right:10px;padding:4px;background-color: #00b0eb;border-radius: 8px; width:180px;display:flex;flex-direction:row;align-items:center;justify-content:center;font-size:14px;color:white">Made with Pingendo&nbsp;&nbsp;
    <img src="https://pingendo.com/site-assets/Pingendo_logo_big.png" class="d-block" alt="Pingendo logo" height="16">
  </pingendo>
</body>

</html>