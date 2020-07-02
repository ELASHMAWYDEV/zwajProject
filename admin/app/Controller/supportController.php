<?php

class supportController extends Controller
{

    public function __construct()
    {
        parent::__construct();

        isset($_POST['ignore']) ? $this->messageAction($_POST['id']) : null;
        isset($_POST['respond']) ? $this->messageAction($_POST['id']) : null;

        $this->loggedIn();
        $this->view('support');
        $this->getMessages();
        $this->view->renderHeader();
        $this->view->renderFile();
        $this->view->viewMessages($this->errors, $this->success);
        $this->view->renderFooter();


    }



    public function getMessages()
    {

        $sql = "SELECT * FROM support";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();

        if ($stmt->rowCount() == '0') $this->errors[] = "لا يوجد رسائل لعرضها";
        else {
            $messages = $stmt->fetchAll();

            $sql = "SELECT * FROM users";
            $stmt = $this->db->prepare($sql);
            $stmt->execute();
            $users = $stmt->fetchAll();

            foreach($messages as $msg) {

                foreach($users as $user) {
                    if ($user->id == $msg->sender_id) $msg->sender = $user->username;
                }

                $msg->create_date = date("h:ia d/m/Y", strtotime($msg->create_date));
                
                if(empty($msg->sender_id)) $msg->sender = "زائر مجهول";
            }
            
            $this->view->messages = $messages;
        }
    }


    public function messageAction($id)
    {
        if(isset($_POST['ignore'])) {

            $sql = "UPDATE support SET action = ? WHERE id = '$id' LIMIT 1";
            $stmt = $this->db->prepare($sql);
            $stmt->execute(['تم تجاهل الرسالة']);

            if ($stmt->rowCount() == '1') {
                $this->success[] = "تم تجاهل الرسالة رقم $id بنجاح";
                $this->redirect('support', '3');
            } else $this->errors[] = "حدث خطأ ما";
        } else if (isset($_POST['respond'])) {
            $this->errors[] = "نظام الرسائل لم يجهز بعد ، يرجي التواصل مع المبرمج contact@elashmawydev.com";
        }
    }

}