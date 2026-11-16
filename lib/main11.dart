
/*
//تطبيق **"دليل المطورين الشخصي"v6
استخدمنا ال provider بدلا من ال setState 
*/

    



import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';

void main() {

  runApp(
      //تغليف التطبيق بالمزود 
    ChangeNotifierProvider(
      create: (context) => MyModel()..loadSkillsFromDisk(), // استدعاء  القائم الافتراضية التحميل فور التشغيل

      child: const MyApp(),

    ),

  );

}

// ================= كلاس الموديل (المنطق وإدارة الحالة) =================
// تم نقل كل الدوال والمتغيرات الي هنا واستخدام notifyListeners بدلا من setState 
class MyModel extends ChangeNotifier {

  bool _isDarkMode = false;
// نستخدم get مع المتغيرات بدون _ ليكون عام والمزود يقدر يزود به اي كلاس اخري او صفحة اخري
  bool get isDarkMode => _isDarkMode;

  List<String> _skillsList = [];

  List<String> _filteredSkills = [];

  List<String> get filteredSkills => _filteredSkills;

  bool _isEditing = false;

  bool get isEditing => _isEditing;

  int? _editingIndex;

  int? get editingIndex => _editingIndex;

  // دالة تبديل الثيم

  void toggleTheme() {

    _isDarkMode = !_isDarkMode;

    notifyListeners();// كنا نستخدم ال setState في بالبداية 

  }

  // الاسترجاع من الذاكرة المحلية

  Future<void> loadSkillsFromDisk() async {

    final prefs = await SharedPreferences.getInstance();

    final loadedSkills = prefs.getStringList('saved_skills');

    

    if (loadedSkills != null && loadedSkills.isNotEmpty) {

      _skillsList = loadedSkills;

    } else {

      _skillsList = ['Flutter & Dart', 'UI/UX Design', 'Git & GitHub', 'REST APIs'];

    }

    _filteredSkills = _skillsList;

    notifyListeners();

  }

  // الحفظ في الذاكرة المحلية

  Future<void> saveSkillsToDisk() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('saved_skills', _skillsList);

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

    notifyListeners();

  }

  // بدء وضع التعديل

  void startEditing(int index, TextEditingController controller) {

    _isEditing = true;

    _editingIndex = index;

    controller.text = _filteredSkills[index];

    notifyListeners();

  }

  // إضافة أو تعديل مهارة

  void saveOrUpdateSkill(TextEditingController controller, GlobalKey<FormState> formKey, BuildContext context) {

    if (formKey.currentState!.validate()) {

      if (_isEditing && _editingIndex != null) {

        String updatedVal = controller.text.trim();

        int originalIndex = _skillsList.indexOf(_filteredSkills[_editingIndex!]);

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

          content: Text(_isEditing ? 'تم تحديث المهارة بنجاح!' : 'تمت إضافة المهارة بنجاح!'),

          backgroundColor: Colors.teal,

          behavior: SnackBarBehavior.floating,

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

        ),

      );

    }

  }

  // حذف مهارة

  void deleteSkill(int index, TextEditingController controller) {

    String itemToRemove = _filteredSkills[index];

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

}

// ================= الواجهة الرئيسية MyApp =================

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {

    final myModel = context.watch<MyModel>();

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

      home: const HomeScreen(),

    );

  }

}

// ================= شاشة HomeScreen (مع المتحكمات) =================

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

  void dispose() {

    _skillController.dispose();

    _searchController.dispose();

    super.dispose();

  }

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
// قمنا بتخزين الموديل في متغير لاستخدام المتغير بشكل اسهل مباشرة ونستخدم الموديل نفسه في المسائل الني تحتاج ذلك مثل الحءف نستخدم . MyModel مباشرة 
    final myModel = context.watch<MyModel>();

    return Scaffold(

      appBar: AppBar(

        title: const Text('دليل المطور الاحترافي (Provider)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

        backgroundColor: Colors.teal,

        centerTitle: true,

        elevation: 0,

        actions: [

          IconButton(

            icon: Icon(myModel.isDarkMode ? Icons.light_mode : Icons.dark_mode),

            onPressed: () {

              context.read<MyModel>().toggleTheme();

            },

            tooltip: 'تغيير النمط',

          ),

        ],

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16.0),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // بطاقة الترحيب والانتقال لصفحة التفاصيل

            Container(

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                gradient: const LinearGradient(

                  colors: [Colors.teal, Colors.tealAccent],

                  begin: Alignment.topLeft,

                  end: Alignment.bottomRight,

                ),

                borderRadius: BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(

                    color: Colors.teal.withOpacity(0.3),

                    blurRadius: 10,

                    offset: const Offset(0, 5),

                  ),

                ],

              ),

              child: Row(

                children: [

                  const CircleAvatar(

                    radius: 35,

                    backgroundColor: Colors.white,

                    child: Icon(Icons.person, size: 40, color: Colors.teal),

                  ),

                  const SizedBox(width: 15),

                  Expanded(

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        const Text(

                          'أهلاً بك، مطور المستقبل!',

                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),

                        ),

                        const SizedBox(height: 5),

                        Text(

                          'إجمالي المهارات: ${myModel.filteredSkills.length}',

                          style: const TextStyle(color: Colors.white70, fontSize: 14),

                        ),

                      ],

                    ),

                  ),

                  IconButton(

                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),

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

            const Text(

              'أبرز المشاريع (FutureBuilder):',

              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

            ),

            const SizedBox(height: 10),

            // قائمة المشاريع الافتراضية

            SizedBox(

              height: 170,

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

                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

                          margin: const EdgeInsets.symmetric(vertical: 6),

                          child: ListTile(

                            leading: Container(

                              padding: const EdgeInsets.all(8),

                              decoration: BoxDecoration(

                                color: Colors.teal.withOpacity(0.1),

                                shape: BoxShape.circle,

                              ),

                              child: const Icon(Icons.code, color: Colors.teal, size: 20),

                            ),

                            title: Text(projects[index], style: const TextStyle(fontWeight: FontWeight.w500)),

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

            const SizedBox(height: 15),

            Text(

              myModel.isEditing ? 'تعديل المهارة الحالية:' : 'أضف مهارة جديدة:',

              style: TextStyle(

                fontSize: 16, 

                fontWeight: FontWeight.bold,

                color: myModel.isEditing ? Colors.orange : Colors.teal,

              ),

            ),

            const SizedBox(height: 10),

            // حقل الإدخال وزر الإضافة أو التعديل مع الفورم

            Form(

              key: _formKey,

              child: Row(

                children: [

                  Expanded(

                    child: TextFormField(

                      controller: _skillController,

                      decoration: InputDecoration(

                        labelText: myModel.isEditing ? 'عدل اسم المهارة' : 'اسم المهارة البرمجية',

                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

                        prefixIcon: Icon(myModel.isEditing ? Icons.edit : Icons.star, color: Colors.teal),

                        filled: true,

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

                  const SizedBox(width: 10),

                  SizedBox(

                    height: 56,

                    child: ElevatedButton(

                      onPressed: () {

                        context.read<MyModel>().saveOrUpdateSkill(_skillController, _formKey, context);

                      },

                      style: ElevatedButton.styleFrom(

                        backgroundColor: myModel.isEditing ? Colors.orange : Colors.teal,

                        foregroundColor: Colors.white,

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

                        padding: const EdgeInsets.symmetric(horizontal: 20),

                      ),

                      child: Text(myModel.isEditing ? 'تعديل' : 'إضافة', style: const TextStyle(fontSize: 16)),

                    ),

                  ),

                ],

              ),

            ),

            const SizedBox(height: 25),

            // حقل البحث

            TextField(

              controller: _searchController,

              onChanged: (query) {

                context.read<MyModel>().filterSkills(query);

              },

              decoration: InputDecoration(

                hintText: 'ابحث عن مهارة مسجلة...',

                prefixIcon: const Icon(Icons.search, color: Colors.teal),

                suffixIcon: _searchController.text.isNotEmpty

                    ? IconButton(

                        icon: const Icon(Icons.clear),

                        onPressed: () {

                          _searchController.clear();

                          context.read<MyModel>().filterSkills('');

                        },

                      )

                    : null,

                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

                filled: true,

              ),

            ),

            const SizedBox(height: 15),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                const Text(

                  'قائمة مهاراتك الحالية:',

                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

                ),

                Text(

                  '(${myModel.filteredSkills.length} عناصر)',

                  style: const TextStyle(color: Colors.grey),

                ),

              ],

            ),

            const SizedBox(height: 10),

            // عرض القائمة مع أزرار التعديل والحذف

            myModel.filteredSkills.isEmpty

                ? const Padding(

                    padding: EdgeInsets.all(30.0),

                    child: Center(

                      child: Text('لا توجد مهارات مطابقة للبحث', style: TextStyle(color: Colors.grey)),

                    ),

                  )

                : ListView.builder(

                    shrinkWrap: true,

                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: myModel.filteredSkills.length,

                    itemBuilder: (context, index) {

                      return Card(

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

                        margin: const EdgeInsets.symmetric(vertical: 6),

                        child: ListTile(

                          leading: CircleAvatar(

                            backgroundColor: Colors.teal.withOpacity(0.2),

                            child: Text(

                              '${index + 1}',

                              style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),

                            ),

                          ),

                          title: Text(myModel.filteredSkills[index], style: const TextStyle(fontWeight: FontWeight.w600)),

                          trailing: Row(

                            mainAxisSize: MainAxisSize.min,

                            children: [

                              IconButton(

                                icon: const Icon(Icons.edit, color: Colors.blue, size: 20),

                                onPressed: () {

                                  context.read<MyModel>().startEditing(index, _skillController);

                                },

                                tooltip: 'تعديل',

                              ),
/*
                              IconButton(

                                icon: const Icon(Icons.delete, color: Colors.red, size: 20),

                                onPressed:
             context.read<MyModel>().deleteSkill(index, _skillController);

                                },

                                tooltip: 'حذف',

                              ),
                                */

IconButton (
  icon: const Icon(Icons.delete, color: Colors.red, size: 20),

  onPressed: () {

    // التصحيح: إغلاق القوس بشكل صحيح بعد تمرير البراميترات

    context.read<MyModel>().deleteSkill(index, _skillController);

  },

  tooltip: 'حذف',

),
                            ],

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

                  foregroundColor: deepOrange,

                  side: const BorderSide(color: deepOrange),

                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}