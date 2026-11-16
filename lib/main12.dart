//https://preview.flutlab.io/hussein23/statefulwidget/

/*
//تطبيق **"دليل المطورين الشخصي"v6
استخدمنا ال provider بدلا من ال setState 

استخدام ال firebase  وجعل هذا كتطبيق ويب لذلك سنستخدم معه اعدادات 
الويب من firebase لاننا نستخدم مساحة عمل وليس بها محاكي اندرويد لذلك لم نستخدم اعدادات الاندرويد

*/
/*
// استدعاءات codespace GitHub لان هيكل الملفات هناك مختلف

//import 'dart: async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

// استيراد مكتبة ال provider  وتثبيتها في pubspace.yml وعمل flutter clean and flutter pub get

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; // استيراد حزمة المصادقة

import 'auth/login_screen.dart';
*/

/*
h20058771@yahoo.com

h212121

h20058771@yahoo.com

h313131
*/

// استدعاءات flutlab.io
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// استيراد شاشة تسجيل الدخول من مجلد auth
import 'auth/login_screen.dart';
import 'dart:async'; // <--- أضف هذا السطر ف لتعمل ال unwaited

// استيراد حزمة التخزين السحابي من firebase
import 'package:cloud_firestore/cloud_firestore.dart';

import 'notifications_service.dart'; //⭐⭐⭐

import "package:firebase_messaging/firebase_messaging.dart";

//import 'package:google_sign_in/google_sign_in.dart'; // لتشغيل GoogleSignI

/*
دالة المين بعد ادخال اعدادت firebase اليها للمصادقة علي عمليات التسجيل 

*/

// two
void main() async {
 
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCiudaRDhvq4siyvh35WdA6wcaHO5smJPo",
      authDomain: "myskillsapp-a462d.firebaseapp.com",
      projectId: "myskillsapp-a462d",
      storageBucket: "myskillsapp-a462d.firebasestorage.app",
      messagingSenderId: "667538702233",
      appId: "1:667538702233:web:cbec3dc16d8762621add08",
      measurementId: "G-NMDQRW8KZZ",
    ),
  );

     // 🌟 ربط معالج الخلفية العام
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // تهيئة الخدمة وطلب الأذونات
  NotificationService notificationService = NotificationService();
  await notificationService.requestPermission(); // طباعة التوكين
  await notificationService.getDeviceToken();
  // اشعارات ال topics
  await notificationService.subscribeToTopic("skills_users");

  runApp(
    ChangeNotifierProvider(
      create: (context) => MyModel(),
      child: const MyApp(),
    ),
  );
}

/*


 بناء شاشة ترحيب متكاملة ومستقلة (WelcomeScreen) تجمع بين عدة تأثيرات أنيميشن صريحة (Explicit Animations):

 1. **تكبير الأيقونة والشعار (ScaleTransition)**: لتبدو وكأنها تنبض وتكبر من المنتصف.

 2. **الشفافية والظهور (FadeTransition)**: لتظهر العناصر تدريجياً بشكل ناعم.


*/



class WelcomeScreen extends StatefulWidget {

  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
    
  
    @override
  void initState() {
    super.initState();
    // 1. تعريف المتحكم بمدة زمنية ثانيتين
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // 2. تحريك الحجم (من صغير جداً 0.0 إلى الحجم الطبيعي 1.0)
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut, // تعطي حركة مرنة تشبه النابض (Spring)
    );
    // 3. تحريك الشفافية (من مخفي تماماً 0.0 إلى ظاهر 1.0)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn), // تبدأ وتكتمل في أول 60% من الوقت
      ),
    );

    // تشغيل الأنيميشن فور فتح الشاشة
    _controller.forward();

    // 4. الانتقال التلقائي بعد انتهاء الأنيميشن والتحقق من حالة تسجيل الدخول
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!mounted) return;

      // التحقق من حالة المستخدم عبر الـ Provider
          final myModel = Provider.of<MyModel>(context, listen: false);
          final bool isUserLoggedIn = myModel.currentUser != null;

          // الانتقال الذكي: لو مسجل اذهب للـ HomeScreen، وإلا اذهب للـ LoginScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => isUserLoggedIn ? const HomeScreen() : const LoginScreen(),
            ),
          );
        });
      }
    });
  }

  
    
    
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.teal.shade800,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // أيقونة التطبيق بتصميم جذاب
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.psychology, // رمز يعبر عن المهارات والتفكير

                    size: 80,
                    color: Colors.teal,
                  ),
                ),

                const SizedBox(height: 24),
                // عنوان التطبيق
                const Text(
                  'Skills Tracker',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'تتبع مهاراتك واحترافتك بانسيابية',
                  style: TextStyle(
             color: Colors.teal.shade100,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );    
  }
}

/*

 1. **CurvedAnimation مع Curves.elasticOut**: أعطت الشعار حركة "نابض مرن" (Elastic) عند ظهوره، وهي حركة بصرية ممتازة تمنح التطبيق شعوراً بالحيوية والنشاط.

 2. **Interval**: جعلتنا نتحكم في توقيت ظهور الشفافية بالتوازي مع حركة التكبير بدقة متناهية.

 3. **Navigator.pushReplacement**: تضمن أن المستخدم بعد أن ينتقل للشاشة الرئيسية، لا يمكنه العودة لشاشة الترحيب عند الضغط على زر الرجوع في الهاتف.

*/

    
    
    
    
    
    
    
 
//===============

// كلاس الموديل يرث من الكلاسChangeNotifier
// ================= كلاس الموديل (المنطق وإدارة الحالة) =================

// تم نقل كل الدوال والمتغيرات الي هنا واستخدام notifyListeners بدلا من setState

class MyModel extends ChangeNotifier {
  MyModel() {
    // تحميل القائمة بدون ال await  لتكون متحملة فورا دون انتظار الاتصال بالسيرفر فتحمل الافتراضية وجعلتها unwaited  لأن هذا الكلاس غير متزامن فمش طبيعي تضع فيه دالة متزامنة  لانه يحمل البيانات الافتراضية بسرعة وده المطلوب عند البدء
    unawaited(loadSkillsFromDisk());
      
    unawaited(loadThemeFromDisk()); // 🌟 تحميل الثيم المحفوظ عند بدء التشغيل
  }

  // المتغيرات ... نستخدم get مع المتغيرات بدون _ ليكون عام والمزود يقدر يزود به اي كلاس اخري او صفحة اخري

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;    
  List<String> _skillsList = [];
  List<String> get skillsList => _skillsList;
  List<String> _filteredSkills = [];
  List<String> get filteredSkills => _filteredSkills;
  bool _isEditing = false;
  bool get isEditing => _isEditing;
  int? _editingIndex;
  int? get editingIndex => _editingIndex;

//متغير  التخزين السحابي
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // دالة تبديل الثيم
/*
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // كنا نستخدم ال setState في بالبداية
  }
*/
    
  // 🌟 دالة لتحميل الثيم المحفوظ مسبقاً من الذاكرة المحلية
    
  Future<void> loadThemeFromDisk() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool('is_dark_mode') ?? false;
      notifyListeners();
    } catch (e) {
      // في حال حدوث أي خطأ، يبقى على القيمة الافتراضية
    }
  }

  // 🌟 دالة تبديل الثيم وحفظ حالته فوراً
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_dark_mode', _isDarkMode);
    } catch (e) {
      // معالجة الخطأ بصمت
    }
    notifyListeners(); 
  }    
    
    
    
  //======

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // معرف المستخدم الحالي (لو مسجل دخول أم لا)
  User? get currentUser => _auth.currentUser;

//=======⭐===========
  // الحصول علي اسم المستخدم الحالي لبترحيب به واذا كان ايميل فقط نرحب عن طريق ايميله

/*
استخدام ال Getter بتراجع قيمة محسوبة أو تحسب عدة قيم في وقت واحد مرة يتم استدعاؤها فيها وهي ليست فنكشن لذلك لا تستدعي باقواس ولا يمرر لها باراميترز وليس متغير عادي ثابت يرجع قيم ثابتة بل دي بتراجع قسم بتتحسب كل مرة كل اللي فيها مرة واحدة 
*/

  String get currentUserName {
    //    * جلب كائن المستخدم الحالي المخزن في مصادقة فايربيز (Firebase Auth) وتخزينه في متغير محلي للاختصار

    final user = currentUser;
    // جلب اسم العرض الدخول لليوزر لو مش null ومنه علي ال displayName لو مش null كاسمه علي جوجل لو دخل لحساب جوجل وقص المسافات الزائدة
    final displayName = user?.displayName?.trim();
    // لو موجودين رجع الاسم
    if (displayName != null && displayName.isNotEmpty) {
      return displayName;
    }
// ولو مافيش اسم ودخل بحساب الايميل هذا اول جزء منه قبل ال @ واعرضه ورجعه لو مكنش نلل والا رجع القيمة الافتراضية دي   : 'مطور المستقبل';

    final emailName = user?.email?.split('@').first.trim();
    return emailName != null && emailName.isNotEmpty
        ? emailName
        : 'مطور المستقبل';
  }
//=======⭐===========

  // 1. دالة إنشاء حساب جديد (Register)
// الدالة المعدلة

//👉 ملحوظة
// موال تسجيل الدخول والانشاء دوال جاهزة من الموقع علي فايربيس استخدمناها مع تعديلات بسيطة عليها

  // 1. دالة إنشاء حساب جديد (Register)

  Future<bool> signUp(
    String email,
    String password,
    BuildContext context,
  ) async {
    final normalizedEmail = email.trim();
    late final UserCredential userCredential;

    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      _showErrorSnackBar(context, e.message ?? 'حدث خطأ في التسجيل');
      return false;
    }

    final user = userCredential.user;
    if (user == null) {
      _showErrorSnackBar(
        context,
        'تم إنشاء الحساب، لكن تعذر الوصول إلى بيانات المستخدم لإرسال رسالة التحقق',
      );
      return false; //👉
    } else {
      try {
        await user.sendEmailVerification();

        // 🛡️ الخطوة الحاسمة: تسجيل الخروج فوراً لفرض تفعيل البريد قبل الدخول
        await _auth.signOut();

        _showSuccessSnackBar(
          context,
          'تم إنشاء الحساب وإرسال رسالة التحقق إلى بريدك الإلكتروني',
        );
      } on FirebaseAuthException catch (e) {
        _showErrorSnackBar(
          context,
          'تم إنشاء الحساب، لكن تعذر إرسال رسالة التحقق: '
          '${e.message ?? 'يرجى المحاولة لاحقاً'}',
        );
        return false; //👉
      }
    }

    notifyListeners();
    return true; //
  }

/*
:
 1. **فصل معالجة الأخطاء (Separation of Concerns):**
   * فصلت خطوة createUserWithEmailAndPassword في كتلة try-catch مستقلة. هذا يعني أنه لو حدث خطأ أثناء التسجيل (مثل إيميل مستخدم مسبقاً أو كلمة مرور ضعيفة)، سيتوقف التنفيذ فورا ويعرض رسالة الخطأ المناسبة ولا يكمل باقي الكود.
   
 2. **التحقق من وجود المستخدم (user == null):**
   * التعامل بحذر مع كائن الـ user الناتج والتأكد من أنه ليس null قبل محاولة إرسال البريد يمنع حدوث أخطاء مفاجئة في النظام (Null Safety Crashes).
   
 3. **تدرج رسائل النجاح والتحذير:**
   * إذا تم إنشاء الحساب بنجاح ولكن فشل إرسال رسالة التحقق لأسباب شبكية مثلاً، لن يفترض التطبيق أن كل شيء تم بسلاسة، بل سيعلم المستخدم أن حسابه أُنشئ وهناك مشكلة بسيطة في إرسال البريد، مما يمنح شفافية تكاملية عالية.
   
 4. **تنظيم إدخال البريد الإلكتروني (normalizedEmail):**
   * استخدام trim() بذكاء في البداية يحمي التطبيق من أخطاء المسافات الزائدة التي يكتبها المستخدمون أحياناً دون أن يشعروا عند إدخال إيميلاتهم.

*/

  // 2. دالة تسجيل الدخول (Login)
/*
الدالة المعدلة  حيث firebase لايوفر خماية مطلقة حيث يستطيع المستخدم الدخول بعد ان انشاء حساب والتحول الي صفحة تسجيل الدخول والدخول بالبيانات قبل تفعيل البريد الالكتروني فقمنا بتعديلها بحيث تمنعه من الدخو٦قبل التفعيل في الرابط المرسل له
*/
  Future<bool> signIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      // 1. تنفيذ تسجيل الدخول وجلب بيانات المستخدم
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = userCredential.user;

      // 🛡️ 2. التحقق مما إذا كان البريد مفَعلاً أم لا
      if (user != null && !user.emailVerified) {
        // إذا لم يكن مفعلاً، نقوم بتسجيل الخروج فوراً ونمنع دخوله
        await _auth.signOut();

        _showErrorSnackBar(
          context,
          'بريدك الإلكتروني غير مفعل! يرجى التحقق من بريدك وتفعيل الحساب أولاً.',
        );
        return false; // منع الانتقال للـ Home
      }

      // إذا كان البريد مفَعلاً، يُسمح بالدخول طبيعياً
      notifyListeners();
      return true; // نجح الدخول

    } on FirebaseAuthException catch (e) {
      _showErrorSnackBar(
        context,
        e.message ?? 'البريد أو كلمة المرور غير صحيحة',
      );
      return false;
    }
  }

  // 3. دالة تسجيل الخروج (SignOut)
  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

//=======================
// استعادة كلمة المرور

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      _showSuccessSnackBar(
          context, 'تم إرسال رابط استعادة كلمة المرور إلى بريدك الإلكتروني');
    } on FirebaseAuthException catch (e) {
      _showErrorSnackBar(context, e.message ?? 'حدث خطأ أثناء إرسال الرابط');
    }
  }

//=======================

  // دالة مساعدة لإظهار رسائل الخطأ
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // دالة مساعدة لإظهار رسائل النجاح (تأكد من وجودها أو أضفها)
  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  //=========

//========//الحفظ والتسترجاع في التخزين السحابي firebase  الدوال المعدلة⭐⭐⭐⭐⭐

// 1. الاسترجاع من Cloud Firestore (مع الحفاظ على الذاكرة المحلية كاحتياط)
  Future<void> loadSkillsFromDisk() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        // جلب المستند الخاص بالمستخدم من مجموعة users في سحابة Firestore صاحب ال uid
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();
        // لو فيه بيانات مهارات في المستند والمستند اصلا موجود
        if (doc.exists && doc.data() != null) {
          // اعمل متغير ضع فيه تلك البيانات كماب من نوع dynamic
          final data = doc.data() as Map<String, dynamic>;
          // والبيانات دي لو فيه مفتاح فيها اسمه skills  رجع قائمة نصية بهم
          if (data.containsKey('skills')) {
            _skillsList = List<String>.from(data['skills']);
          }
          // والا
        } else {
          // إذا كانت هذه هي المرة الأولى، نضع مهارات افتراضية ونحفظها في السحابة
          _skillsList = [
            'Flutter & Dart',
            'UI/UX Design',
            'Git & GitHub',
            'REST APIs',
            "---------------------",
            "---------------------",
              
          ];
          await saveSkillsToDisk();
        }
      } catch (e) {
        // في حال حدوث خطأ في الاتصال، نلجأ للذاكرة المحلية كخيار بديل

        final prefs = await SharedPreferences.getInstance();
        final loadedSkills = prefs.getStringList('saved_skills');
        if (loadedSkills != null && loadedSkills.isNotEmpty) {
          _skillsList = loadedSkills;
        } else {
          _skillsList = [
            'Flutter & Dart',
            'UI/UX Design',
            'Git & GitHub',
            'REST APIs',
             "---------------------",
             "---------------------",
          ];
        }
      }
    } else {
      // إذا لم يكن هناك مستخدم مسجل دخول
      _skillsList = [
        'Flutter & Dart',
        'UI/UX Design',
        'Git & GitHub',
        'REST APIs',
          "---------------------",
          "---------------------",
      ];
    }

    _filteredSkills = _skillsList;
    notifyListeners();
  }

  // 2. الحفظ في Cloud Firestore (مع التخزين المحلي الاحتياطي)
  Future<void> saveSkillsToDisk() async {
    final user = _auth.currentUser;

    // حفظ محلي دائماً كنسخة احتياطية سريعة
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('saved_skills', _skillsList);

    // حفظ سحابي في Firestore إذا كان المستخدم مسجلاً

    if (user != null) {
      try {
        //ادخل من كلاس ال firestore المدمج إلي كائن ال collection الذي يحمل جدول المستخدمين منه علي ال dic اللي لها البيانات وخش علي هذا المستخدم صاحب ال uid واحفظ القيم الآتية

        await _firestore.collection('users').doc(user.uid).set({
          'skills': _skillsList,
          'email': user.email,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      } catch (e) {
        // معالجة الأخطاء السحابية بصمت أو طباعتها دون تعطيل التطبيق
      }
    }
  }

// فلترة وبحث المهارات

  void filterSkills(String query) {
    if (query.isEmpty) {
      _filteredSkills = _skillsList;
    } else {
      _filteredSkills = _skillsList
          .where((skill) => skill.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // كنا نضع setState سابقا
  }

//========

  // دالة التعديل

  void startEditing(int index, TextEditingController controller) {
    _isEditing = true;
    _editingIndex = index;
    controller.text = _filteredSkills[index];
    notifyListeners();
  }

  // إضافة أو تعديل مهارة

  void saveOrUpdateSkill(
    TextEditingController controller,
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) {
    if (formKey.currentState!.validate()) {
      final wasEditing = _isEditing && _editingIndex != null;

      if (_isEditing && _editingIndex != null) {
        String updatedVal = controller.text.trim();
        int originalIndex = _skillsList.indexOf(
          _filteredSkills[_editingIndex!],
        );
        if (originalIndex != -1) {
          _skillsList[originalIndex] = updatedVal;
        }
        _isEditing = false;
        _editingIndex = null;
      } else {
        _skillsList.add(controller.text.trim());
      }

      _filteredSkills = List.from(_skillsList);
      saveSkillsToDisk();
      controller.clear();
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            wasEditing ? 'تم تحديث المهارة بنجاح!' : 'تمت إضافة المهارة بنجاح!',
          ),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
         ),
        ),
      );
    }
  }

    
  // حذف مهارة

  void deleteSkill(int index, TextEditingController controller) {
    String itemToRemove = _filteredSkills[index];
    // هنا خزن العنصر اللي انخءف في متغير يعمي من القائمة خزن  صاحب الاندكس ده اللي هو  اتحذف

    int originalIndex = _skillsList.indexOf(itemToRemove);
    // إزالة العنصر من القائمتين
    _skillsList.remove(itemToRemove);
    _filteredSkills = List.from(_skillsList);
    saveSkillsToDisk();
    if (_isEditing && _editingIndex == index) {
      _isEditing = false;
      _editingIndex = null;
      controller.clear();
    }
    notifyListeners();
  }

/*
*ملاحظة برمجية ذكية:* لكي نقوم بعملية التراجع بشكل مثالي مع الـ SnackBar، سنقوم باستدعاء التراجع من داخل شاشة HomeScreen عند ظهور الـ SnackBar، أو يمكننا إنشاء دالة مساعدة خاصة بإعادة العنصر (undoDelete).

دعنا نضيف دالة الـ undoDelete في MyModel:
    */

  // دالة لإعادة المهارة المحذوفة في حال ضغط المستخدم على "تراجع"

  void restoreSkill(String skill, int index) {
    if (index >= 0 && index <= _skillsList.length) {
      _skillsList.insert(index, skill);
    } else {
      _skillsList.add(skill);
    }
    _filteredSkills = List.from(_skillsList);
    saveSkillsToDisk();
    notifyListeners();
  }
}

// ================= الواجهة الرئيسية MyApp =================
// تم تحويله إلي StatelessWidget لانه ليس هو من يدير الحالة الان

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. مراقبة الموديل هنا لتغيير الثيم فوراً خزنا الكلاس في متغير للتعامل مع المتغير مباشرة بدلا من الموديل مباشرة

    final myModel = context.watch<MyModel>();
// التحقق مما إذا كان المستخدم مسجل الدخول بالفعل عمل متغير bool  والوصول الي متغير ال currentUser اللي في MyModel وقيمته التساوي نلل يعني مسجل دخول افتراضيا

    final bool isUserLoggedIn = myModel.currentUser != null;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق المطور الاحترافي',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      themeMode: myModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // إذا كان مسجلاً للدخول انتقل للرئيسية، وإلا افتح شاشة تسجيل الدخول
      //home: isUserLoggedIn ? const HomeScreen() : const LoginScreen(),
        home: const WelcomeScreen(),
        
    );
  }
}

/*
*/

// ================= شاشة HomeScreen المحسنة (UI/UX احترافي) =================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    NotificationService notificationService = NotificationService();

    // تفعيل الاستماع للإشعارات
    notificationService.initForegroundMessageListener(context);
    notificationService.initNotificationClickListeners(context);
  }

  @override
  void dispose() {
    _skillController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<List<String>> _fetchProjects() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return [
      'تطبيق إدارة المهام (Task Manager)',
      'متجر إلكتروني مصغر (E-commerce UI)',
      'تطبيق الطقس الذكي (Weather App)',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final myModel = context.watch<MyModel>();
    final isDark = myModel.isDarkMode;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'متبع المهارات الاحترافي',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 0.5),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
            onPressed: () => context.read<MyModel>().toggleTheme(),
            tooltip: 'تغيير النمط',
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'تسجيل الخروج',
            onPressed: () async {
              await context.read<MyModel>().signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌟 1. بطاقة الترحيب العصرية (Gradient Card)
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF004D40), const Color(0xFF00796B)]
                      : [Colors.teal.shade700, Colors.teal.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(isDark ? 0.2 : 0.35),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.person_rounded,
                          size: 38, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          
                          /*
                        Text(
                          'أهلاً بك، ${myModel.currentUserName} 👋',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        */
                          TweenAnimationBuilder (
       tween:Tween(begin:0.0, end :1.0) ,
        duration: Duration (seconds:5),
        builder :(context, value, child){
            return Transform.scale (
            scale:value,//Scale
       origin:Offset(0,0),//(100.100)Scale            
                child:Center(
                    child:Container(
                      child: Text(
  'أهلاً بك، ${myModel.currentUserName} 👋'),
      //width:50, height:50,
      // color:Colors.gray,
      ),//con                    
      ),//center
       );// transform 
        },//builder 
        ),//TweenAnimationBuilder
                          
                          
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'إجمالي المهارات: ${myModel.filteredSkills.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.white, size: 20),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileDetailsScreen(
                            developerName: 'مطور فلاتر المحترف',
                            skillsCount: myModel.filteredSkills.length,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

              
              
            // 🌟 2. قسم المشاريع (FutureBuilder)
            const Text(
              'أبرز المشاريع المميزة:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 160,
              child: FutureBuilder<List<String>>(
                future: _fetchProjects(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.teal));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final projects = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 240,
                          margin: const EdgeInsets.only(left: 12),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.teal.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.code_rounded,
                                        color: Colors.teal, size: 22),
                                  ),
                                  const Spacer(),
                                  Text(
                                    projects[index],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'مكتمل بنجاح 🚀',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),

              //#############
              
            const SizedBox(height: 20),
            const Divider(height: 30),

            // 🌟 3. حقل الإدخال والإضافة / التعديل
            Text(
              myModel.isEditing ? 'تعديل المهارة الحالية:' : 'أضف مهارة جديدة:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: myModel.isEditing ? Colors.orange.shade800 : Colors.teal,
              ),
            ),
            const SizedBox(height: 12),

            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _skillController,
                      decoration: InputDecoration(
                        labelText: myModel.isEditing
                            ? 'عدل اسم المهارة'
                            : 'اسم المهارة البرمجية',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              color: myModel.isEditing
                                  ? Colors.orange
                                  : Colors.teal,
                              width: 2),
                        ),
                        prefixIcon: Icon(
                          myModel.isEditing
                              ? Icons.edit_rounded
                              : Icons.star_rounded,
                          color:
                              myModel.isEditing ? Colors.orange : Colors.teal,
                        ),
                        filled: true,
                        fillColor: isDark ? Colors.grey[900] : Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'لا يمكن أن يكون الحقل فارغاً!';
                        }
                        if (value.trim().length < 3) {
                          return 'أدخل 3 أحرف على الأقل';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<MyModel>().saveOrUpdateSkill(
                              _skillController,
                              _formKey,
                              context,
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            myModel.isEditing ? Colors.orange : Colors.teal,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                      ),
                      child: Text(
                        myModel.isEditing ? 'تعديل' : 'إضافة',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 🌟 4. حقل البحث العصري
            TextField(
              controller: _searchController,
              onChanged: (query) => context.read<MyModel>().filterSkills(query),
              decoration: InputDecoration(
                hintText: 'ابحث عن مهارة مسجلة...',
                prefixIcon:
                    const Icon(Icons.search_rounded, color: Colors.teal),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _searchController.clear();
                          context.read<MyModel>().filterSkills('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.teal, width: 2),
                ),
                filled: true,
                fillColor: isDark ? Colors.grey[900] : Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'قائمة مهاراتك الحالية:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${myModel.filteredSkills.length} عناصر',
                    style: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 🌟 5. قائمة المهارات بتصميم بطاقات أنيقة
            myModel.filteredSkills.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.folder_open_rounded,
                              size: 60, color: Colors.grey.shade400),
                          const SizedBox(height: 10),
                          const Text(
                            'لا توجد مهارات مطابقة للبحث',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: myModel.filteredSkills.length,
                    itemBuilder: (context, index) {
                // 👇تغليف البطاقات بكلتس الانيميشن 
               return AnimatedSkillCard (
                    index:index,//⭐
               //⭐ وصع الكارت كطفل لكلاس التغليف 
                       child:Card(
                        elevation: 1.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SkillDetailScreen(
                                  skillName: myModel.filteredSkills[index],
                                ),
                              ),
                            );
                          },
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal.withOpacity(0.15),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            myModel.filteredSkills[index],
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_rounded,
                                    color: Colors.blue, size: 20),
                                onPressed: () => context
                                    .read<MyModel>()
                                    .startEditing(index, _skillController),
                                tooltip: 'تعديل',
                              ),

                              IconButton(
                                icon: const Icon(Icons.delete_rounded,
                                    color: Colors.redAccent, size: 20),
                                onPressed: () {
                                  // 1. حفظ البيانات المؤقطة قبل الحذف

                                  String deletedSkill =
                                      myModel.filteredSkills[index];

                                  int deletedIndex =
                                     myModel.skillsList.indexOf(deletedSkill);//⭐⭐⭐

                                  // 2. تنفيذ الحذف

                                  context
                                      .read<MyModel>()
                                      .deleteSkill(index, _skillController);

                                  // 3. إظهار SnackBar مع خيار التراجع (Undo)
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars(); // إزالة أي SnackBar قديم

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('تم حذف "$deletedSkill"'),
                                      action: SnackBarAction(
                                        label: 'تراجع (Undo)',
                                        textColor: Colors.tealAccent,
                                        onPressed: () {
                                          // استدعاء دالة الاستعادة
                                          context.read<MyModel>().restoreSkill(
                                              deletedSkill, deletedIndex);
                                        },
                                      ),
                                      duration: const Duration(seconds: 4),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  );
                                },
                                tooltip: 'حذف',
                              ), //delete button
                            ],
                          ),
                        ),
                      ),//AnimationSkillCa
                   );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

/*

يعني دوال التنفيذ حذف تعديل إضافة نستخدم معها read والتي ترسم الواجهة watch 

واستخدام متغير اولا افضل final Mymodel

لقد أمسكت بالجوهر الهندسي لـ Provider تماماً:

 1. **قاعدة الـ read:** نستخدمها حصرياً مع **الأحداث والدوال** (مثل: ضغطة زر، إضافة، حذف، تعديل، تنفيذ طلب API) لأننا نريد تنفيذ أمر ولا نحتاج إلى إعادة رسم الشاشة في تلك اللحظة بالذات.

 2. **قاعدة الـ watch:** نستخدمها مع **البيانات والمتغيرات** التي تظهر على الشاشة (مثل: حالة الثيم، طول القائمة، النصوص، الألوان) لكي تتولى مراقبتها وإعادة رسم الواجهة تلقائياً فور تغيرها.

 3. **قاعدة المتغير final myModel = context.watch<MyModel>();:** هذه هي **أرقى وأقصر طريقة** لتنظيف كودك، حيث تُغنيك عن تكرار كتابة الكود الطويل في كل عنصر، وتجعل قراءة الشاشة سهلة ومنظمة تماماً مثل الشركات الكبرى.

*/
// ================= صفحة التفاصيل =================

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
    const Color deepOrange = Colors.deepOrange;

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الملف الشخصي'),
        backgroundColor: deepOrange,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified_user, size: 90, color: deepOrange),
              const SizedBox(height: 20),
              Text(
                'أهلاً بك يا $developerName',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
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
                  foregroundColor: deepOrange,
                  side: const BorderSide(color: deepOrange),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SkillDetailScreen extends StatelessWidget {
  final String skillName;

  const SkillDetailScreen({super.key, required this.skillName});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(skillName),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.shade700,
                    
                    Colors.tealAccent ?? Colors.teal.shade300
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.star_rounded, size: 48, color: Colors.white),
                  const SizedBox(height: 16),
                  const Text(
                    'المهارة البرمجية:',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    skillName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'ملاحظات وتفاصيل إضافية:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: const Text(
                  'هذه المساحة مخصصة لكتابة ملاحظات تفصيلية حول هذه المهارة، روابط مشاريع قمت بتنفيذها باستخدامها، أو خطط تطوير مستواك فيها قريباً 🚀',
                  style:
                      TextStyle(fontSize: 15, height: 1.5, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}










/*
كلاس انيميشن جاهز يمكن استخدامه مع أي عنصر  لتطبيق الانيميشن عليه فقط بتغليف ذلك العنصر له 

بدلاً من تطبيق الأنيميشن على مستوى الصفحة كاملة، سنقوم بإنشاء **ويدجت مستقلة وصغيرة** لكل بطاقة مهارة (AnimatedSkillCard).
هذه الويدجت ستستفيد من:
 1. **AnimationController**: خاص بالبطاقة نفسها.
 2. **SlideTransition**: لتحريك البطاقة من أسفل إلى الأعلى (Offset).
 3. **FadeTransition**: لزيادة الشفافية من 0.0 إلى 1.0.
 4. **حساب التأخير الزمني (Delay)** بناءً على ترتيب البطاقة في القائمة (index)، بحيث تظهر البطاقة الأولى فوراً، ثم تليها الثانية بفارق بسيط، وهكذا!
### الخطوة الأولى: إنشاء ويدجت البطاقة المتحركة (AnimatedSkillCard)
يمكنك وضع هذا الكلاس في أي مكان مناسب داخل مشروعك (أو في نهاية ملف main.dart):

import 'package:flutter/material.dart';
*/

class AnimatedSkillCard extends StatefulWidget {

/*
Final Widget child; هنا هل تقصد الويدجت نفسه ال AnimatedSkillCard عند استخدامه في البطاقات هناك وتغليفهم به

عندما قمنا بإنشاء كلاس مستقل اسمه AnimatedSkillCard، جعلناه بمثابة **"صندوق تغليف أو قالب متحرك"** (Wrapper Widget)، ووظيفته الوحيدة هي أخذ أي ويدجت تمرره إليه وإضافته داخل تأثيرات الأنيميشن (SlideTransition و FadeTransition).

أنت هنا تقول لفلاتر: *"يا AnimatedSkillCard، خذ هذه الـ Card (البطاقة العادية التي تعرض تفاصيل المهارة) وضعها بداخلك، وطبق عليها حركة الظهور المتتابع بناءً على الـ index الخاص بها"*.
 ويمكنك إعادة استخدام AnimatedSkillCard مع أي عنصر آخر في التطبيق بكل سهولة!
*/

  final Widget child;
  final int index;

  const AnimatedSkillCard({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<AnimatedSkillCard> createState() => _AnimatedSkillCardState();
}

class _AnimatedSkillCardState extends State<AnimatedSkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _cardController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600), // مدة حركة كل بطاقة
    );

    // حركة الانزلاق من الأسفل للأعلى (من Offset(0, 0.5) إلى Offset.zero)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOutCubic,
    ));

    // حركة الشفافية من المخفي للظاهر
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardController,
        curve: Curves.easeIn,
      ),
    );

    // 🌟 السر هنا: حساب تأخير زمني (Delay) يعتمد على الـ index الخاص بالبطاقة!
    // كلما زاد الـ index، تأخر ظهور البطاقة قليلاً عن التي قبلها
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _cardController.forward();
      }
    });
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
