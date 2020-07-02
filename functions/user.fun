<?php
session_start();

function currentUsrImg(){
	include 'includes/config.php';

	$userid = $_SESSION['id'];
	$getimg = $mysqli->query("SELECT * FROM `users` WHERE `id`='$userid'");
	$getdata = $getimg->fetch_assoc();

	if($getdata['usr_img'] == ''){
		if($getdata['gender'] == '1'){
         echo '<img src="theme/img/men.png" />';
		}
		if($getdata['gender'] == '2'){
         echo '<img src="theme/img/women.png" />';
		}
	}else{
		echo '
		<img src="uploads/'.$getdata['usr_img'].'" />
		';
	}
}

function paymentList(){
	include 'includes/config.php';
    $u   = $_SESSION['id'];
    $sql = $mysqli->query("SELECT * FROM `payments` WHERE `id`='$u'");
    $num = $sql->num_rows;
    
    if($num == 0){
        echo 'لا يوجد مدفوعات';
    }else{
        
    }
    
}

function editBios(){



	include 'includes/config.php';
	if($_POST['editbios']){

	$u   = $_SESSION['id'];
	$bio = htmlspecialchars($_POST['bio']);
	$lovebio = htmlspecialchars($_POST['lovebio']);

	$sql = $mysqli->query("UPDATE `users` SET `bio`='$bio' WHERE `id`='$u'");
	$sql = $mysqli->query("UPDATE `users` SET `lovebio`='$lovebio' WHERE `id`='$u'");

	if($sql){
		echo '<div class="proc">تم تعديل البيانات بنجاح</div>';
		
	}else{
		echo '<div class="proc">حدث خطأ تقني</div>';
	}
  }
    
  if($_POST['editpassword']){
	$u   = $_SESSION['id'];
    $password = htmlspecialchars($_POST['password']);
    $repassword = htmlspecialchars($_POST['repassword']);
    if($password == $repassword){
     $sql = $mysqli->query("UPDATE `users` SET `password`='$password' WHERE `id`='$u'");
     if($sql){echo '<div class="proc">تم تعديل كلمه المرور</div>';}else{
         echo '<div class="proc">هناك مشكله</div>';
     }
    }else{
        echo '<div class="proc">كلمتا المرور غير متطابقتين</div>';
    }
  }
    
}

function usrImgUpdate(){
	include 'includes/config.php';
	if($_POST['upImg']){
		$image = $_FILES['image']['name'];
		$target = "uploads/".basename($image);

		$temp = explode(".", $_FILES["image"]["name"]);
		$newfilename = round(microtime(true)) . '.' . end($temp);




	if (move_uploaded_file($_FILES['image']['tmp_name'], $target.$newfilename)) {

		$imgname   = $image.$newfilename;
		$usr_id    = $_SESSION['id'];
		$sqlupdate = $mysqli->query("UPDATE `users` SET `usr_img`='$imgname' WHERE `id`='$usr_id'");

		echo '<div class="proc">تم تغيير صوره المستخدم</div>';
		
  	}else{
		echo '<div class="proc">حدثت مشكله اثناء رفع الملف</div>';
  	}

	}

}


?>