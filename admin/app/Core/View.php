<?php

class View extends Controller
{
    protected $view_file;
    public $view_data;

    public function __construct($view_file)
    {
        parent::__construct();
        $this->view_file = $view_file;
        
    }


    public function renderHeader()
    {
        
        include VIEW . 'header.phtml';
    }

    public function renderFile()
    {
        
        if(file_exists(VIEW . $this->view_file . DS . $this->view_file . '.phtml'))
        {
            
            include VIEW . $this->view_file . DS . $this->view_file . '.phtml';
            
            
        }
        else
        {
            exit("No such directory");
        }
        
    }

    public function renderFooter()
    {
        //reqiuerd for the ajax requests
        echo "<script>
                    var ajaxUrl = '" . ROOT_URL . "ajax/';
            </script>";

        include VIEW . 'footer.phtml';
    }


    //If there is an active link style => use this function
    public function getActive($url)
    {
        if(basename($_SERVER['REQUEST_URI']) == $this->view_file && $this->view_file== $url)
        {
            return true;
        }
        else
        {
            return false;
        }
    }


    public function viewMessages($errors = [], $success = [])
    {
        echo "<div class='alarms' id='alarms-php' style='display: block;'>";

        foreach($errors as $err)
        {
            echo "<div class='alarm alarm-errors'>" . $err . "</div>";
        }

        foreach($success as $succ)
        {
            echo "<div class='alarm alarm-success'>" . $succ . "</div>";
        }

        echo "</div>";
        echo "<script>
                //POSITION FIX
                alarms.style.top = window.pageYOffset + 20 + 'px';
                window.addEventListener('scroll', (e) => {
                    alarms.style.top = window.pageYOffset + 20 + 'px';
                });
                setTimeout(()=> {document.getElementById('alarms-php').remove();}, 2800);
            </script>";
    }
   
    //store the page data in an object called $this->data
    public function pagination($num_of_rows = 10)
    {
        echo "
        <script>
            var table_items = document.querySelectorAll('.table table tbody tr');
            var table_body = document.querySelector('.table table tbody');
            var pagintation_container = document.querySelector('.pagination');
            var current_page = 1;
            var rows_per_page = " . $num_of_rows ."; ///number of rows shown on all tables
            SetupPagination(table_items, table_body, rows_per_page, pagintation_container);
            DisplayTable(table_items, table_body, rows_per_page, current_page); 
        </script>
        ";
    }

}

