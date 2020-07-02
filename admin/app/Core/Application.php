<?php


class Application
{
    protected $controller = '';
    // protected $action = '';
    // protected $params = [];  

    public function __construct()
    {
        session_start();
        $this->parseUrl();
        if(file_exists(CONTROLLER . $this->controller . '.php'))
        {
            $this->controller = new $this->controller;

        }
        else if(file_exists(AJAX . $this->ajax . '.php'))
        {
            $this->ajax = new $this->ajax;
        }
        else
        {
            echo 'No such directory !<br>redirecting....';
            header('Refresh: 2; url=' . ROOT_URL . 'login');
        }
    }


    protected function parseUrl()
    {
        $request = trim($_SERVER['REQUEST_URI'], '/');
        if(!empty($request))
        {
            $url = explode('/', $request);
            //edit $url[index] if the root is a subdirectory to the main website
             
            if(isset($url[1]) && $url[1] != 'ajax')
            {
                $this->controller =  $url[1] . 'Controller';
            }      
            else if($url[1] == 'ajax' && isset($url[2]))
            {
                $this->ajax = $url[2] . 'Ajax';
            }
            else 
                $this->controller = 'loginController';
        }
    }





   
}