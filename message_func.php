<?php
session_start();


include 'includes/config.php';

if($_SERVER['REQUEST_METHOD'] != 'POST') {
    header('location: dashboard');
} else {
    isset($_POST['send_message']) ? send_message() : null;
    isset($_POST['fetch_chat']) ? fetch_chat($_SESSION['id'], $_POST['id']) : null;
    isset($_POST['last_seen']) && isset($_SESSION['id']) ? last_seen($_SESSION['id']) : null;
    isset($_POST['upload_image']) && isset($_SESSION['id']) ? upload_image($_POST['id'], $_FILES['image']) : null;
}


function send_message() {
    global $mysqli;
    $id = $_POST['id'];
    $message = htmlspecialchars($_POST['message']);
    $sender = $_SESSION['id'];

    $stmt = $mysqli->query("INSERT INTO chat (from_id, to_id, msg) VALUES ('$sender', '$id', '$message')");

    if ($stmt) {
        fetch_chat($sender, $id);
    } else {
        echo json_encode(['error' => "$mysqli->error"]);
    }
}

function fetch_chat($from, $to) {
    global $mysqli;

    $stmt = $mysqli->query("SELECT * FROM chat WHERE (from_id = '$from' AND to_id = '$to') OR (from_id = '$to' AND to_id = '$from') ORDER BY id");

    $chat = $stmt->fetch_all(MYSQLI_ASSOC);

    foreach ($chat as $msg) {
        $msg['time'] = date("h:ia d/m/Y", strtotime($msg['time']));
    }

    echo json_encode($chat, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    
}

function last_seen($id) {
    global $mysqli;

    $stmt = $mysqli->query("UPDATE users SET last_seen = NOW() WHERE id = '$id' LIMIT 1");

    if($stmt) {
        echo "done" . $id;
    } else {
        echo "error: " . $mysqli->error;
    }
}



function upload_image($to_id, $img) {
    global $mysqli;

    $from_id = $_SESSION['id'];
    $image_name = $img['name'];

    $ext = pathinfo($image_name, PATHINFO_EXTENSION);
    $random_name = uniqid('img_') . '_user_from' . $from_id . '_to' . $to_id;

    $final_name = $random_name . '.' . $ext;
    $location = "chat_uploads/" . $final_name;

    if(move_uploaded_file($img['tmp_name'], $location)) {
        
        $stmt = $mysqli->query("INSERT INTO chat (from_id, to_id, msg) VALUES ('$from_id', '$to_id', '$final_name')");

        if ($stmt) {
            echo 1;
        }

    } else {
        echo 0;
    }


}