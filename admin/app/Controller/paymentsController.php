<?php

class paymentsController extends Controller
{

    public function __construct()
    {
        parent::__construct();

        $this->loggedIn();
        $this->view('payments');
        $this->view->renderHeader();
        $this->view->renderFile();
        $this->view->viewMessages($this->errors, $this->success);
        $this->view->renderFooter();


    }

}