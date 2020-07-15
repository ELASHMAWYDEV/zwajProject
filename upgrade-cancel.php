<?php
error_reporting(0);
session_start();



#
#include
#database config
#

include 'includes/config.php';

#
#functions
#
include 'functions/temp.fun';
include 'functions/user.fun';
include 'functions/usr.fun';
#
#classes
#


#
#include
#theme & temp
#


include 'theme/upgrade-cancel.temp';


//remove the payment cookie
setcookie('payment_id', null, time() - 3600);

//update the payment status to 'تم الغائها من قبل العميل'
$stmt = $mysqli->query("UPDATE ");

?>