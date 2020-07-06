<?php
 function sessionCheck(){
 	include 'includes/config.php';

 	if($_SESSION['id']){
 		header("location: dashboard");
 	}
 }
 function usrSearch(){
 	include 'includes/config.php';

 	$mysql_usr_gender = $mysqli->query("SELECT * FROM `users` WHERE `id`= '" . $_SESSION['id'] . "'");
 	$fetch_usr_gender = $mysql_usr_gender->fetch_assoc();

 	if($fetch_usr_gender['gender'] == 1){
 		echo 'البحث عن زوجه';
 	}else{
 		echo 'البحث عن زوج';
 	}
 }
 function navLogout(){
 	include 'includes/config.php';

 	if($_SESSION['id']){
 		echo '
 	     <a href="logout"><i class="fas fa-sign-out-alt"></i> خروج</a>
 		';
 	}else{
 		echo '';
 	}
 }
 function navCheck(){
 	include 'includes/config.php';

 	if($_SESSION['id']){
 	echo '
 	<a href="user"><i class="far fa-user"></i> '.$_SESSION['username'].' </a>
 	<a href="chat"> <i class="fas fa-sms"></i> المحادثات</a>
 	';
 	}else{
 	echo '
 	<a href="register"><i class="far fa-user"></i> تسجيل </a>
 	<a href="login"><i class="fas fa-sign-in-alt"></i> دخول</a>
 	';
 	}
 }
 function states($x){

 }

  function username(){
    include 'includes/config.php';
    $usr = $_SESSION['id'];

    $sql = $mysqli->query("SELECT * FROM `users` WHERE `id`='$usr'");
    $get = $sql->fetch_assoc();
    echo $get['username'];
    
  }

  function email(){
    include 'includes/config.php';
    $usr = $_SESSION['id'];

    $sql = $mysqli->query("SELECT * FROM `users` WHERE `id`='$usr'");
    $get = $sql->fetch_assoc();
    echo $get['email'];
    
  }

  function lovebio(){
    include 'includes/config.php';
    $usr = $_SESSION['id'];

    $sql = $mysqli->query("SELECT * FROM `users` WHERE `id`='$usr'");
    $get = $sql->fetch_assoc();
    if($get['lovebio'] == ''){
     echo 'لا يوجد بيانات';
    }else{
     echo $get['lovebio'];
    }
    
  }
  function bio(){
    include 'includes/config.php';
    $usr = $_SESSION['id'];

    $sql = $mysqli->query("SELECT * FROM `users` WHERE `id`='$usr'");
    $get = $sql->fetch_assoc();
    if($get['bio'] == ''){
     echo 'لا يوجد بيانات';
    }else{
     echo $get['bio'];
    }

  }


 function lastusers(){
    include 'includes/config.php';
    $lastusers = $mysqli->query("SELECT * FROM `users` ORDER BY `id` DESC LIMIT 6");
    
    while($row = $lastusers->fetch_assoc()){
        echo '
         <div class="user"> 
  <img src="theme/img/men.png" />
  <div class="info">
   <p>'.$row['username'].'</p>
   <label><i class="fas fa-globe-europe"></i>';
        if($row['country'] == 'ksa')
        {
            echo 'السعودية';
        }
        if($row['country'] == 'eg')
        {
            echo 'مصر';
        }
        if($row['country'] == 'uae')
        {
            echo 'الامارات';
        }
        if($row['country'] == 'oman')
        {
            echo 'عمان';
        }
        if($row['country'] == 'lebanon')
        {
            echo 'لبنان';
        }
        if($row['country'] == 'morocco')
        {
            echo 'المغرب';
        }
        if($row['country'] == 'algeria')
        {
            echo 'الجزائر';
        }
        if($row['country'] == 'tunisia')
        {
            echo 'تونس';
        }
        if($row['country'] == 'bahrain')
        {
            echo 'البحرين';
        }
        if($row['country'] == 'palestine')
        {
            echo 'فلسطين المحتلة';
        }
        if($row['country'] == 'jordon')
        {
            echo 'الأردن';
        }
        if($row['country'] == 'yamn')
        {
            echo 'اليمن';
        }
        if($row['country'] == 'iraq')
        {
            echo 'العراق';
        }
        if($row['country'] == 'syria')
        {
            echo 'سوريا';
        }
        if($row['country'] == 'sudan')
        {
            echo 'السودان';
        }
   echo '</label>
   <label><i class="fas fa-venus-mars"></i> ';
   if($row['gender'] == 1){
       echo 'ذكر';
   }
   if($row['gender'] == 2){
       echo 'انثى';
   }
   echo '</label>
   <a href="profile?id='.$row['id'].'"><i class="far fa-user"></i> تفقد البيانات</a>
  </div>
 </div>
        ';
    }
 }



  function userCheck(){
    include 'includes/config.php';
    $usr = $_SESSION['id'];

    $sql = $mysqli->query("SELECT * FROM `users` WHERE `id`='$usr'");
    $get = $sql->fetch_assoc();
    if($get['account_type'] == 0)
    {
      echo '<b>عضويه عاديه</b>';

    }
    else
    {
      echo '<span><i class="fas fa-star"></i> عضويه مميزه</span>';
    }
    
  }

 function usrList(){
   include 'includes/config.php';

   $usrGender     = $mysqli->query("SELECT * FROM `users` WHERE `id`='".$_SESSION['id']."'");
   $usrGF         = $usrGender->fetch_assoc();
   $usrgenderl    = $usrGF['gender'];
   if($usrgenderl == 1){
     $search = 2;
   }
   if($usrgenderl == 2){
     $search = 1;
   }


   $results_per_page   = 8;


   if(!isset($_GET['page'])){
     $page = 1;
   }else{
     $page = $_GET['page'];
   }

   $this_page_first_result = ($page-1)*$results_per_page;

   $queryGetUsersP = $mysqli->query("SELECT * FROM `users` WHERE `gender`='$search'");
   $queryGetUsers  = $mysqli->query("SELECT * FROM `users` WHERE `gender`='$search' LIMIT $this_page_first_result,$results_per_page");

   $num_of_results = $queryGetUsersP->num_rows;
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

   echo '<div class="pages">';
   for($page=1;$page<=$num_of_pages;$page++){
     echo '<a href="?page='.$page.'#'.base64_encode(time()).'" ';
     if($_GET['page'] == $page){
       echo 'class="_selected"';
     }
     echo '>'.$page.'</a>';
   }
   echo '</div>';


 }
?>
