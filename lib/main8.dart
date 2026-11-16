

/*
//تطبيق **"دليل المطورين الشخصي"v5
// إضافة ميزة الshared Preferences  الحفظ في ذاكرة الجهاز localstorage 

! استخدام SharedPreferences لحفظ قائمة المهارات (List<String>) سيجعل التطبيق يحتفظ ببياناته وكأنه تطبيق حقيقي متكامل.


#### 1. إضافة مكتبة shared_preferences في ملف pubspec.yaml:
تأكد من إضافة الحزمة تحت dependencies:
```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.3.2  # أو أحدث إصدار

``` بعدين عمل تنظيف و تنزيل من جديد لاعدادت فلاتر ومجلد ال build
flutter clean

flutter pub get

#### 2. التعديلات المطلوبة داخل _HomeScreenState:
أولاً، سنحتاج إلى استيراد الحزمة في أعلى ملف main.dart:
```dart
import 'package:shared_preferences/shared_preferences.dart';

```
ثانياً، سنضيف دالتين بسيطتين للحفظ والاسترجاع:
```dart
  // دالة الحفظ في الذاكرة
  Future<void> _saveSkillsToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('saved_skills', _skillsList);
  }

  // دالة الاسترجاع عند فتح التطبيق
  Future<void> _loadSkillsFromDisk() async {
    final prefs = await SharedPreferences.getInstance();
    final loadedSkills = prefs.getStringList('saved_skills');
    if (loadedSkills != null) {
      setState(() {
        _skillsList.clear();
        _skillsList.addAll(loadedSkills);
        _filteredSkills = _skillsList; // تحديث القائمة المفلترة أيضاً
      });
    }
  }

```
ثالثاً، سنقوم بتفعيل دالة الجلب _loadSkillsFromDisk() داخل **initState** لتعمل فور فتح الشاشة:
```dart
  @override
  void initState() {
    super.initState();
    _loadSkillsFromDisk(); // استرجاع البيانات المحفوظة عند البدء
  }

```
رابعاً، سنستدعي دالة الحفظ _saveSkillsToDisk() في **كل عملية** (إضافة، تعديل، حذف) داخل دالة _saveOrUpdateSkill وعند الحذف:
```dart
// في دالة الحفظ/التعديل وفي دالة الحذف، بعد كل تعديل على _skillsList نضيف هذا السطر:
_saveSkillsToDisk();

*/

//================



import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

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
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(onThemeChanged: _toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}

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

  List<String> _skillsList = []; // جعلناها فارغة لتبدأ بالتحميل من الذاكرة
  
  List<String> _filteredSkills = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  final TextEditingController _skillController = TextEditingController();
  
  final TextEditingController _searchController = TextEditingController();

  bool _isEditing = false;
  int? _editingIndex;

// دالة تهيئة التطبيق بعرض البيانات المخزنة محليا باستدعاء الدالة_loadSkillsFromDisk
 
  @override
  void initState() {
    super.initState();
    _loadSkillsFromDisk(); // 2. استرجاع البيانات المحفوظة فور بدء التطبيق👉
  }

  @override
  void dispose() {
    _skillController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  
//=============👇

  // دالة الحفظ في ذاكرة الهاتف (SharedPreferences)
  /*
  اعمل فنك غير متزامنة واستخدم ال shared preferences وخد اوبجت منها  أو نسخة  واعمل ضبط وحفظ لقيمةةمفتاح وهي قائمة ال _skillsList
  
  */
  Future<void> _saveSkillsToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('saved_skills', _skillsList);
  }

//=============👇

  // دالة الاسترجاع من ذاكرة الهاتف
  Future<void> _loadSkillsFromDisk() async {
    final prefs = await SharedPreferences.getInstance();
    
    // احصل علي قيمة المفتاح هذا وهي قائمة المهارات الأساسية 
    
    final loadedSkills = prefs.getStringList('saved_skills');
    
    // تغيير الحالة  التأكد. لو البيانات المحملة ليست من أو فارغة اجعل القائمة الرئيسية تساوي البيانات المحملة في المتغير ده لأنها هي التي حفظت في التخزين المحلي أثناء الإضافة وتعرض فور بدء التشغيل 
    
    setState(() {
      if (loadedSkills != null && loadedSkills.isNotEmpty) {
        _skillsList = loadedSkills;
      } else {
        // قيم افتراضية لو لم يجد شيئاً محفوظاً مسبقاً
        _skillsList = ['Flutter & Dart', 'UI/UX Design', 'Git & GitHub', 'REST APIs'];
      }
      _filteredSkills = _skillsList; // تحديث القائمة المفلترة
    });
  }
  
//=============

  void _filterSkills(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSkills = _skillsList;
      } else {
        _filteredSkills = _skillsList
            .where((skill) => skill.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _saveOrUpdateSkill() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (_isEditing && _editingIndex != null) {
          String updatedVal = _skillController.text.trim();
          int originalIndex = _skillsList.indexOf(_filteredSkills[_editingIndex!]);
          _skillsList[originalIndex] = updatedVal;
          
          _isEditing = false;
          _editingIndex = null;
        } else {
          _skillsList.add(_skillController.text.trim());
        }
        
        _filterSkills(_searchController.text);
      });

      _saveSkillsToDisk(); // 3. حفظ البيانات مباشرة بعد الإضافة أو التعديل👉👉
      
      _skillController.clear();
      
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

  void _startEditing(int index) {
    setState(() {
      _isEditing = true;
      _editingIndex = index;
      _skillController.text = _filteredSkills[index];
    });
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('دليل المطور الاحترافي (محفوظ محلياً)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeChanged,
            tooltip: 'تغيير النمط',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          'إجمالي المهارات: ${_skillsList.length}',
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
                            skillsCount: _skillsList.length,
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
              _isEditing ? 'تعديل المهارة الحالية:' : 'أضف مهارة جديدة:',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: _isEditing ? Colors.orange : Colors.teal,
              ),
            ),
            const SizedBox(height: 10),

            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _skillController,
                      decoration: InputDecoration(
                        labelText: _isEditing ? 'عدل اسم المهارة' : 'اسم المهارة البرمجية',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: Icon(_isEditing ? Icons.edit : Icons.star, color: Colors.teal),
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
                      onPressed: _saveOrUpdateSkill,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isEditing ? Colors.orange : Colors.teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: Text(_isEditing ? 'تعديل' : 'إضافة', style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: _searchController,
              onChanged: _filterSkills,
              decoration: InputDecoration(
                hintText: 'ابحث عن مهارة مسجلة...',
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterSkills('');
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
                  '(${_filteredSkills.length} عناصر)',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 10),

            _filteredSkills.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Center(
                      child: Text('لا توجد مهارات مطابقة للبحث', style: TextStyle(color: Colors.grey)),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredSkills.length,
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
                          title: Text(_filteredSkills[index], style: const TextStyle(fontWeight: FontWeight.w600)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                                onPressed: () => _startEditing(index),
                                tooltip: 'تعديل',
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                onPressed: () {
                                  setState(() {
                                    String itemToRemove = _filteredSkills[index];
                                    _skillsList.remove(itemToRemove);
                                    _filterSkills(_searchController.text);

                                    if (_isEditing && _editingIndex == index) {
                                      _isEditing = false;
                                      _editingIndex = null;
                                      _skillController.clear();
                                    }
                                  });
                                  //👉👇
                                  _saveSkillsToDisk(); // 4. حفظ البيانات بعد الحذف أيضاً
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
