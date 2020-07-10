<?php
error_reporting(0);
session_start();
include 'includes/config.php';



if($_SERVER['REQUEST_METHOD'] != 'POST') {
    header('location: dashboard');
} else {
    if(isset($_POST['new_payment'])) {

        $package = $_POST['package'];
        $user_id = $_POST['user_id'];

        $stmt = $mysqli->query("INSERT INTO payments (`user_id`, package) VALUES ('$user_id', '$package')");
        if($stmt) {
            echo 1;
        } else {
            echo 0;
        }
        
    } else {
        echo 0;
    }
}

?>