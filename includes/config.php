<?php

// ini_set('display_errors', 0);
ini_set('log_errors', TRUE);
ini_set('errors_log', 'errors.log');
/*
@
@ -
@ ZWAJ - database connection
@ -
@
@
*/
$db_host  = 'localhost';
$db_user  = 'root';
$db_pass  = '';
$db_name  = 'zwaj';
#
#mysqli class
#
$mysqli = new mysqli;
#
#connection
#
$mysqli->connect($db_host,$db_user,$db_pass,$db_name);
$mysqli->set_charset('utf8');
#
#THEME-CONFIG
#
?>
