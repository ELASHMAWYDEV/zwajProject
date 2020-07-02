<?php

class usersAjax extends Ajax
{
    public function __construct()
    {
        parent::__construct();
        
        isset($_POST['get_user_by_id']) ? $this->get_user_by_id($_POST['id']) : null;

        //prevent users from accessing this page manually
        if($_SERVER['REQUEST_METHOD'] != 'POST') header('location: ' . ROOT_URL);
        
    }


    public function get_user_by_id($id)
    {

        $this->data->errors = [];
        $this->data->success = [];

        $sql = "SELECT * FROM users WHERE id = ? LIMIT 1";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([$id]);

        if ($stmt->rowCount() == '1') {

            $user = $stmt->fetch();

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

            //salary
            switch($user->salary) {
                
                case 1:
                    $user->salary = 'لا يوجد دخل شهري';
                break;
                case 2:
                    $user->salary = 'اقل من 200 دولار';
                break;
                case 3:
                    $user->salary = '100-200$';
                break;
                case 4:
                    $user->salary = '200-500$';
                break;
                case 5:
                    $user->salary = '500-1000$';
                break;
                case 6:
                    $user->salary = '1000$-5000$';
                break;
                case 7:
                    $user->salary = '5000$-10000$';
                break;
                case 8:
                    $user->salary = 'اكثر من 15000$';
                break;
                case 9:
                    $user->salary = 'افضل ان لا اقول';
                break;
                default:
                    $user->salary = 'غير محدد';
            }

            
            //work
            switch($user->work) {

                case 1:
                    $user->work = 'الهندسه';
                break;
                case 2:
                    $user->work = 'الطب / التمريض';
                break;
                case 3:
                    $user->work = 'الإدارة';
                break;
                case 4:
                    $user->work = 'التجارة';
                break;
                case 5:
                    $user->work = 'تسويق ومبيعات';
                break;
                case 6:
                    $user->work = 'قانون';
                break;
                case 7:
                    $user->work = 'الكمبيوتر والمعلومات';
                break;
                case 8:
                    $user->work = 'عمل خاص / رائد اعمال';
                break;
                case 9:
                    $user->work = 'مجال الفن والادب';
                break;
                case 10:
                    $user->work = 'عمل حكومي';
                break;
                case 11:
                    $user->work = 'لا اعمل';
                break;
                case 12:
                    $user->work = 'غير محدد - اخر';
                break;
                default:
                    $user->work = 'غير محدد';
            }

            //money
            switch($user->money) {

                case 1:
                     $user->money = 'فقير';
                break;
                case 2:
                     $user->money = 'اقل من متوسط';
                break;
                case 3:
                     $user->money = 'متوسط';
                break;
                case 4:
                     $user->money = 'أكثر من متوسط';
                break;
                case 5:
                     $user->money = 'جيد';
                break;
                case 6:
                     $user->money = 'ميسور';
                break;
                case 7:
                     $user->money = 'غني';
                break;
                default:
                    $user->money = 'غير محدد';
            }

            //education
            switch ($user->education) {

                case 1:
                    $user->education = 'تعليم متوسط';
                break;
                case 2:
                    $user->education = 'تعليم ثانوي';
                break;
                case 3:
                    $user->education = 'تعليم جامعي';
                break;
                case 4:
                    $user->education = 'دكتواره';
                break;
                case 5:
                    $user->education = 'تعليم ذاتي';
                break;
                default:
                    $user->education = 'غير محددد';
            }

            //religon4
            switch ($user->religon4) {

                case 1:
                    $user->religon4 = 'لدي لحية';
                break;
                case 2:
                    $user->religon4 = 'ليس لدي لحية';
                break;
                default:
                    $user->religon4 = 'غير محددد';
            }

            //religon2
            switch ($user->religon2) {

                case 2:
                    $user->religon2 = '- أصلي دائماً';
                break;
                case 3:
                    $user->religon2 = '- أصلي أغلب الاوقات';
                break;
                case 4:
                    $user->religon2 = '- أصلي بعض الاوقات';
                break;
                case 5:
                    $user->religon2 = '- لا أصلي';
                break;
                case 6:
                    $user->religon2 = '- أفضل ان لا أقول';
                break;
                default:
                    $user->religon2 = 'غير محددد';

            }

            //religon1
            switch ($user->religon1) {

                case 1:
                    $user->religon1 = 'لست متدين';
                break;
                case 2:
                    $user->religon1 = 'متدين قليلاً';
                break;
                case 3:
                    $user->religon1 = 'متدين';
                break;
                case 4:
                    $user->religon1 = 'متدين كثيراً';
                break;
                case 5:
                    $user->religon1 = 'لا اود القول';
                break;
                default:
                    $user->religon1 = 'غير محددد';

            }

            //childrens_num
            switch ($user->childrens_num) {

                case 1:
                    $user->childrens_num = 'ليس لدي';
                break;
                case 2:
                    $user->childrens_num = 'طفل واجد';
                break;
                case 3:
                    $user->childrens_num = 'طفلين اثنين';
                break;
                case 4:
                    $user->childrens_num = 'ثلاثه اطفال';
                break;
                case 5:
                    $user->childrens_num = 'اربع اطفال';
                break;
                case 6:
                    $user->childrens_num = 'خمسة اطفال';
                break;
                case 7:
                    $user->childrens_num = 'ستة اطفال';
                break;
                case 8:
                    $user->childrens_num = 'سبعة أطفال';
                break;
                case 9:
                    $user->childrens_num = 'ثمانية أطفال';
                break;
                case 10:
                    $user->childrens_num ='أكثر من ثمانية أطفال';
                break;
                default:
                    $user->childrens_num = 'غير محددد';
            }

            //zwaj_type
            switch ($user->zwaj_type) {

                case 1:
                    $user->zwaj_type = 'زواج أول';
                break;
                case 2:
                    $user->zwaj_type = 'زواج ثاني';
                break;
                case 3:
                    $user->zwaj_type = 'زواج ثالث';
                break;
                case 4:
                    $user->zwaj_type = 'زواج رابع';
                break;
                default:
                    $user->zwaj_type = 'غير محددد';
            }

            //religon3
            switch ($user->religon3) {

                case 1:
                    $user->religon3 = 'اقوم بالتدخين';
                break;
                case 2:
                    $user->religon3 = 'لا أقوم بالتدخين';
                break;
                default:
                    $user->religon3 = 'غير محددد';
            }

            //body_type
            switch ($user->body_type) {

                case 1:
                    $user->body_type = 'نحيف/رفيع';
                break;
                case 2:
                    $user->body_type = 'متوسط البنية';
                break;
                case 3:
                    $user->body_type = 'قوام رياضي';
                break;
                case 4:
                    $user->body_type = 'سمين';
                break;
                case 5:
                    $user->body_type = 'ضخم';
                break;
                default:
                    $user->body_type = 'غير محددد';
            }

            //skin_color
            switch ($user->skin_color) {

                case 1:
                    $user->skin_color = 'أبيض';
                break;
                case 2:
                    $user->skin_color = 'حنطي مائل للأبيض';
                break;
                case 3:
                    $user->skin_color = 'حنطي مائل للسمار';
                break;
                case 4:
                    $user->skin_color = 'اسمر فاتح';
                break;
                case 5:
                    $user->skin_color = 'أسمر غامق';
                break;
                case 6:
                    $user->skin_color = 'أسمر';
                break;
                default:
                    $user->skin_color = 'غير محددد';
            }

            //table

            $this->data->output = "
                    <tr>
                        <th>اسم المستخدم</th>
                        <td>$user->username</td>
                    </tr>
                    <tr>
                        <th>البريد الالكتروني</th>
                        <td>$user->email</td>
                    </tr>
                    <tr>
                        <th>الاسم</th>
                        <td>$user->full_name</td>
                    </tr>
                    <tr>
                        <th>الجنس</th>
                        <td>$user->gender</td>
                    </tr>
                    <tr>
                        <th>الدولة</th>
                        <td>$user->country</td>
                    </tr>
                    <tr>
                        <th>المنطقة</th>
                        <td>$user->state</td>
                    </tr>
                    <tr>
                        <th>رقم الهاتف</th>
                        <td>$user->phone_number</td>
                    </tr>
                    <tr>
                        <th>الديانة</th>
                        <td>$user->religon</td>
                    </tr>
                    <tr>
                        <th>نوع الزواج</th>
                        <td>$user->zwaj_type</td>
                    </tr>
                    <tr>
                        <th>العمر</th>
                        <td>$user->age</td>
                    </tr>
                    <tr>
                        <th>الأطفال</th>
                        <td>$user->childrens_num</td>
                    </tr>
                    <tr>
                        <th>الوزن</th>
                        <td>$user->weight كج</td>
                    </tr>
                    <tr>
                        <th>لون البشرة</th>
                        <td>$user->skin_color</td>
                    </tr>
                    <tr>
                        <th>الطول</th>
                        <td>$user->tall سم</td>
                    </tr>
                    <tr>
                        <th>بنية الجسم</th>
                        <td>$user->body_type</td>
                    </tr>
                    <tr>
                        <th>اللحية</th>
                        <td>$user->religon4</td>
                    </tr>
                    <tr>
                        <th>وضع التدين</th>
                        <td>$user->religon2</td>
                    </tr>
                    <tr>
                        <th>حالة التدين</th>
                        <td>$user->religon1</td>
                    </tr>
                    <tr>
                        <th>مدة الاصابة</th>
                        <td>$user->hiv_years</td>
                    </tr>
                    <tr>
                        <th>مدخن</th>
                        <td>$user->religon3</td>
                    </tr>
                    <tr>
                        <th>الحالة التعليمية</th>
                        <td>$user->education</td>
                    </tr>
                    <tr>
                        <th>الحالة المادية</th>
                        <td>$user->money</td>
                    </tr>
                    <tr>
                        <th>مجال العمل</th>
                        <td>$user->work</td>
                    </tr>
                    <tr>
                        <th>الدخل الشهري</th>
                        <td>$user->salary</td>
                    </tr>
                    <tr>
                        <th>مواصفات الشريك</th>
                        <td>$user->lovebio</td>
                    </tr>
                    <tr>
                        <th>نبذة عن نفسه</th>
                        <td>$user->bio</td>
                    </tr>
                    <tr>
                        <th>تاريخ التسجيل</th>
                        <td>" . date("H:ia d/m/Y", strtotime($user->create_date)) . "</td>
                    </tr>
                    <tr>
                        <th>أخر مرة تسجيل دخول</th>
                        <td>" . !empty($user->login_date)??date("H:ia d/m/Y", strtotime($user->login_date)) . "</td>
                    </tr>
            
            ";
            
        } else {

            $this->data->errors[] = "لا يوجد مستخدم بهذا الرقم : $id";
            $this->data->reload = 'true';
        }

        echo json_encode($this->data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    }


}