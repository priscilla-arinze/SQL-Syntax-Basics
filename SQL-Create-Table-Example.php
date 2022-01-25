<html>
   <head>
      <title>Creating MySQL Table</title>
   </head>
   <body>
      <?php
         $dbhost = 'localhost';
         $dbuser = 'root';
         $dbpass = 'root@123';
         $dbname = 'TUTORIALS';
         $mysqli = new mysqli($dbhost, $dbuser, $dbpass, $dbname);
         
         if($mysqli->connect_errno ) {
            printf("Connect failed: %s<br />", $mysqli->connect_error);
            exit();
         }
         printf('Connected successfully.<br />');
   
         $sql = "CREATE TABLE tutorials_tbl( ".
            "tutorial_id INT NOT NULL AUTO_INCREMENT, ".
            "tutorial_title VARCHAR(100) NOT NULL, ".
            "tutorial_author VARCHAR(40) NOT NULL, ".
            "submission_date DATE, ".
            "PRIMARY KEY ( tutorial_id )); ";
         if ($mysqli->query($sql)) {
            printf("Table tutorials_tbl created successfully.<br />");
         }
         if ($mysqli->errno) {
            printf("Could not create table: %s<br />", $mysqli->error);
         }

         $mysqli->close();
      ?>
   </body>
</html>