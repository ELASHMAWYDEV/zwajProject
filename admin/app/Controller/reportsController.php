<?php

class reportsController extends Controller
{

    public function __construct()
    {
        parent::__construct();

        isset($_POST['ignore']) ? $this->takeAction($_POST['report_id']) : null;
        isset($_POST['deactivate']) ? $this->takeAction($_POST['report_id'], $_POST['user_id']) : null;

        $this->loggedIn();
        $this->view('reports');
        $this->getReports();
        $this->view->renderHeader();
        $this->view->renderFile();
        $this->view->viewMessages($this->errors, $this->success);
        $this->view->renderFooter();

        

    }


    public function getReports()
    {
        //reports
        $sql = "SELECT * FROM reports";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        if($stmt->rowCount() != '0')
        {
            $this->reports = $stmt->fetchAll();
        }
        else
        {
            array_push($this->errors, 'لا يوجد بلاغات لعرضها');
        }

        //users
        $sql = "SELECT * FROM users";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        if($stmt->rowCount() != '0')
        {
            $this->users = $stmt->fetchAll();
        }
        else
        {
            array_push($this->errors, 'لا يوجد مستخدمين مسجلين في الموقع لعرضهم');
        }

        //store data
        foreach($this->reports as $reports)
        {
            foreach($this->users as $users)
            {
                if($reports->reporter_id == $users->id) {
                    $reports->reporter_username = $users->username;
                    break;
                }
                else if($reports->reported_id == $users->id) {
                    $reports->reported_username = $users->username;
                    break;
                }
            }
            empty($reports->reported_username) ? $reports->reported_username = 'غير موجود' : null;
            empty($reports->reporter_username) ? $reports->reporter_username = 'غير موجود' : null;

        }

        //send data to the view
        $this->view->reports = $this->reports;
    }



    public function takeAction($report_id = null, $user_id = null)
    {
        //ignored
        if(!$user_id)
        {

            $sql = "UPDATE reports SET action = 'تم تجاهل البلاغ' WHERE id = ?";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$report_id]);
            if($stmt->rowCount() == '1')
            {
                array_push($this->success, "تم تجاهل البلاغ رقم $report_id بنجاح");
            }
            else
            {
                array_push($this->errors, 'حدث خطأ ما');
            }
        }
        else //deactivate
        {
            $sql = "UPDATE users SET ban = '1' WHERE id = ?";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([$user_id]);
            if($stmt->rowCount() == '1')
            {
                
                $sql = "UPDATE reports SET action = 'تم تعطيل حساب المستخدم' WHERE id = ?;";
                $stmt = $this->db->prepare($sql);
                $stmt->execute([$report_id]);
                if($stmt->rowCount() == '1')
                {
                    array_push($this->success, "تم تعطيل حساب المستخدم رقم $user_id بنجاح");
                }
                else
                {
                    array_push($this->errors, 'حدث خطأ ما عند تحديث حالة البلاغ' .$this->db->error);
                }
            }
            else
            {
                array_push($this->errors, 'حدث خطأ ما ، قد يكون المستخدم غير موجود');
            }
            

            
        }
       
    }

}