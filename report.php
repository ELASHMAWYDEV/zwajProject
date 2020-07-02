<?php
error_reporting(0);
session_start();
!isset($_GET['id']) ? header('location: dashboard') : null;
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
include 'theme/report.temp';
?>