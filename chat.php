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
include 'functions/usr.fun';
#
#include
#theme & temp
#
include 'theme/chat.temp';



?>
