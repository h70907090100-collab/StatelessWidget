
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
      home: ApiScreen(),
    );
  }
}

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  
  // دالة وهمية تحاكي جلب بيانات من سيرفر خارجي وتأخذ 3 ثوانٍ
  Future<List<String>> _fetchUserData() async {
    await Future.delayed(const Duration(seconds: 3)); // محاكاة تأخير الإنترنت
    
    // لنفترض أن هذه هي البيانات التي عادت من السيرفر
    return [
      'أحمد محمد (مطور فلاتر)',
      'سارة علي (مصممة واجهات UI/UX)',
      'خالد إبراهيم (مطور سرفرات Backend)',
      'فاطمة عمر (مهندسة برمجيات)',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التعامل مع الـ API والـ Future'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      // استخدام FutureBuilder لمراقبة حالة جلب البيانات
      body: FutureBuilder<List<String>>(
        future: _fetchUserData(), // نضع هنا الدالة غير المتزامنة
        builder: (context, snapshot) {
          
          // الحالة الأولى: جاري التحميل...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.teal),
                  SizedBox(height: 15),
                  Text('جاري جلب البيانات من السيرفر...', style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          }
          
          // الحالة الثانية: حدث خطأ أثناء الجلب
          else if (snapshot.hasError) {
            return Center(
              child: Text(
                'عذراً، حدث خطأ: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          
          // الحالة الثالثة: وصلت البيانات بنجاح تام!
          else if (snapshot.hasData) {
            final users = snapshot.data!; // استخراج البيانات القادمة
            
            return ListView.builder(
              itemCount: users.length,
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      users[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('متصل الآن'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            );
          }
          
          // حالة افتراضية أخيرة
          return const Center(child: Text('لا توجد بيانات متاحة'));
        },
      ),
    );
  }
}

*/

//تطبيق دليل المطورين 

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق المطور الشامل',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
        // تمرير الثيم لها بتاخد خاصيتين تمرير الدالة الخاصة ب التبديل و متغير اللي بيحمل الفيمة فولص او ترو
      home: HomeScreen(onThemeChanged: _toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}

// الشاشة الرئيسية     
class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeChanged;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // المتغيرات الطبيعية لإدارة الحالة مباشرة هنا متغير يحمل مهارات افتراضية 
  
  final List<String> _skillsList = ['Flutter & Dart', 'UI/UX Design', 'Git & GitHub'];
  
  // متحكم النموذج والمفتاح
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // إضافة مهارة . المفتاح وهو متغير من نوع TextEditingController مدمج  في فلاتر 
  
  final TextEditingController _skillController = TextEditingController();


  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  // دالة إضافة المهارة
  
  void _submitSkill() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _skillsList.add(_skillController.text.trim()); // إضافة مباشرة للقائمة
        
      });
      _skillController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تمت إضافة المهارة بنجاح!'), backgroundColor: Colors.green),
      );
    }
  }
  
  // محاكاة لجلب المهارات من سيرفر باستخدام Future 

  Future<List<String>> _fetchProjects() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      'تطبيق إدارة المهام (Task Manager)',
      'متجر إلكتروني مصغر (E-commerce UI)',
      'تطبيق الطقس الذكي (Weather App)',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دليل المطور الشامل'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeChanged,
            tooltip: 'تغيير النمط',
          ),
        ],
      ),
      // سكرول.   
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
 crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة الترحيب
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'مرحباً بك، أيها المطور!',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          
                          Text(
 'عدد المهارات المسجلة: ${_skillsList.length}',
         style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    // الانتقال إلي صفحة التفاصيل 
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                          // تمرير القيم إلي هذه الصفحة بهذه الطريقة واستقبالها هناك من ال constructor 
                          
                            builder: (context) => ProfileDetailsScreen(
       developerName: 'مطور فلاتر المحترف',
             skillsCount: _skillsList.length,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'أبرز المشاريع:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // FutureBuilder
            SizedBox(
              height: 180,
              child: FutureBuilder<List<String>>(
                future: _fetchProjects(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.teal));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final projects = snapshot.data!;
                    return ListView.builder(
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.teal.withOpacity(0.1),
                          child: ListTile(
                            leading: const Icon(Icons.code, color: Colors.teal),
                            
                            title: Text(projects[index]),
                            trailing: const Icon(Icons.check_circle, color: Colors.green, size: 18),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),

            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),

            // النموذج المباشر (بدون فصله في ويدجت مستقلة وبدون تمرير دالة)
            const Text(
              'أضف مهارة جديدة:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
// إضافة مهارة 

            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _skillController,
                      decoration: InputDecoration(
                        labelText: 'اسم المهارة البرمجية',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.star),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'لا يمكن أن تكون المهارة فارغة!';
                        }
                        if (value.trim().length < 3) {
                          return 'أدخل 3 أحرف على الأقل';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _submitSkill, // استدعاء الدالة المحلية مباشرة
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('إضافة'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'قائمة مهاراتك الحالية:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _skillsList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(_skillsList[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _skillsList.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailsScreen extends StatelessWidget {
  final String developerName;
  final int skillsCount;

  const ProfileDetailsScreen({
    super.key,
    required this.developerName,
    required this.skillsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الملف الشخصي'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified_user, size: 90, color: Colors.deepOrange),
              const SizedBox(height: 20),
              Text(
                'أهلاً بك يا $developerName',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'لديك حالياً $skillsCount مهارات مسجلة في التطبيق.',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('العودة للرئيسية'),
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
