<?php

class usersController extends Controller
{

    public function __construct()
    {
        parent::__construct();


        isset($_POST['deactivate_user']) ? $this->deactivateUser($_POST['id']) : null;
        isset($_POST['activate_user']) ? $this->activateUser($_POST['id']) : null;
        isset($_POST['delete_user']) ? $this->deleteUser($_POST['id']) : null;
        isset($_POST['upgrade_special']) ? $this->upgradeUser($_POST['id'], $_POST['plan']) : null;




        $this->loggedIn();
        $this->view('users');
        $this->getUsers();
        $this->view->renderHeader();
        $this->view->renderFile();
        $this->view->viewMessages($this->errors, $this->success);
        $this->view->renderFooter();
        $this->view->pagination();


    }


    public function getUsers()
    {
        $sql = "SELECT * FROM users ORDER BY id DESC";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        if($stmt->rowCount() != '0')
        {
            $this->view->users = $stmt->fetchAll();
            foreach($this->view->users as $user) {

                //gender
                switch($user->gender) {

                    case 1:
                        $user->gender = 'ذكر';
                    break;
                    case 2:
                        $user->gender = 'أنثي';
                    break;
                    default:
                        $user->gender = 'غير محدد';
                }

                //state
                switch($user->state) {

                    case 1:
                        $user->state = 'الرياض';
                    break;
                    case 2:
                        $user->state = 'مكة المكرمة';
                    break;
                    case 3:
                        $user->state = 'المدينة المنورة';
                    break;
                    case 4:
                        $user->state = 'القصيم';
                    break;
                    case 5:
                        $user->state = 'المنطقة الشرقية';
                    break;
                    case 6:
                        $user->state = 'عسير';
                    break;
                    case 7:
                        $user->state = 'تبوك';
                    break;
                    case 8:
                        $user->state = 'حائل';
                    break;
                    case 9:
                        $user->state = 'الحدود الشمالية';
                    break;
                    case 10:
                        $user->state ='جازان';
                    break;
                    case 11:
                        $user->state ='نجران';
                    break;
                    case 12:
                        $user->state ='الباحة';
                    break;
                    case 13:
                        $user->state ='الجوف';
                    break;
                    default:
                        $user->state = 'غير محدد';
                }

                switch($user->account_type) {
                    case '0':
                        $user->account_type = 'عادية';
                    break;

                    case '1':
                        $user->account_type = 'مميزة';
                    break;
                }

                switch($user->ban) {
                    case '0':
                        $user->status = 'مفعل';
                    break;
                    case '1':
                        $user->status = 'معطل';
                    break;
                }

                if(empty($user->special_account_deadline)) {
                    $user->special_account_deadline = 'لا يوجد';
                } else if(strtotime($user->special_account_deadline) > time()) {

                    $user->special_account_deadline = date('d/m/Y', strtotime($user->special_account_deadline));
                } else {
                    $user->special_account_deadline = 'انتهت';
                }
            }
        }
        else
        {
            array_push($this->errors, 'لا يوجد أعضاء لعرضهم');
        }
    }





    public function deactivateUser($id)
    {
        $sql = "UPDATE users SET ban = '1' WHERE id = ? LIMIT 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$id]);

        if($stmt->rowCount() == '0') {
            $this->errors[] = "حدث خطأ ما";
            
        } else {
            $this->success[] = "تم تعطيل حساب المستخدم رقم #$id بنجاح";
        }
    }


    public function activateUser($id)
    {
        $sql = "UPDATE users SET ban = '0' WHERE id = ? LIMIT 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$id]);

        if($stmt->rowCount() == '0') {
            $this->errors[] = "حدث خطأ ما";
            
        } else {
            $this->success[] = "تم تفعيل حساب المستخدم رقم #$id بنجاح";
        }
    }


    public function deleteUser($id)
    {
        $sql = "DELETE FROM users WHERE id = ? LIMIT 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$id]);

        if($stmt->rowCount() == '0') {
            $this->errors[] = "حدث خطأ ما";
            
        } else {
            $this->success[] = "تم حذف حساب المستخدم رقم #$id بنجاح";
        }
    }


    public function upgradeUser($id, $month)
    {
        $period = date("Y-m-d H:m:i", strtotime($month . ' month'));
        $sql = "UPDATE users SET account_type = '1', special_account_deadline = '$period' WHERE id = ? LIMIT 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$id]);

        if($stmt->rowCount() == '0') {
            $this->errors[] = "حدث خطأ ما";
            
        } else {
            $this->success[] = "تم ترقية حساب المستخدم رقم #$id بنجاح";
        }
    }
}