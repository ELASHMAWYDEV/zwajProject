<?php
 function search_results(){
   include 'includes/config.php';
   if($_POST['state'] == 'N'){
       echo 'حدد المنطقة';
   }
     if($_POST['malesearch']){
         
        if($_POST['state'] == '0'){
            
            
   $usrGender     = $mysqli->query("SELECT * FROM `users` WHERE `gender`=1");
   $usrGF         = $usrGender->fetch_assoc();
   $usrgenderl    = $usrGF['gender'];


   $results_per_page   = 1000;


   if(!isset($_GET['page'])){
     $page = 1;
   }else{
     $page = $_GET['page'];
   }

   $this_page_first_result = ($page-1)*$results_per_page;

   $queryGetUsersP = $mysqli->query("SELECT * FROM `users` WHERE `gender`=1");
   $queryGetUsers  = $mysqli->query("SELECT * FROM `users` WHERE `gender`=1 LIMIT $this_page_first_result,$results_per_page");

   $num_of_results     = $queryGetUsersP->num_rows;
   $num_of_pages = ceil($num_of_results / $results_per_page);

   echo '<div id="loadusrs">';
   while($row = $queryGetUsers->fetch_assoc()){

     echo '
     <div class="user">
     ';
     if($row['usr_img'] == ''){
       if($row['gender'] == 1){
         echo '<img src="theme/img/men.png" />';
       }
       if($row['gender'] == 2){
         echo '<img src="theme/img/women.png" />';
       }
     }else{
         echo '<img src="uploads/'.$row['usr_img'].'" />';

     }
     echo '
      <div class="info">
       <p>'.$row['username'].'</p>
       <label><i class="fas fa-globe-europe"></i> ';
       $x = $row['state'];
       if($x == 1){
         echo 'الرياض';
       }
       if($x == 2){
         echo 'مكة';
       }
       if($x == 3){
         echo 'المدينة';
       }
       if($x == 4){
         echo 'القصيم';
       }
       if($x == 5){
         echo 'المنطقة الشرقية';
       }
       if($x == 6){
         echo  'عسير';
       }
       if($x == 7){
         echo 'تبوك';
       }
       if($x == 8){
         echo 'حائل';
       }
       if($x == 9){
         echo 'الحدود الشمالية';
       }
       if($x == 10){
         echo 'جازان';
       }
       if($x == 11){
         echo 'نجران';
       }
       if($x == 12){
         echo 'الباحة';
       }
       if($x == 13){
         echo 'الجوف';
       }
       echo '</label>
       <label><i class="fas fa-venus-mars"></i> ';
       if($row['gender'] == 1){
         echo 'ذكر';
       }else{
         echo 'انثى';
       }
       echo '</label>
       <label><i class="fas fa-question"></i> ';
       if($row['type'] == 1){
         echo 'اعزب';
       }
       if($row['type'] == 2){
         echo 'متزوج';
       }
       if($row['type'] == 3){
         echo 'مطلق';
       }
       if($row['type'] == 4){
         echo 'أرمل';
       }

       echo '</label>
       <label><a href="profile?id='.$row['id'].'#/'.$row['username'].'/"><i class="fas fa-paper-plane"></i> مراسله</a></label>
      </div>
     </div>
     ';
   }
   echo '</div>';



            
            
        }else{
            //select as $STATE
            
            
            
            
   $state = $_POST['state'];
            
   $usrGender     = $mysqli->query("SELECT * FROM `users` WHERE `gender`=1 AND `state`='$state'");
            
   $usrGenderN    = $usrGender->num_rows;
            
   if($usrGenderN == 0){
       echo 'لا يوجد بيانات متاحه';
   }
   $usrGF         = $usrGender->fetch_assoc();
   $usrgenderl    = $usrGF['gender'];


   $results_per_page   = 1000;


   if(!isset($_GET['page'])){
     $page = 1;
   }else{
     $page = $_GET['page'];
   }

   $this_page_first_result = ($page-1)*$results_per_page;

   $queryGetUsersP = $mysqli->query("SELECT * FROM `users` WHERE `gender`=1 AND `state`='$state'");
   $queryGetUsers  = $mysqli->query("SELECT * FROM `users` WHERE `gender`=1 AND `state`='$state' LIMIT $this_page_first_result,$results_per_page");

   $num_of_results     = $queryGetUsersP->num_rows;
   $num_of_pages = ceil($num_of_results / $results_per_page);

   echo '<div id="loadusrs">';
   while($row = $queryGetUsers->fetch_assoc()){

     echo '
     <div class="user">
     ';
     if($row['usr_img'] == ''){
       if($row['gender'] == 1){
         echo '<img src="theme/img/men.png" />';
       }
       if($row['gender'] == 2){
         echo '<img src="theme/img/women.png" />';
       }
     }else{
         echo '<img src="uploads/'.$row['usr_img'].'" />';

     }
     echo '
      <div class="info">
       <p>'.$row['username'].'</p>
       <label><i class="fas fa-globe-europe"></i> ';
       $x = $row['state'];
       if($x == 1){
         echo 'الرياض';
       }
       if($x == 2){
         echo 'مكة';
       }
       if($x == 3){
         echo 'المدينة';
       }
       if($x == 4){
         echo 'القصيم';
       }
       if($x == 5){
         echo 'المنطقة الشرقية';
       }
       if($x == 6){
         echo  'عسير';
       }
       if($x == 7){
         echo 'تبوك';
       }
       if($x == 8){
         echo 'حائل';
       }
       if($x == 9){
         echo 'الحدود الشمالية';
       }
       if($x == 10){
         echo 'جازان';
       }
       if($x == 11){
         echo 'نجران';
       }
       if($x == 12){
         echo 'الباحة';
       }
       if($x == 13){
         echo 'الجوف';
       }
       echo '</label>
       <label><i class="fas fa-venus-mars"></i> ';
       if($row['gender'] == 1){
         echo 'ذكر';
       }else{
         echo 'انثى';
       }
       echo '</label>
       <label><i class="fas fa-question"></i> ';
       if($row['type'] == 1){
         echo 'اعزب';
       }
       if($row['type'] == 2){
         echo 'متزوج';
       }
       if($row['type'] == 3){
         echo 'مطلق';
       }
       if($row['type'] == 4){
         echo 'أرمل';
       }

       echo '</label>
       <label><a href="profile?id='.$row['id'].'#/'.$row['username'].'/"><i class="fas fa-paper-plane"></i> مراسله</a></label>
      </div>
     </div>
     ';
   }
   echo '</div>';
            
            
            
            
            
            
            
            
            
        }
     }
     
     
     /*
     
     
     
     Search
     for females
     
     
     
     */
     if($_POST['femalesearch']){
   if($_POST['state'] == 'N'){
       echo 'حدد المنطقة';
   }
    if($_POST['state'] == '0'){
            
            
   $usrGender     = $mysqli->query("SELECT * FROM `users` WHERE `gender`=2");
   $usrGF         = $usrGender->fetch_assoc();
   $usrgenderl    = $usrGF['gender'];


   $results_per_page   = 1000;


   if(!isset($_GET['page'])){
     $page = 1;
   }else{
     $page = $_GET['page'];
   }

   $this_page_first_result = ($page-1)*$results_per_page;

   $queryGetUsersP = $mysqli->query("SELECT * FROM `users` WHERE `gender`=2");
   $queryGetUsers  = $mysqli->query("SELECT * FROM `users` WHERE `gender`=2 LIMIT $this_page_first_result,$results_per_page");

   $num_of_results     = $queryGetUsersP->num_rows;
   $num_of_pages = ceil($num_of_results / $results_per_page);

   echo '<div id="loadusrs">';
   while($row = $queryGetUsers->fetch_assoc()){

     echo '
     <div class="user">
     ';
     if($row['usr_img'] == ''){
       if($row['gender'] == 1){
         echo '<img src="theme/img/men.png" />';
       }
       if($row['gender'] == 2){
         echo '<img src="theme/img/women.png" />';
       }
     }else{
         echo '<img src="uploads/'.$row['usr_img'].'" />';

     }
     echo '
      <div class="info">
       <p>'.$row['username'].'</p>
       <label><i class="fas fa-globe-europe"></i> ';
       $x = $row['state'];
       if($x == 1){
         echo 'الرياض';
       }
       if($x == 2){
         echo 'مكة';
       }
       if($x == 3){
         echo 'المدينة';
       }
       if($x == 4){
         echo 'القصيم';
       }
       if($x == 5){
         echo 'المنطقة الشرقية';
       }
       if($x == 6){
         echo  'عسير';
       }
       if($x == 7){
         echo 'تبوك';
       }
       if($x == 8){
         echo 'حائل';
       }
       if($x == 9){
         echo 'الحدود الشمالية';
       }
       if($x == 10){
         echo 'جازان';
       }
       if($x == 11){
         echo 'نجران';
       }
       if($x == 12){
         echo 'الباحة';
       }
       if($x == 13){
         echo 'الجوف';
       }
       echo '</label>
       <label><i class="fas fa-venus-mars"></i> ';
       if($row['gender'] == 1){
         echo 'ذكر';
       }else{
         echo 'انثى';
       }
       echo '</label>
       <label><i class="fas fa-question"></i> ';
       if($row['type'] == 1){
         echo 'اعزب';
       }
       if($row['type'] == 2){
         echo 'متزوج';
       }
       if($row['type'] == 3){
         echo 'مطلق';
       }
       if($row['type'] == 4){
         echo 'أرمل';
       }

       echo '</label>
       <label><a href="profile?id='.$row['id'].'#/'.$row['username'].'/"><i class="fas fa-paper-plane"></i> مراسله</a></label>
      </div>
     </div>
     ';
   }
   echo '</div>';



            
            
        }else{
            //select as $STATE
        
                 
   $state = $_POST['state'];
            
   $usrGender     = $mysqli->query("SELECT * FROM `users` WHERE `gender`=2 AND `state`='$state'");
            
   $usrGenderN    = $usrGender->num_rows;
            
   if($usrGenderN == 0){
       echo 'لا يوجد بيانات متاحه';
   }
   $usrGF         = $usrGender->fetch_assoc();
   $usrgenderl    = $usrGF['gender'];


   $results_per_page   = 1000;


   if(!isset($_GET['page'])){
     $page = 1;
   }else{
     $page = $_GET['page'];
   }

   $this_page_first_result = ($page-1)*$results_per_page;

   $queryGetUsersP = $mysqli->query("SELECT * FROM `users` WHERE `gender`=2 AND `state`='$state'");
   $queryGetUsers  = $mysqli->query("SELECT * FROM `users` WHERE `gender`=2 AND `state`='$state' LIMIT $this_page_first_result,$results_per_page");

   $num_of_results     = $queryGetUsersP->num_rows;
   $num_of_pages = ceil($num_of_results / $results_per_page);

   echo '<div id="loadusrs">';
   while($row = $queryGetUsers->fetch_assoc()){

     echo '
     <div class="user">
     ';
     if($row['usr_img'] == ''){
       if($row['gender'] == 1){
         echo '<img src="theme/img/men.png" />';
       }
       if($row['gender'] == 2){
         echo '<img src="theme/img/women.png" />';
       }
     }else{
         echo '<img src="uploads/'.$row['usr_img'].'" />';

     }
     echo '
      <div class="info">
       <p>'.$row['username'].'</p>
       <label><i class="fas fa-globe-europe"></i> ';
       $x = $row['state'];
       if($x == 1){
         echo 'الرياض';
       }
       if($x == 2){
         echo 'مكة';
       }
       if($x == 3){
         echo 'المدينة';
       }
       if($x == 4){
         echo 'القصيم';
       }
       if($x == 5){
         echo 'المنطقة الشرقية';
       }
       if($x == 6){
         echo  'عسير';
       }
       if($x == 7){
         echo 'تبوك';
       }
       if($x == 8){
         echo 'حائل';
       }
       if($x == 9){
         echo 'الحدود الشمالية';
       }
       if($x == 10){
         echo 'جازان';
       }
       if($x == 11){
         echo 'نجران';
       }
       if($x == 12){
         echo 'الباحة';
       }
       if($x == 13){
         echo 'الجوف';
       }
       echo '</label>
       <label><i class="fas fa-venus-mars"></i> ';
       if($row['gender'] == 1){
         echo 'ذكر';
       }else{
         echo 'انثى';
       }
       echo '</label>
       <label><i class="fas fa-question"></i> ';
       if($row['type'] == 1){
         echo 'اعزب';
       }
       if($row['type'] == 2){
         echo 'متزوج';
       }
       if($row['type'] == 3){
         echo 'مطلق';
       }
       if($row['type'] == 4){
         echo 'أرمل';
       }

       echo '</label>
       <label><a href="profile?id='.$row['id'].'#/'.$row['username'].'/"><i class="fas fa-paper-plane"></i> مراسله</a></label>
      </div>
     </div>
     ';
   }
   echo '</div>';
            
        
        
        }
         
         
         
         
     }
     
     
     
 }
?>