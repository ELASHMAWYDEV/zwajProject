<?php


error_reporting(0);
session_start();
if(!isset($_SESSION['username'])) {
    header("location: dashboard");
}
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


include 'theme/upgrade.temp';


?>