


//تطبيق **"دليل المطورين الشخصي"v4
// إضافة ميزة الفلتره.وتطوير ال UI  

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
      title: 'تطبيق المطور الشامل المطور',
      // ثيمات مخصصة تليق بتطبيق احترافي
      
      // light theme 
      
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          /*
          // غير متوافق مع الاصدار
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
          */
      ),
      
      //dark theme  
      
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFF121212),
          /*
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        */
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

  // القائمة الأصلية للمهارات الافتراضية
  
  final List<String> _skillsList = ['Flutter & Dart', 'UI/UX Design', 'Git & GitHub', 'REST APIs'];
  
  // قائمة البحث (تعرض النتائج المفلترة)
  
  List<String> _filteredSkills = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  final TextEditingController _skillController = TextEditingController();
  
  // ال search 
  final TextEditingController _searchController = TextEditingController();

  bool _isEditing = false;
  int? _editingIndex;

//دالة تهيئة تعمل عند بدء التشغيل خاصة بالفلترة حيث القائمة الملفترة تطابق الأصلية 

  @override
  void initState() {
    super.initState();
    _filteredSkills = _skillsList; // في البداية، القائمة المفلترة تطابق القائمة الأصلية
  }

  @override
  void dispose() {
    _skillController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  

  // 👇👇دالة البحث والفلترة
  //query)**: هذه هي القيمة أو الكلمة التي يُدخلها المستخدم في شريط البحث (نص استعلام البحث)، وسنقوم بفحص القائمة بناءً عليها.
  
  void _filterSkills(String query) {
    setState(() {
// لو فارغ الحقل ترجع القائمة الاصلية   يعني القائمة الملفترة تساوي القائمة الاصلية يعني كأنه مافيش قائمة مفلترة 

      if (query.isEmpty) {
        _filteredSkills = _skillsList;
      } else {
// والا خش علي القائمة الاصلية واعمل لوب علي كل عنصر skill وحوله لاحرف صغيرة وتأكد من شرط أنه يحتوي علي النص اللي كتبه المستخدم query بعد تحويله الحرف صغيرة وقم بتحويل النتيجة الظاهرة إلي قائمة حتي تستطيع خاصية ListView عرضها 
  
        _filteredSkills = _skillsList
            .where((skill) => skill.toLowerCase().contains(query.toLowerCase()))
            .toList();
            
            /*
            where((skill) => ...)**: دالة جاهزة في قوائم Dart، تمر على كل عنصر في القائمة الأصلية واحداً تلو الآخر (سنسمي العنصر المؤقت skill)، وتختبره بناءً على الشرط الذي سنضعه. العناصر التي تنطبق عليها الشروط ستبقى، والباقي سيتم استبعاده.
            */
      }
    });
  }
  
  //=================

  // إضافة أو تعديل مهارة
  void _saveOrUpdateSkill() {
    if (_formKey.currentState!.validate()) {
      setState(() {
      // لو ضغطنا تعديل ترو وكان العنصر يحمل رقم حقيقي اعمل الاتي 
      
        if (_isEditing && _editingIndex != null) {
        // أظهار القيمة الأصلية بأخذها من المتغير الاصلي والقائمة الاصلية لازهارها في مربع التعديل
        
          String updatedVal = _skillController.text.trim();
          
          int originalIndex = _skillsList.indexOf(_filteredSkills[_editingIndex!]);
          /*     
          👇👇
// هنا ندمج البحث لماذا لأن احيانا يبحث المستخدم عن مهمة وتظهر ويريد تعديلها هي وفي البحث مباشرة يعني في قائمة البحث فممكن يكون ترتيبها في قائمة البحث الملفترة يختلف عن ترتيبها في الأصلية  فهذا السطر يبحث عن الترتيب الحقيقي للعنصر الملفتر في القائمة الاصلية   بعض النظر عن ترتيبه الظاهر في البحث أو القائمة الملفترة 
          */
          
          //نقوم بتبديل القيمة القديمة بالقيمة الجديدة في القائمة الأصلية.          
          _skillsList[originalIndex] = updatedVal;
          
      //اغلاق وضع التعديل وتحويل اندكس التعديل إلي null كما كانو ليتحول الحقل إلي وضع الإضافة 
             
          _isEditing = false;
          _editingIndex = null;
        } else {
          // إضافة عنصر جديد
          _skillsList.add(_skillController.text.trim());
        }
        // تحديث فلتر البحث بعد التعديل
        /*
        خطوة ذكية جداً! بعد أن عدلنا أو أضفنا العنصر، نقوم بإعادة تشغيل دالة البحث بنفس الكلمة المكتوبة في شريط البحث لكي تتحدث القائمة المرئية أمام المستخدم فوراً ولا يحدث أي تضارب في العرض.
 * ثم نغلق قوس الـ setState.
        */
        _filterSkills(_searchController.text);
      });
      
//### 7. تنظيف الحقل وإظهار رسالة النجا

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
        title: const Text('دليل المطور الاحترافي', style: TextStyle(fontWeight: FontWeight.bold)),
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
            // 1. بطاقة الترحيب والإحصائيات الفاخرة
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

            // 2. قسم الـ FutureBuilder للمشاريع
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

            // 3. نموذج الإضافة والتعديل بتصميم عصري
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

            // 4. حقل البحث السريع (Search Bar)
            TextField(
              controller: _searchController,
              // بحث فوري أو تحديث لحظي باي حرف يكتبه يحوله للفلتره لمطابقته
              onChanged: _filterSkills,
              decoration: InputDecoration(
                hintText: 'ابحث عن مهارة مسجلة...',
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
                
                // أيقونة التنظيف 
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterSkills('');
                        },
                      )
// ولو فارغ خلاص رجع null مفيش شي مك
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

            // 5. قائمة المهارات مع خاصية السحب للحذف أو الأزرار الاحترافية
            
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
//تخزين اندكس العنصر  اللي هيتحذف بأخذه من متغير القائمة الملفترة وتحريره للقائمة الرئيسية لحذفه                                
                                    String itemToRemove = _filteredSkills[index];
                                    _skillsList.remove(itemToRemove);
                                    _filterSkills(_searchController.text);

                                    if (_isEditing && _editingIndex == index) {
                                      _isEditing = false;
                                      _editingIndex = null;
                                      _skillController.clear();
                                    }
                                  });
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
سؤال ذكي للغاية! ملاحظتك دقيقة جداً وتدل على أنك تقرأ الكود بعين مهندس فاحص.
السبب في أننا استخدمنا **القائمة المفلترة (_filteredSkills)** داخل الـ ListView.builder بدلاً من القائمة الأصلية (_skillsList) هو **منطق العرض أثناء البحث والتصفية**:
### تخيل هذا السيناريو:
 1. لديك قائمة أصلية تحتوي على 10 مهارات (_skillsList).
 2. قام المستخدم بكتابة حرف "F" في شريط البحث.
 3. دالة البحث قامت بفلترة العناصر وأنتجت قائمة جديدة اسمها _filteredSkills لا تحتوي إلا على مهارة واحدة فقط مطابقة (مثل "Flutter") وحجمها أصبح 1.
 * **لو كنا نستخدم القائمة الأصلية (_skillsList) في الـ ListView:**
   لكانت الشاشة عرضت الـ 10 مهارات كلها بحجة أنها الأصلية، وتجاهلت تماماً ما كتبه المستخدم في شريط البحث! ولما ظهرت النتيجة المطابقة وحدها.
 * **باستخدام القائمة المفلترة (_filteredSkills) في الـ ListView:**
   نحن نخبر الـ ListView: *"اعرضي فقط العناصر الموجودة في نتائج البحث الحالية"*. فإذا كتب المستخدم شيئاً، ستعرض القائمة المطابقة فقط (عنصر واحد مثلاً)، وإذا مسح حقل البحث، ستصبح _filteredSkills مطابقة تماماً للقائمة الأصلية (_skillsList) فتظهر جميع المهارات.
### باختصار شديد:
 * **_skillsList:** هو **"المستودع الرئيسي"** أو قاعدة البيانات التي نحفظ ونحذف ونعدل فيها.
 * **_filteredSkills:** هو **"المرآة أو الشاشة"** التي تعرض للمستخدم ما يبحث عنه لحظياً.
لذلك، يجب أن تكون الـ ListView موجهة دائماً لرؤية **"المرآة" (_filteredSkills)** لكي تتغير العناصر على الشاشة أمام المستخدم فوراً أثناء الكتابة في شريط البحث!
هل أصبحت هذه الجزئية واضحة ولماذا نفضل ربط الواجهة بالقائمة المفلترة؟

*/

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

