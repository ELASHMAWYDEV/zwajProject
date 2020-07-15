<?php
 function loginform(){
    include 'includes/config.php';

    if($_POST['submit']){


 	$email = htmlspecialchars($_POST['email']);
 	$password = htmlspecialchars($_POST['password']);
 	if(empty($email) or empty($password)){
 	echo '
 	<div id="log">
 	 <p>تنبيه</p>
 	 <span>بعض الحقول فارغه</span>
 	</div>
 	';
 	}else{
	$password = md5($password);
 	$query_login = $mysqli->query("SELECT * FROM `users` WHERE `email`='$email' AND `password`='$password'");
 	$query_num   = $query_login->num_rows;
 	if($query_num == 0){
 	echo '
 	<div id="log">
 	 <p>تنبيه</p>
 	 <span>بعض البيانات المدخله خاطئه , اعد المحاوله.</span>
 	</div>
 	';
 	}else{
 		$query_data = $query_login->fetch_assoc();
 		if($query_data['ban'] == 1){
 	echo '
 	<div id="log">
 	 <p>تنبيه</p>
 	 <span>الحساب الذي تحاول الوصول اليه تم حظره , برجاء <a href="#">اتصل بنا</a></span>
 	</div>
 	';
 		}else{
 			$_SESSION['id'] = $query_data['id'];
			$_SESSION['username'] = $query_data['username'];
			$_SESSION['email'] = $query_data['email'];

			//update membership status
			if(strtotime($query_data['special_account_deadline']) < time());
				$mysqli->query("UPDATE users SET account_type = '0' WHERE id = " . $_SESSION['id'] . " LIMIT 1");

 			header("location: dashboard");
 		}
 	}

 	}
 }


}
 
?>