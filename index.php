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
include 'functions/usr.fun';
sessionCheck();
#
#include
#theme & temp
#

include 'theme/home.temp';







?>