<?php

set_time_limit(0);
//modules
define(__DIR__, dirname(__FILE__));
define('DS',DIRECTORY_SEPARATOR);
define('ROOT', __DIR__ . DS);
define('APP', ROOT . 'app' . DS);
define('MODEL', APP . 'Model' . DS);
define('CONTROLLER', APP . 'Controller' . DS);
define('VIEW', APP . 'View' . DS);
define('CORE', APP . 'Core' . DS);
define('AJAX', APP . 'Ajax' . DS);
//public folder
define('PUBLIC', ROOT . 'public' . DS);

$modules = [ROOT,APP,MODEL,CONTROLLER,CORE,AJAX];


function class_loader($class_name) {
    global $modules;
    foreach ($modules as $module) {
        if (file_exists($module . $class_name . '.php')) {
            require($module . $class_name . '.php');
            return;
        }
    }
}
spl_autoload_register('class_loader');


//config file
require 'config.php';
new Application;
