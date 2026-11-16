


//##################
//### 4. ملف المسارات الرئيسي (`main.dart`)
/*
import 'package:flutter/material.dart';
import 'home.dart';
import 'add_notes.dart';
import 'EditNotes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      routes: {
        "home": (context) => const Home(),
        "addnotes":(context) => const AddNotes(),
        "editnotes": (context) => const EditNotes(note: '', title: '', color: '', id: 0), 
      },
    );
  }
}
*/


/*
الخطأ الذي يظهر في الصورة واضح جداً وسببه أنك تقوم بتشغيل التطبيق على **متصفح الويب (Flutter Web)** من خلال أمر مثل (flutter run -d web-server).
مكتبة sqflite التي تستخدمها مصممة أساساً للعمل على الأنظمة الفعلية (Native) مثل **أندرويد، آي أو إس، و سطح المكتب**، ولا تدعم متصفح الويب مباشرة بشكل افتراضي، مما يسبب الخطأ:
> Bad state: databaseFactory not initialized
> 
### كيف تحل هذه المشكلة؟
لديك خياران لحل هذه المشكلة تماماً:
#### الحل الأول (الأسهل والأفضل لتطبيقات قواعد البيانات المحلية):
**قم بتشغيل التطبيق على محاكي أندرويد (Android Emulator)** أو على جهازك الحقيقي الموصل بالكمبيوتر، بدلاً من تشغيله على متصفح الويب.
 * قاعدة بيانات sqflite تعمل بكفاءة تامة ودون أي مشاكل على الأندرويد والـ iOS.
#### الحل الثاني (إذا كنت ترغب فعلاً في تشغيله على المتصفح Web):
إذا كنت مُضطراً لتشغيل التطبيق على المتصفح، فسيتعين عليك استخدام حزمة داعمة للويب مثل sqflite_common_ffi_web وتهيئة الـ databaseFactory في دالة main() قبل تشغيل التطبيق هكذا:
 1. أضف الحزمة في ملف pubspec.yaml:
   ```yaml
   dependencies:
     sqflite_common_ffi_web: ^...
   
   ```
 2. قم بتعديل ملف main.dart ليقوم بالتهيئة الخاصة بالويب إذا كان التطبيق يعمل على المتصفح:
   ```dart
   import 'package:flutter/foundation.dart';
   import 'package:flutter/material.dart';
   import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
   import 'package:sqflite/sqflite.dart';
   // باقي الاستيرادات...
   
   void main() {
     // إذا كان التشغيل على الويب، نقوم بتهيئة الـ databaseFactory للويب
     if (kIsWeb) {
       databaseFactory = databaseFactoryFfiWeb;
     }
     runApp(const MyApp());
   }
   
   ```
**الخلاصة:** أنصحك بتجربة تشغيل التطبيق على **محاكي الأندرويد (Android Emulator)**، لأن مكتبات قواعد البيانات المحلية مثل sqflite أُنشئت خصيصاً لتعمل هناك، وسختفي هذا الخطأ فوراً!
👇👇👇👇
*/


// تجربة التطبيق كويب بعد عمل تعديل علي الملف هذا لاني  لاني قواعد البيانات المحلية تعمل افتراضيا علي الاندرويد او ios و٦شان تعخل عىي الويب لازم تعمل تهيئة لحزمة الويب لااملك محاكي اندرويد حاليا لاستخدام الدالة السابقة 

/*
//⭐⭐⭐⭐
import 'package:flutter/foundation.dart'; // مهم جداً للتعرف على kIsWeb
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart'; // استيراد حزمة الويب

import 'home.dart';
import 'add_notes.dart';
import 'EditNotes.dart';

void main() {
  // تهيئة قاعدة البيانات للعمل على متصفح الويب
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      routes: {
        "home": (context) => const Home(),
        "addnotes": (context) => const AddNotes(),
        "editnotes": (context) => const EditNotes(note: '', title: '', color: '', id: 0), 
      },
    );
  }
}
*/






import 'package:flutter/material.dart';

void main(){
runApp(MaterialApp(
debugShowCheckedModeBanner:false,

    home:Scaffold(
        appBar:AppBar(
            title:Text("My Restaurant", style: TextStyle (fontWeight :FontWeight.bold),),
            backgroundColor:Colors.grey
            
            ),
     body:Center(
         //سكرول افقي للبطاقات 
     child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
          //# اول كارت يكون داخل كونتينر ليتم التحكم به وعمل أكثر من عنصر دالة كصورة ونصوص الخ 
          Container (
       //# ابعاد الكونتينر    
              width: 200,
              height: 300, 
            margin: EdgeInsets.all(8),
        decoration: BoxDecoration (
            gradient: LinearGradient (
            begin: Alignment.bottomCenter, 
            end : Alignment.topCenter,
            colors:[
            Colors.grey, Colors.white
            ],
            ),//gradient
            borderRadius: BorderRadius.circular(20) ,            
        ),// decoration 
        
        //# كولمن وضع العناصر 
          child: Column (          
              children:[
              SizedBox(height: 10),
              Text ("etaline pizza",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              //# لقص حواف الصورة
              ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
       "https://cdn.babyseo.ai/images/foodshot.ai/pizza-photography-guide/pizza-photography-neapolitan-overhead-hero.webp",
            width: 130,
            height: 130,
            fit: BoxFit.cover,
            ),      
              ),//ClipRRect
              SizedBox(height: 10),
              Text("بيتزا بالجبن والخضار", style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
        Text("8 pound", style: TextStyle(fontSize: 16, color: Colors.green)),
        Text("4.8⭐⭐⭐⭐", style: TextStyle(fontSize: 16)),
        ],
        ),
        SizedBox(height: 10),
        ElevatedButton(
        onPressed: () {},
        child: Text("حجز المنتج"),
        ),
 //# يمكنك تكرار المنتح الحاوية أكثر من هنا            
                  ],
                ), 
                ) ,                                         
             //////
             
             Container (
       //# ابعاد الكونتينر    
              width: 200,
              height: 300, 
            margin: EdgeInsets.all(8),
        decoration: BoxDecoration (
            gradient: LinearGradient (
            begin: Alignment.bottomCenter, 
            end : Alignment.topCenter,
            colors:[
            Colors.orange, Colors.white
            ],
            ),//gradient
            borderRadius: BorderRadius.circular(20) ,            
        ),// decoration 
        
        //# كولم وضع العناصر 
          child: Column (          
              children:[
              SizedBox(height: 10),
              Text ("etaline pizza",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              //# لقص حواف الصورة
              ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
       "https://cdn.babyseo.ai/images/foodshot.ai/pizza-photography-guide/pizza-photography-neapolitan-overhead-hero.webp",
            width: 130,
            height: 130,
            fit: BoxFit.cover,
            ),      
              ),//ClipRRect
              SizedBox(height: 10),
              Text("بيتزا بالجبن والخضار", style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
        Text("8 pound", style: TextStyle(fontSize: 16, color: Colors.green)),
        Text("3.8⭐⭐⭐", style: TextStyle(fontSize: 16)),
        ],
        ),
        SizedBox(height: 10),
        ElevatedButton(
        onPressed: () {},
        child: Text("حجز المنتج"),
        ),
 //# يمكنك تكرار المنتح الحاوية أكثر من هنا            
                  ],
                ), 
                ) ,  
             ///////////
                       
          ],//children
        ),//Row
         
     ),//SingleChildScrollView
     ),// body
        
    ),//scaffold 
    ),//Material 
    );//runApp
}



/*
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
runApp(const MaterialApp(
debugShowCheckedModeBanner: false,
home: Home(),
));
}

class Home extends StatelessWidget {
const Home({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
 //# SafeArea لعدم تداخل التطبيق مع الشريط العلوي للهاتف الذي يضم أيقونة البطارية والشبكة الخ 
 
body: SafeArea(
child: Padding(
padding: const EdgeInsets.all(20),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Image.network(
'رابطصورةالفيسبوك_هنا',
width: 170,
height: 88,
fit: BoxFit.cover,
),
const SizedBox(height: 10),
const Text('تسجيل الدخول', style: TextStyle(fontSize: 20)),
const SizedBox(height: 20),
const TextField(
decoration: InputDecoration(
labelText: 'البريد الالكتروني',
border: OutlineInputBorder(),
isDense: true,
),
),
const SizedBox(height: 10),
const TextField(
obscureText: true,
decoration: InputDecoration(
labelText: 'كلمة المرور',
border: OutlineInputBorder(),
isDense: true,
),
),
TextButton(
onPressed: () {},
child: const Text('نسيت كلمة المرور'),
),
const SizedBox(height: 10),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: const [
IconButton(onPressed: null, icon: FaIcon(FontAwesomeIcons.google, color: Colors.red)),
IconButton(onPressed: null, icon: Icon(Icons.home)),
IconButton(onPressed: null, icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue)),
IconButton(onPressed: null, icon: FaIcon(FontAwesomeIcons.github)),
],
),

const SizedBox(height: 10),
SizedBox(
width: double.infinity,
height: 40,
child: ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: Colors.blue,
shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
),
onPressed: () {},
child: const Text('تسجيل الدخول', style: TextStyle(color: Colors.white)),
),
),
TextButton(
onPressed: () {},
child: const Text('انشاء حساب جديد'),
),
],
),
),
), SafeArea 
);// scaffold 


}
}
*/
/*
ملاحظات هامة:

الإعدادات: لا تنسَ إضافة حزمة `fontawesomeflutter` في ملف `pubspec.yaml` باستخدام الأمر: `flutter pub add fontawesomeflutter`.
الرابط: يجب استبدال نص `'رابطصورةالفيسبوك_هنا'` برابط صورة حقيقي من الإنترنت حتى تظهر الصورة في المحاكي
*/