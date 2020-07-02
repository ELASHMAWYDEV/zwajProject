<?php

class adminsController extends Controller
{

    public function __construct()
    {
        parent::__construct();

        $this->loggedIn();
        $this->view('admins');
        $this->getAdmins();
        $this->view->renderHeader();
        $this->view->renderFile();
        $this->view->viewMessages($this->errors, $this->success);
        $this->view->renderFooter();
        $this->view->pagination();


        //get admin by id


    }

    public function getAdmins()
    {
        $sql = "SELECT * FROM admins";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        if($stmt->rowCount() != '0')
        {
            $this->view->data = $stmt->fetchAll();
        }
        else
        {
            array_push($this->errors, 'لا يوجد مشرفين لعرضهم');
        }
    }

    
}
