<?php

class Controller extends Database
{
    protected $view;
    public $success = [];
    public $errors = [];

    public function __construct()
    {
        parent::__construct();
        
    }


    //rendering the route file
    public function view($viewName)
    {
        $this->view = new View($viewName);
        return $this->view;
    }


    //check if user is not logged in => redirect to login page
    public function loggedIn()
    {
        if(!isset($_SESSION['user_type']))
        {
            header('location: ' . ROOT_URL . 'login');
        }
    }


    public function redirect($controller = '', $interval = '0', $header = false)
    {
        if(!$header)
            echo "<META HTTP-EQUIV='refresh' content='" . $interval . ";URL=" . ROOT_URL . $controller . "'>";
        else
            header('location: ' . ROOT_URL . $controller);
    }



}