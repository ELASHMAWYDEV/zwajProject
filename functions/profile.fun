<?php

function profusername(){
    include 'includes/config.php';
    $id   = $_GET['id'];
    $sql = $mysqli->query("SELECT * FROM `users` WHERE `id`='$id'");
    $get = $sql->fetch_assoc();
    echo $get['username'];
}
function profimg(){
    include 'includes/config.php';
    $id   = $_GET['id'];
    $sql = $mysqli->query("SELECT * FROM `users` WHERE `id`='$id'");
    $row = $sql->fetch_assoc();
    
    if($row['usr_img'] == ''){
       if($row['gender'] == 1){
         echo '<img src="theme/img/men.png" />';
       }
       if($row['gender'] == 2){
         echo '<img src="theme/img/women.png" />';
       }
     }else{
         echo '<img src="uploads/'.$row['usr_img'].'" />';
     }
     
}
function checkme(){
    include 'includes/config.php';
    if($_SESSION['id'])
    {
        
    }else
    {
        echo '
        <div class="signwarn">
         برجاء تسجيل الدخول لتتمكن من عرض البيانات
        </div>
        ';
    }
}
function checkprof(){
    include 'includes/config.php';
    if($_SESSION['id'])
    {
        
    }else
    {
        echo 'class ="blurprof"';
    }
}
function profinfo(){
    include 'includes/config.php';
    $id   = $_GET['id'];
    $sql1 = $mysqli->query("SELECT * FROM `users` WHERE `id`='$id'");
    while($get1 = $sql1->fetch_assoc()){
        echo '<b><i class="fas fa-info"></i> معلومات</b>';
        echo '<p>العمر: '.$get1['age'].'</p>';
        echo '<p>الحاله: ';
        if($get1['type'] == 1)
        {
            echo 'اعزب';
        }
        if($get1['type'] == 2)
        {
            echo 'متزوج';
        }
        if($get1['type'] == 3)
        {
            echo 'مطلق';
        }
        if($get1['type'] == 4)
        {
            echo 'أرمل';
        }
        echo '</p>';
        echo '<p>المدينه: ';
        if($get1['state'] == 1)
        {
            echo 'الرياض';
        }
        if($get1['state'] == 2)
        {
            echo 'مكة المكرمة';
        }
        if($get1['state'] == 3)
        {
            echo 'المدينة المنورة';
        }
        if($get1['state'] == 4)
        {
            echo 'القصيم';
        }
        if($get1['state'] == 5)
        {
            echo 'المنطقة الشرقية';
        }
        if($get1['state'] == 6)
        {
            echo 'عسير';
        }
        if($get1['state'] == 7)
        {
            echo 'تبوك';
        }
        if($get1['state'] == 8)
        {
            echo 'حائل';
        }
        if($get1['state'] == 9)
        {
            echo 'الحدود الشمالية';
        }
        if($get1['state'] == 10)
        {
            echo 'جازان';
        }
        if($get1['state'] == 11)
        {
            echo 'نجران';
        }
        if($get1['state'] == 12)
        {
            echo 'الباحة';
        }
        if($get1['state'] == 13)
        {
            echo 'الجوف';
        }
        echo '</p>';
        echo '<b><i class="fas fa-heartbeat"></i> مده الإصابه بنقص المناعه</b>';
        echo '<p>'.$get1['hiv_years'].' سنة</p>';
        echo '<b><i class="fas fa-allergies"></i> الشخصيه </b>';
        echo '<p>لون البشرة : ';
        if($get1['skin_color'] == 1)
        {
            echo 'أبيض';
        }
        if($get1['skin_color'] == 2)
        {
            echo 'حنطي مائل للأبيض';
        }
        if($get1['skin_color'] == 3)
        {
            echo 'حنطي مائل للسمار';
        }
        if($get1['skin_color'] == 4)
        {
            echo 'اسمر فاتح';
        }
        if($get1['skin_color'] == 5)
        {
            echo 'أسمر غامق';
        }
        if($get1['skin_color'] == 6)
        {
            echo 'أسمر';
        }
        echo '</p>';
        echo '<p>بنية الجسم : ';
        if($get1['body_type'] == 1)
        {
            echo 'نحيف/رفيع';
        }
        if($get1['body_type'] == 2)
        {
            echo 'متوسط البنية';
        }
        if($get1['body_type'] == 3)
        {
            echo 'قوام رياضي';
        }
        if($get1['body_type'] == 4)
        {
            echo 'سمين';
        }
        if($get1['body_type'] == 5)
        {
            echo 'ضخم';
        }
        
        echo '</p>';
        echo '<p>الطول: '.$get1['tall'].' سم</p>';
        echo '<p>الوزن: '.$get1['weight'].' كج</p>';
        echo '<p>التدخين : ';
        if($get1['religon3'] == 1)
        {
            echo 'اقوم بالتدخين';
        }
        if($get1['religon3'] == 2)
        {
            echo 'لا أقوم بالتدخين';
        }
        echo '</p>';
        echo '<b><i class="fas fa-ring"></i> بيانات الزواج</b>';
        echo '<p>نوع الزواج: ';
        if($get1['zwaj_type'] == 1)
        {
            echo 'زواج أول';
        }
        if($get1['zwaj_type'] == 2)
        {
            echo 'زواج ثاني';
        }
        if($get1['zwaj_type'] == 3)
        {
            echo 'زواج ثالث';
        }
        if($get1['zwaj_type'] == 4)
        {
            echo 'زواج رابع';
        }
        echo '</p>';
        echo '<p>عدد الأطفال : ';
        if($get1['childrens_num'] == 1)
        {
            echo 'ليس لدي';
        }
        if($get1['childrens_num'] == 2)
        {
            echo 'طفل واجد';
        }
        if($get1['childrens_num'] == 3)
        {
            echo 'طفلين اثنين';
        }
        if($get1['childrens_num'] == 4)
        {
            echo 'ثلاثه اطفال';
        }
        if($get1['childrens_num'] == 5)
        {
            echo 'اربع اطفال';
        }
        if($get1['childrens_num'] == 6)
        {
            echo 'خمسة اطفال';
        }
        if($get1['childrens_num'] == 7)
        {
            echo 'ستة اطفال';
        }
        if($get1['childrens_num'] == 8)
        {
            echo 'سبعة أطفال';
        }
        if($get1['childrens_num'] == 9)
        {
            echo 'ثمانية أطفال';
        }
        if($get1['childrens_num'] == 10)
        {
            echo 'أكثر من ثمانية أطفال';
        }
        
        echo '</p>';
        echo '<b><i class="fas fa-star-and-crescent"></i> بيانات التدين</b>';
        echo '<p>حاله التدين : ';
        if($get1['religon1'] == 1)
        {
            echo 'لست متدين';
        }
        if($get1['religon1'] == 2)
        {
            echo 'متدين قليلاً';
            
        }
        if($get1['religon1'] == 3)
        {
            echo 'متدين';
            
        }
        if($get1['religon1'] == 4)
        {
            echo 'متدين كثيراً';
            
        }
        if($get1['religon1'] == 5)
        {
            echo 'لا اود القول';
            
        }
        if($get1['religon2'] == 2)
        {
            echo '- أصلي دائماً';
            
        }
        if($get1['religon2'] == 3)
        {
            echo '- أصلي أغلب الاوقات';
            
        }
        if($get1['religon2'] == 4)
        {
            echo '- أصلي بعض الاوقات';
            
        }
        if($get1['religon2'] == 5)
        {
            echo '- لا أصلي';
            
        }
        if($get1['religon2'] == 6)
        {
            echo '- أفضل ان لا أقول';
            
        }
        echo '</p>';
        if($get1['gender'] == 1)
        {
         echo '<p>اللحية : ';
         if($get1['religon4'] == 1)
         {
             echo 'لدي لحية';
         }
         if($get1['religon4'] == 2)
         {
             echo 'ليس لدي لحية';
         }
            
        }
        echo '</p>';
        echo '<b><i class="fas fa-university"></i> التعليم</b>';
        if($get1['education'] == 1)
        {
             echo '<p>الحاله التعليمية : تعليم متوسط</p>';
        }
        if($get1['education'] == 2)
        {
             echo '<p>الحاله التعليمية : تعليم ثانوي</p>';
        }
        if($get1['education'] == 3)
        {
             echo '<p>الحاله التعليمية : تعليم جامعي</p>';
        }
        if($get1['education'] == 4)
        {
             echo '<p>الحاله التعليمية : دكتواره</p>';
        }
        if($get1['education'] == 5)
        {
             echo '<p>الحاله التعليمية : تعليم ذاتي</p>';
        }
        echo '<p>الحاله الماديه : ';
        if($get1['money'] == 1)
        {
             echo 'فقير';
        }
        if($get1['money'] == 2)
        {
             echo 'اقل من متوسط';
        }
        if($get1['money'] == 3)
        {
             echo 'متوسط';
        }
        if($get1['money'] == 4)
        {
             echo 'أكثر من متوسط';
        }
        if($get1['money'] == 5)
        {
             echo 'جيد';
        }
        if($get1['money'] == 6)
        {
             echo 'ميسور';
        }
        if($get1['money'] == 7)
        {
             echo 'غني';
        }
        
        echo '</p>';
        echo '<p>مجال العمل : ';
        if($get1['work'] == 1)
        {
             echo 'الهندسه';
        }
        if($get1['work'] == 2)
        {
             echo 'الطب / التمريض';
        }
        if($get1['work'] == 3)
        {
             echo 'الإدارة';
        }
        if($get1['work'] == 4)
        {
             echo 'التجارة';
        }
        if($get1['work'] == 5)
        {
             echo 'تسويق ومبيعات';
        }
        if($get1['work'] == 6)
        {
             echo 'قانون';
        }
        if($get1['work'] == 7)
        {
             echo 'الكمبيوتر والمعلومات';
        }
        if($get1['work'] == 8)
        {
             echo 'عمل خاص / رائد اعمال';
        }
        if($get1['work'] == 9)
        {
             echo 'مجال الفن والادب';
        }
        if($get1['work'] == 10)
        {
             echo 'عمل حكومي';
        }
        if($get1['work'] == 11)
        {
             echo 'لا اعمل';
        }
        if($get1['work'] == 12)
        {
             echo 'غير محدد - اخر';
        }
        echo '</p>';
        echo '<p>الدخل الشهري : ';
        if($get1['salary'] == 1)
        {
             echo 'لا يوجد دخل شهري';
        }
        if($get1['salary'] == 2)
        {
             echo 'اقل من 200 دولار';
        }
        if($get1['salary'] == 3)
        {
             echo '100-200$';
        }
        if($get1['salary'] == 4)
        {
             echo '200-500$';
        }
        if($get1['salary'] == 5)
        {
             echo '500-1000$';
        }
        if($get1['salary'] == 6)
        {
             echo '1000$-5000$';
        }
        if($get1['salary'] == 7)
        {
             echo '5000$-10000$';
        }
        if($get1['salary'] == 8)
        {
             echo 'اكثر من 15000$';
        }
        if($get1['salary'] == 9)
        {
             echo 'افضل ان لا اقول';
        }
        echo '</p>';
        echo '<b><i class="far fa-file-alt"></i> تفاصيل شريك الحياه</b>';
        echo '<p>'.$get1['lovebio'].'</p>';
        echo '<b><i class="far fa-file-alt"></i> تفاصيل عني</b>';
        echo '<p>'.$get1['bio'].'</p>';
        if($_SESSION['id'] == $_GET['id']){

        }else{
        
            //liked or not ?
            if(in_array($_SESSION['id'] ,explode(',', $get1['likes']))) {
                $liked = 'liked';
            } else {
                $liked = '';
            }

            echo '<b>هل أعجبك ؟</b><div class="like like-button ' . $liked . '" data-user-id="' . $get1['id'] . '" style="margin-right: 20px;"><i class="fas fa-thumbs-up"></i></div>';
            echo '<a href="chat?id='.$_GET['id'].'" class="_msg" style="margin-left: 20px;"><i class="far fa-envelope"></i> مراسله</a>';
            echo '<a href="report?id='.$_GET['id'].'" class="_warn"><i class="fas fa-exclamation-triangle" style="margin-left: 10px;"></i>إبلاغ</a>';
        }
    }
}

?>