
/*
import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}

// ==================== صفحة تسجيل الدخول ====================

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // مفتاح الفورم  وجعله private لهذا الكلاس و final

  final _formkey = GlobalKey<FormState>();

  // متغيرات الحقول جعلها من نوع TextEditingController وهو كلاس مدمج

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true; // لإظهار/إخفاء كلمة المرور

  // إزالة بيانات الإيميل والباس عند الخروج من الصفحة

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // تسجيل الدخول

  void _login() {
    // استدعاء مفتاح الفورم للتحقق لو النموذج كله صحيح تحول إلي صفحة جديدة   أو تقدر نرسلها السيرفر
    if (_formkey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("مرحبا ${_emailController.text}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تسجيل الدخول')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formkey, //  المفتاح
       // تحقق تلقائي يظهر الخطأ اسفل الخقل  تلقائيا اثناء الكتابة او حتي وهم فارغين يقول او يعطي تنبيه بالمطلوب 
            autovalidateMode:AutovalidateMode.always,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // حقل الايميل من نوع ايميل كونترولر
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "البريد الالكتروني ",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                // ال validator الخاص بالحقل ده للتحقق من صحة الشروط
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال البريد الإلكتروني';
                  }

                  if (!value.contains("@")) {
                    return 'بريد إلكتروني غير صحيح';
                  }
                  return null;
                }, // validator
              ), //TextFormField
              //===============

              // فراغ أو مساحة
              SizedBox(height: 10), //sizeBox

              TextFormField(
                controller: _passwordController,

                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),

                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),

                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      }); //setState
                    }, //onPressed
                  ), //suffixIcon
                ), // InputDecotation
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال كلمة المرور';
                  }
                  if (value.length < 6) {
                    return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                  }
                  return null;
                }, // validator
              ),

              //  SizedBox(height: 24),
              ElevatedButton(onPressed: _login, child: Text('دخول')),

              // إلي صفحة انشاء حساب
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Text('ليس لديك حساب؟ إنشاء حساب جديد'),
              ), //TextInput
            ],
          ),
        ), // column
      ), // Form
    ); //Padding

    // Scaffold
  } // build
}

// ==================== صفحة إنشاء حساب ====================

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // مفتاح حالة الفورم والتحقق من حالته الصحيحة

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  //=========
  void _signup() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إنشاء الحساب بنجاح لـ ${_nameController.text}'),
        ),
      );
      Navigator.pop(context); // الرجوع لصفحة تسجيل الدخول
    }
  } // singup

  //=========

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إنشاء حساب جديد')),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'الاسم الكامل',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال اسمك';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'بريد إلكتروني غير صحيح';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'تأكيد كلمة المرور',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'كلمة المرور غير متطابقة';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(onPressed: _signup, child: Text('إنشاء الحساب')),
            ],
          ),
        ),
      ),
    );
  }
}
*/
/*

import "package:flutter/material.dart";

void main() {
  runApp(Page4());
}
/*
class MyApp extends StatelessWidget {
  @override
  State<MyApp> createState() => Page4();
}
*/


class Page4 extends StatelessWidget {

  const Page4({super.key});

  final List images = [

    "image1", "image2",

    "image3", "image4",

    "image5", "image6",

    "image7", "image8",

  ];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home: Scaffold(

        appBar: AppBar(

          title: Text("PageView, PageViewBuilder"),

        ), // appBar

        body: Container(

          padding: EdgeInsets.all(10),

          child: Column(

            children: [

              Container(

                height: 300,

                child: PageView.builder(

                  itemCount: images.length, // لوب على طول القائمة

                  itemBuilder: (context, i) {

                    return Text(images[i]);

                  }, // itemBuilder

                ), // PageViewBuilder

              ),

            ],

          ), // Column

        ), // Container

      ), // Scaffold

    ); // MaterialApp

  }

}

*/

//==============


/*

 ال Api وتنزيل مكتبة https واستدعاؤها

terminal 
flutter pub add http

مباشرة في supspace yml
http: ^1.2.0
 
استدعاء  في الكود 
import 'package:http/http.dart' as http;


 الأوامر الأساسية: بعد إضافة أي حزمة، يجب تنفيذ `flutter clean` ثم `flutter pub get` لضمان تحديث ملفات البناء.



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApiPage extends StatefulWidget {
@override
_MyApiPageState createState() =\> _MyApiPageState();
}

class _MyApiPageState extends State<MyApiPage>{
// إضافة البيانات الناتجة هنا

List data = [];
bool isLoading = true;

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text("HTTP API Example")), 

    body: ListView (
     children:[
      Container (
          onPressed:() async {
             var response= await get("https://jsonplaceholder.typicode.com/posts");//response
             //تحويل إلي jsonDecode
             var responsebody = jsonDecode(response.body);
             data.addAll(responsebody);
             // تحديث الui
             setState (() {});
          },//onPressed:
                  child:Text("Https Request"),
      ),//Container
      
      ...List.generate(
      data.length, (index) => Card (
      child:ListTile(
         title:Text("${data[index]['title']}"),
         subtitle(Text("${data[index]['body']}")),
      ),//ListTile
      ),//Card
      
      
      ),//List.generate
     
     ]
    ),//ListView



}



الأخطاء المكتشفة
1. رمز غريب في createState
createState() =\> _MyApiPageState();   // ❌
فيه \ زايدة بالخطأ. الصحيح:
createState() => _MyApiPageState();   // ✅
2. Container لا يملك خاصية onPressed
Container(
  onPressed: () async {...},   // ❌ Container ما له onPressed أصلًا
  child: Text("Https Request"),
)
onPressed خاصية خاصة بالأزرار (ElevatedButton, TextButton...)، وليست من خصائص Container. الصحيح:
ElevatedButton(
  onPressed: () async {...},
  child: Text("Https Request"),
)
3. استدعاء get() بدون البادئة http.
var response = await get("https://...");   // ❌
بما إنك استوردت المكتبة بصيغة:
import 'package:http/http.dart' as http;
يجب استخدام البادئة http. دائمًا، وأيضًا الدالة تحتاج Uri.parse() مو نص مباشر:
var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
4. subtitle مكتوبة كدالة بدل خاصية
subtitle(Text("${data[index]['body']}")),   // ❌
نفس الخطأ المتكرر (دالة بدل خاصية named parameter):
subtitle: Text("${data[index]['body']}"),   // ✅
5. ناقصة @override قبل build
Widget build(BuildContext context) {   // ❌ ناقصة @override
6. أقواس غير متوازنة بنهاية الكود
ListView, Scaffold, build, والـ class نفسه — كلهم محتاجين إغلاق صريح ومرتب.

*/


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// لازم الدالة الرئيسية 
void main(){
    runApp(MyApiPage());
}

class MyApiPage extends StatefulWidget {
  @override
  _MyApiPageState createState() => _MyApiPageState();
}

class _MyApiPageState extends State<MyApiPage> {
  // إضافة البيانات الناتجة هنا
  List data = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HTTP API Example")),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () async {
              var response = await http.get(
                Uri.parse("https://jsonplaceholder.typicode.com/posts"),
              ); // response
              // تحويل إلى jsonDecode
              var responseBody = jsonDecode(response.body);
              data.addAll(responseBody);
              // تحديث الـ UI بعد الرد 
              setState(() {});
            }, // onPressed
            child: Text("Https Request"),
          ), // ElevatedButton
            
// انشاء ...List.generate يتم إظهار البيانات من خلالها
        /* علي طول قابمة الداتا واعملي كارت لمل ادكس فيها وبه قائمة مزيلة بعنوان المقال وعنوان فرعي بالبدي*/
            ...List.generate(
            data.length,
            (index) => Card(
              child: ListTile(
                title: Text("${data[index]['title']}"),
                subtitle: Text("${data[index]['body']}"),
              ), // ListTile
            ), // Card
          ), // List.generate
        ], // children
      ), // ListView
    ); // Scaffold
  }
}

