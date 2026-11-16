

/*
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // الشاشة الافتتاحية عند فتح التطبيق
    );
  }
}

// ================= الشاشة الرئيسية =================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 80, color: Colors.teal),
            const SizedBox(height: 20),
            const Text(
              'أهلاً بك في الصفحة الرئيسية!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            
            // زر الانتقال إلى شاشة التفاصيل مع إرسال بيانات
            ElevatedButton.icon(
              onPressed: () {
                // الانتقال للشاشة الثانية وإرسال بيانات معها (مثلاً الاسم ورقم الطلب)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  //توجه لهذه الصفحه ومرر لها تلك البيانات والتي سيستقبلها ال constructor هناك. فهي اصبحت اوبجكت من هذه الصفحة أو كلاسها 
                  
                    builder: (context) => const DetailsScreen(
                      userName: 'مطور فلاتر المحترف',
                      itemCode: 1024,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('الانتقال إلى صفحة التفاصيل'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= شاشة التفاصيل =================
class DetailsScreen extends StatelessWidget {
// المتغيرات التي ساستخدمها بعد أخذ البيانات المرسلة هناك وتخزينها فيها

  final String userName;
  final int itemCode;
  
  // استقبال البيانات عبر المُنشئ (Constructor) وهو كاني اخذت اوبجكت من كلاس DetailsScreen وقيمه هي التي مررت له هناك
  
  const DetailsScreen({
    super.key,
    required this.userName,
    required this.itemCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة التفاصيل'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.info, size: 80, color: Colors.deepOrange),
              const SizedBox(height: 20),
              const Text(
                'تم الانتقال بنجاح!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              
              // عرض البيانات المستقبلة
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('اسم المستخدم: $userName', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Text('رقم العنصر: $itemCode', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              // زر العودة للخلف يدوياً
              OutlinedButton.icon(
                onPressed: () {
                  // إزالة الشاشة الحالية والعودة للخلف
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('العودة للخلف'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.deepOrange,
                  side: const BorderSide(color: Colors.deepOrange),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

*/


import 'package:flutter/material.dart';

void main() {

       runApp(const MyApp());

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {

    return const MaterialApp(

      debugShowCheckedModeBanner: false,

      home: ImagesScreen(),

    );

  }

}

class ImagesScreen extends StatelessWidget {

  const ImagesScreen({super.key});

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('التعامل مع الصور'),

        backgroundColor: Colors.teal,

        centerTitle: true,

      ),

      body: SingleChildScrollView( // للسماح بالتمرير إذا كان المحتوى طويلاً

        padding: const EdgeInsets.all(20.0),

        child: Column(

          children: [

            const Text(

              '1. صورة من الإنترنت (Network Image)',

              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

            ),

            const SizedBox(height: 10),

            

            // جلب صورة من الإنترنت مع تحكم بالحجم والتحميل

            ClipRRect(

              borderRadius: BorderRadius.circular(15),

              child: Image.network(               'https://picsum.photos/400/200',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover, // لتعبئة المساحة بشكل متناسق

            // مؤشر أثناء تحميل الصورة من الإنترنت

                loadingBuilder: (context, child, loadingProgress) {

                  if (loadingProgress == null) return child;

                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),

                  );

                },

              ),

            ),

            

            const SizedBox(height: 30),
              
            const Divider(),

            const SizedBox(height: 20),

            const Text(

              '2. صورة محلية من الملفات (Asset Image)',

              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

            ),

            const SizedBox(height: 10),

            // استخدام صورة محلية (تأكد من إضافتها في pubspec.yaml أولاً)

            // كمثال سنستخدم CircleAvatar مع صورة أو Image.asset

            Container(

              decoration: BoxDecoration(

                shape: BoxShape.circle,

                border: Border.all(color: Colors.teal, width: 3),

              ),

              child: const CircleAvatar(

                radius: 60,

                // لو أردت وضع صورة محلية هنا:

                 backgroundImage: AssetImage('assets/images/child.jpg'),

                backgroundColor: Colors.grey,

                child: Icon(Icons.person, size: 60, color: Colors.white),

              ),

            ),

          ],

        ),

      ),

    );

  }

}