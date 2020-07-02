<?php
 function registerpost(){
 	include 'includes/config.php';
 	if($_POST['register']){
 		// #
 		// # Vars detect
 		// #
 		$gender = $_POST['gender'];

 		$username     = htmlspecialchars($_POST['username']);
 		$email        = htmlspecialchars($_POST['email']);
 		$password     = htmlspecialchars($_POST['password']);
 		$repassword   = htmlspecialchars($_POST['repassword']);
 		$country      = htmlspecialchars($_POST['country']);
 		$state        = htmlspecialchars($_POST['state']);
 		$city         = htmlspecialchars($_POST['city']);
 		$nationality  = htmlspecialchars($_POST['nationality']);
 		$religon      = htmlspecialchars($_POST['religon']);
 		$type         = htmlspecialchars($_POST['type']);
 		$zwaj_type    = htmlspecialchars($_POST['zwaj_type']);
 		$age          = htmlspecialchars($_POST['age']);
 		$childrens_num= htmlspecialchars($_POST['childrens_num']);
 		$weight       = htmlspecialchars($_POST['weight']);
 		$tall         = htmlspecialchars($_POST['tall']);
 		$skin_color   = htmlspecialchars($_POST['skin_color']);
 		$body_type    = htmlspecialchars($_POST['body_type']);
 		$religon1     = htmlspecialchars($_POST['religon1']);
 		$religon2     = htmlspecialchars($_POST['religon2']);
 		$religon3     = htmlspecialchars($_POST['religon3']);
 		$religon4     = htmlspecialchars($_POST['religon4']);
 		$education    = htmlspecialchars($_POST['education']);
 		$money        = htmlspecialchars($_POST['money']);
 		$work         = htmlspecialchars($_POST['work']);
 		$salary       = htmlspecialchars($_POST['salary']);
 		$health       = htmlspecialchars($_POST['health']);
 		$hiv_years    = htmlspecialchars($_POST['hiv_years']);
 		$lovebio      = htmlspecialchars($_POST['lovebio']);
 		$bio          = htmlspecialchars($_POST['bio']);
 		$full_name    = htmlspecialchars($_POST['full_name']);
 		$phone_number = htmlspecialchars($_POST['phone_number']);
 		// #
 		// # special vars
 		// #
 		$usr_img      = '';
 		$usr_online   = '0';
 		$account_type = '0';
 		$ban          = '0';

 		//CHECK
 		if(strlen($username) <= 4){
 			echo '
 			 <div class="procwarn">
 			  <p>خطأ</p>
 			  <span>إسم المستخدم يجب ان يكون اطول , رجاءً اعد كتابه البيانات بدقه اكثر</span>
 			 </div>
 			';
 		}else{
 		if(strlen($password) <= 5 or strlen($repassword) <= 5){
 			echo '
 			 <div class="procwarn">
 			  <p>خطأ</p>
 			  <span>يجب ان تكون كلمه المرور اقوى من ما تم كتابته , رجاءً اعد كتابه البيانات بدقه اكثر</span>
 			 </div>
 			';
 		}else{
 			if($password == $repassword){
 				if($state == 0){
 			echo '
 			 <div class="procwarn">
 			  <p>خطأ</p>
 			  <span>اختر المنطقه فضلاً , رجاءً اعد كتابه البيانات بدقه اكثر</span>
 			 </div>
 			';	
 				}else{
 					if(empty($full_name) or empty($phone_number)){
 			echo '
 			 <div class="procwarn">
 			  <p>خطأ</p>
 			  <span>قد تكون تركت بعض الحقول فارغه , رجاءً اعد كتابه البيانات بدقه اكثر</span>
 			 </div>
 			';	 						
 					}else{
 			//
 		    //
 			//
 			$query_find_users = $mysqli->query("SELECT * FROM `users` WHERE `username`='".$username."'");
 			$qfu_num_rows     = $query_find_users->num_rows;
 			
 			if($qfu_num_rows == 0){
 			$query_find_email = $mysqli->query("SELECT * FROM `users` WHERE `email`='".$email."'");
 			$qfe_num_rows     = $query_find_email->num_rows;

 			if($qfe_num_rows == 0){
 			//
 			// insert
			 // user data
			$password = md5($password);
 			$query_user_insert = $mysqli->query("INSERT INTO `users` (`username`,`password`,`email`,`country`,`state`,`city`,`nationality`,`religon`,`zwaj_type`,`type`,`age`,`childrens_num`,`weight`,`tall`,`skin_color`,`body_type`,`religon1`,`religon2`,`religon3`,`religon4`,`education`,`money`,`work`,`salary`,`health`,`hiv_years`,`gender`,`lovebio`,`bio`,`full_name`,`phone_number`,`usr_img`,`usr_online`,`account_type`,`ban`) VALUES ('$username','$password','$email','$country','$state','$city','$nationality','$religon','$zwaj_type','$type','$age','$childrens_num','$weight','$tall','$skin_color','$body_type','$religon1','$religon2','$religon3','$religon4','$education','$money','$work','$salary','$health','$hiv_years','$gender','$lovebio','$bio','$full_name','$phone_number','$usr_img','$usr_online','$account_type','$ban')");
 			if($query_user_insert){
 				echo '
 			 <div class="procwarn">
 			  <p>شكراً '.$full_name.'</p>
 			  <span>تم تسجيل حسابك لدينا , ويمكنك تسجيل الدخول الان عبر البريد الالكتروني و كلمه المرور من <a href="login">هنا</a><br/>
 			  يمكنك تفقد بريدك الالكتروني لمزيد من المعلومات.
 			  </span>
 			 </div>
 				';
 				exit;
 			}else{
            echo $mysqli->error;
 			echo '
 			 <div class="procwarn">
 			  <p>حدثت مشكله</p>
 			  <span>حدثت بعض المشاكل التقنيه , برجاء مراجعه الإداره</span>
 			 </div>
 			';
 			}

 			//
 			}else{
  			// problem detected
 			// user is already exist in the database
 			echo '
 			 <div class="procwarn">
 			  <p>خطأ</p>
 			  <span>البريد الإلكتروني تم استخدامه مسبقاً , رجاءً اعد كتابه البيانات بدقه اكثر, اذا كنت تواجه مشاكل في تسجيل الدخول عبر حسابك الاصلي رجاءً حاول الإتصال بنا.</span>
 			 </div>
 			';
 			}

 			}else{
 			// problem detected
 			// user is already exist in the database
 			echo '
 			 <div class="procwarn">
 			  <p>خطأ</p>
 			  <span>اسم المستخدم تم استخدامه مسبقاً , رجاءً اعد كتابه البيانات بدقه اكثر, اذا كنت تواجه مشاكل في تسجيل الدخول عبر حسابك الاصلي رجاءً حاول الإتصال بنا.</span>
 			 </div>
 			';
 			}

 			//
 			//
 			//
 					}
 				}
 			}else{
 			echo '
 			 <div class="procwarn">
 			  <p>خطأ</p>
 			  <span>كلمتا المرور غير متطابقتين , رجاءً اعد كتابه البيانات بدقه اكثر</span>
 			 </div>
 			';
 			}
 		}
 	    }

 	}

 }
?>