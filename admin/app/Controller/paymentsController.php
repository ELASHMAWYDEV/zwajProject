<?php

class paymentsController extends Controller
{

    public function __construct()
    {
        parent::__construct();


        isset($_POST['confirm']) ? $this->confirmPayment($_POST['id'], $_POST['user_id']) : null;
        isset($_POST['unvalid']) ? $this->unvalidPayment($_POST['id']) : null;

        $this->loggedIn();
        $this->view('payments');
        $this->getPayments();
        $this->view->renderHeader();
        $this->view->renderFile();
        $this->view->viewMessages($this->errors, $this->success);
        $this->view->renderFooter();


    }


    public function getPayments()
    {

        $sql = "SELECT * FROM payments";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();

        if ($stmt->rowCount() == '0') $this->errors[] = "لا يوجد معاملات لعرضها";
        else {
            $payments = $stmt->fetchAll();

            $sql = "SELECT * FROM users";
            $stmt = $this->db->prepare($sql);
            $stmt->execute();
            $users = $stmt->fetchAll();

            foreach($payments as $payment) {

                foreach($users as $user) {
                    if ($user->id == $payment->user_id) $payment->user = $user->username;
                }

                $payment->create_date = date("h:ia d/m/Y", strtotime($payment->create_date));
                
            }
            
            $this->view->payments = $payments;
        }
    }


    public function confirmPayment($id, $user_id) {

        $sql = "UPDATE payments SET `status` = 'مؤكدة' WHERE id = ? LIMIT 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$id]);

        if($stmt->rowCount() == '1') {

            $sql = "UPDATE users SET account_type = '1',  WHERE id = ?";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$user_id]);

            if($stmt->rowCount() == '1') {
                $this->success[] = "تم تأكيد المعاملة رقم $id بنجاح وأصبحت عضوية المستخدم مميزة";
            }
        
        } else {
            $this->errors[] = "حدث خطأ ما";
        }
    }


    public function unvalidPayment($id)
    {
        $sql = "UPDATE payments SET `status` = 'غير صالحة' WHERE id = ? LIMIT 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$id]);

        if($stmt->rowCount() == '1') {
            $this->success[] = "تم تحديث حالة المعاملة الي غير صالحة بنجاح";
        
        } else {
            $this->errors[] = "حدث خطأ ما";
        }
    
    }

}