<?php
session_start();


include 'includes/config.php';

if($_SERVER['REQUEST_METHOD'] != 'POST') {
    header('location: dashboard');
} else {
    isset($_POST['like_user']) ? likeUser($_POST['id'], $_POST['liked']) : null;
    
}


function likeUser($id, $liked) {
    global $mysqli;

    //get the likes array
    $sql = $mysqli->query("SELECT * FROM users WHERE id = '" . $id . "' LIMIT 1");
    $user = $sql->fetch_assoc();

    if($sql) {
        if(!empty($user['likes'])) {
            $likes = explode(',', $user['likes']);
        } else {
            $likes = [];
        }
        
        if($liked == '0') {
            $key = array_search($_SESSION['id'], $likes);
            if($key !== false) {
                unset($likes[$key]);

                //remove duplicates
                $likes = array_unique($likes);

                $likes = implode(',', $likes);
                $sql = $mysqli->query("UPDATE users SET likes = '" . $likes . "' WHERE id = '" . $id ."'LIMIT 1");

                if($sql) {
                    echo 1;
                } else {
                    echo 0;
                }
            }
        } else {

            $likes[] = $_SESSION['id'];
            //remove duplicates
            $likes = array_unique($likes);

            $likes = implode(',', $likes);
            $sql = $mysqli->query("UPDATE users SET likes = '" . $likes . "' WHERE id = '" . $id ."'LIMIT 1");

            if($sql) {
                echo 1;
            } else {
                echo 0;
            }
        }
        

    } else {
        echo 0;
    }

}

?>