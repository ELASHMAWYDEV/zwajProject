<?php

function forgotproc(){
    include 'includes/config.php';
    if($_POST['submit']){
        $email = htmlspecialchars($_POST['email']);
        $sql   = $mysqli->query("SELECT * FROM `users` WHERE `email`='$email'");
        $num   = $sql->num_rows;
        if($num == 0){
            
        }else{
            $querypas = $sql->fetch_assoc();
            $password = $querypas['password'];
            
         $to = $email;
         $subject = "zwaj - استرجاع كلمه المرور";
         
         $message = "<b>كلمه المرور : ".$password."</b>";
         
         $header = "From:no-reply@zwaj.com \r\n";
         $header .= "Cc:no-reply@zwaj.com \r\n";
         $header .= "MIME-Version: 1.0\r\n";
         $header .= "Content-type: text/html\r\n";
         
         $retval = mail ($to,$subject,$message,$header);
         
         if( $retval == true ) {
            echo "<div class='okay'>تم إرسال التفاصيل إلى بريدك الإلكتروني</div>";
         }else {
            echo "<div class='okay'>حدثت مشكله برجاء مراسله الإداره</div>";
         }
            
            
        }
    }
}


?>