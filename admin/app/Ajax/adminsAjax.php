<?php

class adminsAjax extends Ajax
{
    public function __construct()
    {
        parent::__construct();
        
        isset($_POST['add_new_admin']) ? $this->add_new_admin(json_decode($_POST['data'])) : null;
        isset($_POST['edit_admin']) ? $this->edit_admin(json_decode($_POST['data'])) : null;
        isset($_POST['get_admin_by_id']) ? $this->get_admin_by_id(json_decode($_POST['id'])) : null;
        isset($_POST['delete_admin_by_id']) ? $this->delete_admin_by_id(json_decode($_POST['id'])) : null;

        //prevent users from accessing this page manually
        if($_SERVER['REQUEST_METHOD'] != 'POST') header('location: ' . ROOT_URL);
        
    }


    public function add_new_admin($data)
    {
        $this->data = $data;
        $this->output = $this->data->output;
        $sql = "INSERT INTO admins (username,email,`name`,phone,pass) VALUES (:username,:email,:name,:phone,:pass)";
        $stmt = $this->db->prepare($sql);
        
        //if empty fields where submitted
        if(empty($this->output->username) || empty($this->output->email)
        || empty($this->output->phone) || empty($this->output->name)
        || empty($this->output->pass1) || empty($this->output->pass2))
        {
            $this->data->errors[] = 'يجب ملئ جميع البيانات';
        }

        //passwords are not equal
        if($this->output->pass1 != $this->output->pass2) 
        {
            $this->data->errors[] = 'يجب أن تكون كلمتي المرور متطابقتين';
        }
        //not a valid email
        if(!filter_var($this->output->email, FILTER_VALIDATE_EMAIL)) {
            $this->data->errors[] = 'هذا البريد الالكتروني غير صالح';
        }


        //check if username or email exist in Database
        $emailCheck = "SELECT * FROM admins WHERE email = ? LIMIT 1";
        $emailCheck = $this->db->prepare($emailCheck);
        $emailCheck->execute([$this->output->email]);
        if($emailCheck->rowCount() != '0') {
            $this->data->errors[] = 'البريد الالكتروني مسجل من قبل، يرجي استخدام بريد الكتروني مختلف';
        }

        $usernameCheck = "SELECT * FROM admins WHERE username = ? LIMIT 1";
        $usernameCheck = $this->db->prepare($usernameCheck);
        $usernameCheck->execute([$this->output->username]);
        if($usernameCheck->rowCount() != '0') {
            $this->data->errors[] = 'اسم المستخدم مسجل من قبل، يرجي استخدام اسم مستخدم مختلف';
        }


        if (count($this->data->errors) == 0)
        {
            $stmt->execute([
                'username' => $this->output->username,
                'email' => $this->output->email,
                'name' => $this->output->name,
                'phone' => $this->output->phone,
                'pass' => md5($this->output->pass1)
            ]);
            $this->data->reload = 'true';
            $this->data->success[] = 'تم اضافة المشرف الجديد بنجاح';


        }
        $this->data->output = $this->output;
        echo json_encode($this->data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
    }




    public function edit_admin($data)
    {
        $this->data = $data;
        $this->output = $this->data->output;
        
        if (!empty($this->output->username) && !empty($this->output->email)
            && !empty($this->output->phone) && !empty($this->output->name))
        {
            $sql = "UPDATE admins SET username = :username, email = :email, `name` = :name, phone = :phone WHERE id = " . $this->data->id . " LIMIT 1";
            $stmt = $this->db->prepare($sql);
            $stmt->execute([
                'username' => $this->output->username,
                'email' => $this->output->email,
                'name' => $this->output->name,
                'phone' => $this->output->phone
            ]);

            if ($stmt->rowCount() == '1')
            {
                $this->data->success[] = 'تم حفظ البيانات بنجاح';
                $this->data->reload = 'true';
            }
            else
            {
                $this->data->errors[] = 'لم تقم بأي تغيير للحفظ';
            }

        }
        else
        {
            $this->data->errors[] = 'يجب ملئ جميع البيانات';
        }
        

        $this->data->output = $this->output;
        echo json_encode($this->data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
    }

    public function get_admin_by_id($id)
    {
        $this->id = $id;
        $this->output = $this->data->output;
        $sql = "SELECT * FROM admins WHERE id = $id LIMIT 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        if($stmt->rowCount() == '1')
        {
            $admin = $stmt->fetch();
            $this->output->email = $admin->email;
            $this->output->username = $admin->username;
            $this->output->name = $admin->name;
            $this->output->phone = $admin->phone;

        }
        else
        {
            $this->data->errors[] = 'لا يوجد مشرف بهذا الرقم';
            $this->data->reload = 'true';
            
        }
        $this->data->output = $this->output;
        echo json_encode($this->data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
    }


    public function delete_admin_by_id($id)
    {
        $this->id = $id;
        $sql = "DELETE FROM admins WHERE id = $id LIMIT 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        if($stmt->rowCount() == '1')
        {
            $this->data->success[] = 'تم حذف المشرف رقم ' . $id . ' بنجاح';
            $this->data->reload = 'true';
        }
        else
        {
            $this->data->errors[] = 'هناك خطأ في رقم المشرف أو تم حذف بالفعل';
        }
        echo json_encode($this->data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
    }
}