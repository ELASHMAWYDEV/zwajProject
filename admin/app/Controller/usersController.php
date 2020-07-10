<?php

class usersController extends Controller
{

    public function __construct()
    {
        parent::__construct();

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
            }
        }
        else
        {
            array_push($this->errors, 'لا يوجد أعضاء لعرضهم');
        }
    }

}