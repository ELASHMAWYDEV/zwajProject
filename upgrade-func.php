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
        $paypal_email = $_POST['paypal_email'];
        $months = $_POST['months'];
        $cookei_random_id = uniqid();

        

        $stmt = $mysqli->query("INSERT INTO payments (`user_id`, package, paypal_email, cookei_random_id, months) VALUES ('$user_id', '$package', '$paypal_email', '$cookei_random_id', '$months')");
        if($stmt) {
            setcookie('payment_random_id', $cookei_random_id, time() + 3600);
            setcookie('payment_id', $stmt->insert_id, time() + 86400);

            echo 1;
        } else {
            echo 0;
        }
        
    } else {
        echo 0;
    }
}

?>