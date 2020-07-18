<?php

class statsController extends Controller
{

    public function __construct()
    {
        header('location: users'); //temp
        parent::__construct();

        $this->loggedIn();
        $this->view('stats');
        $this->view->renderHeader();
        $this->view->renderFile();
        $this->view->viewMessages($this->errors, $this->success);
        $this->view->renderFooter();


    }

}