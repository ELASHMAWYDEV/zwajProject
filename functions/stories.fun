<?php

function storiesShow(){
   include 'includes/config.php';

   $usrGender     = $mysqli->query("SELECT * FROM `stories`");


   $results_per_page   = 2;


   if(!isset($_GET['page'])){
     $page = 1;
   }else{
     $page = $_GET['page'];
   }

   $this_page_first_result = ($page-1)*$results_per_page;

   $queryGetUsersP = $mysqli->query("SELECT * FROM `stories` ORDER BY `s` DESC");
   $queryGetUsers  = $mysqli->query("SELECT * FROM `stories` ORDER BY `s` DESC LIMIT $this_page_first_result,$results_per_page");

   $num_of_results     = $queryGetUsersP->num_rows;
   $num_of_pages = ceil($num_of_results / $results_per_page);

   while($row = $queryGetUsers->fetch_assoc()){
       
       echo '
    <div class="storypar">
     <p>'.$row['from_id'].'</p> <date>'.$row['date'].'</date>
     <text>'.$row['text'].'</text>
    </div>       
       ';
       
       
   }

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