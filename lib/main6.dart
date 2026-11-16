


//تطبيق **"دليل المطورين الشخصي"v3

// إضافة ميزة التعديل 

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

      

          // هنا ويدجت الثيم بتاخد قيمة لها الافتراضي أنها فولص كما في المتغير اعلي بقوله لو فولص رجع ? الويدجت ده المدمج وهو ثيم الدارك والا ايلص : رجع الفاتح يعني عند النقر علي زر التبديل 

          

      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),

      

      // تمرير الدالة الواجهة الرئيسية  مباراميتر  واعطاء قيمة الخاصية المدمجة onThemeChanged بقيمتها الدالة التبديلية وكذلك قيمة المتغير هي قيمته الحالية 

      

      home: HomeScreen(onThemeChanged: _toggleTheme, isDarkMode: _isDarkMode),

    );

  }

}

class HomeScreen extends StatefulWidget {

  final VoidCallback onThemeChanged;

  final bool isDarkMode;

// أخذ اوبجكت من هذا الكلاس ليستقبل القسم التي تم تمريرها لها هناك وتخزين في تلك المتغيرات 

  const HomeScreen({

    super.key,

    required this.onThemeChanged,

    required this.isDarkMode,

  });

  @override

  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> _skillsList = ['Flutter & Dart', 'UI/UX Design', 'Git & GitHub'];

  

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _skillController = TextEditingController();

  // متغيرات خاصة لإدارة عملية التعديل (Update)

  

  bool _isEditing = false; // هل نحن في وضع التعديل أم الإضافة؟

  

  int? _editingIndex;      // مؤشر العنصر الذي يتم تعديله حالياً

  @override

  void dispose() {

    _skillController.dispose();

    super.dispose();

  }

  // دالة الإضافة أو التعديل المشتركة

  void _saveOrUpdateSkill() {

    if (_formKey.currentState!.validate()) {

      setState(() {

        if (_isEditing && _editingIndex != null) {

          // حالة التعديل: استبدال النص القديم بالنص الجديد في نفس المؤشر

          _skillsList[_editingIndex!] = _skillController.text.trim();

          

          // إعادة الوضع إلى طبيعته (إضافة جديد)

          _isEditing = false;

          _editingIndex = null;

        } else {

          // حالة الإضافة العادية

          _skillsList.add(_skillController.text.trim());

        }

        

      });

      _skillController.clear();

      

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(_isEditing ? 'تم تحديث المهارة بنجاح!' : 'تمت إضافة المهارة بنجاح!'),

          backgroundColor: Colors.green,

        ),

      );

    }

  }

  // دالة تحضير التطبيق للتعديل عند الضغط على أيقونة القلم. تمرير اندكس المهمة وجعله int في القوس

  

  void _startEditing(int index) {

    setState(() {

      _isEditing = true;// فعل وضع التعديل 

      _editingIndex = index;// تمرير اندكسه للمتغير

      

      _skillController.text = _skillsList[index]; 

      

      // وضع النص القديم في الحقل تلقائياً يعني خش علي القائمة علي الاندكس ده وخليه يساوي قيمة ال _skillController.text 

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

        title: const Text('دليل المطور الشامل (CRUD)'),

        backgroundColor: Colors.teal,

        centerTitle: true,

        actions: [

        // زر تغيير القيم في appBar 

        //عمل widget.قبل المتغير لأن المتغير isDarkMode في كلاس لوحده أو في كلاس منفصل

        

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

                    IconButton(

                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.teal),

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

            ),

            const SizedBox(height: 20),

            const Text(

              'أبرز المشاريع:',

              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

            ),

            const SizedBox(height: 10),

            // FutureBuilder وعمل لوب للعرض

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

                            // عرض المهاره كل مرة لوب صاحبة الاندكس المقابل لها

                                                        

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

            // عنوان يتغير ديناميكياً حسب الحالة (إضافة أو تعديل)

            

            Text(

              _isEditing ? 'تعديل المهارة الحالية:' : 'أضف مهارة جديدة:',

              style: TextStyle(

                fontSize: 16, 

                fontWeight: FontWeight.bold,

                color: _isEditing ? Colors.orange : Colors.teal,

              ),

            ),

                

            const SizedBox(height: 10),

            // نموذج الإدخال والتعديل

            Form(

              key: _formKey,

              child: Row(

                children: [

                  Expanded(

                    child: TextFormField(

                      controller: _skillController,

                      decoration: InputDecoration(

                      // الليبول تتغير لو زقر تعديل إلي عدل المهارة والا معناها إضافة 

                        labelText: _isEditing ? 'عدل اسم المهارة' : 'اسم المهارة البرمجية',

                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

                        // الأيقونة تعديل لو اختار تعديل والا تبقي إضافة 

                        

                        prefixIcon: Icon(_isEditing ? Icons.edit : Icons.star),

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

                  // زر التعديل والإضافة الديناميكي

                  ElevatedButton(

                    onPressed: _saveOrUpdateSkill,

                    style: ElevatedButton.styleFrom(

                      backgroundColor: _isEditing ? Colors.orange : Colors.teal,

                      foregroundColor: Colors.white,

                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),

                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                    ),

                    

                    // النص ولون الزر يتغيران حسب حالة التعديل

    child: Text(_isEditing ? 'تعديل' : 'إضافة'),

                  ),

                ],

              ),

            ),

            const SizedBox(height: 20),

            

            // عرض المهارات 

            

            const Text(

              'قائمة مهاراتك الحالية:',

              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

            ),

            const SizedBox(height: 10),

            // قائمة المهارات مع أزرار الحذف والتعديل

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

                    // أزرار التحكم (تعديل + حذف)

                    trailing: Row(

                      mainAxisSize: MainAxisSize.min,

                      children: [

                      

            // زر التعديل

            

                        IconButton(

                          icon: const Icon(Icons.edit, color: Colors.blue),

                          onPressed: () => _startEditing(index),

                        ),

                        

                        // زر الحذف

                        IconButton(

                          icon: const Icon(Icons.delete, color: Colors.red),

                          onPressed: () {

                            setState(() {

                              _skillsList.removeAt(index);

                              // لو كنا نعدل نفس العنصر وتم حذفه، نلغي وضع التعديل

                              if (_isEditing && _editingIndex == index) {

                                _isEditing = false;

                                _editingIndex = null;

                                _skillController.clear();

                              }

                            });

                          },

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

//  التفاصيل 

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

/*

### 1. لماذا وضعنا علامة الاستفهام int? _editingIndex؟

في لغة Dart، علامة الاستفهام تعني أن هذا المتغير **قابل لأن يكون قيمته null (فارغاً)** إلى جانب احتمالية أن يكون رقماً صحيحاً (int). يعني تعني وضع احتمالين لهذا المتغير اي بقيمته

 * **السبب بوضوح:**

   عندما يفتح المستخدم التطبيق لأول مرة أو يكون في وضع **إضافة مهارة جديدة**، لا يوجد أساساً عنصر نقوم بتعديله، وبالتالي يجب أن تكون قيمة _editingIndex هي **null** (أي لا يوجد عنصر محدد للتعديل).

   لكن عندما يضغط المستخدم على أيقونة التعديل (القلم) لعنصر معين في الترتيب رقم 2 مثلاً، تصبح قيمة _editingIndex = 2.

   لذلك استخدمنا int? لكي نسمح للمتغير بأن يكون null في الوضع العادي، ويحمل رقماً صحيحاً فقط عند الحاجة للتعديل.

   

### 2. لماذا كتبنا widget. قبل isDarkMode و onThemeChanged؟

**استنتاجك دقيق 100%!**

نعم، السبب هو أن هذين المتغيرين **غير موجودين** داخل الكلاس الحالي (_HomeScreenState)، بل تم تمريرهما من الكلاس الأب الخارجي (HomeScreen) الذي يغلفهما.

 * **للتوضيح أكثر:**

   في Flutter، عندما نستخدم StatefulWidget، ينقسم الكود إلى كلاسين:

   1. **كلاس الـ Widget الأساسي (HomeScreen):** وهو الذي يستقبل البيانات من الخارج (عبر الـ Constructor مثل الثيم ودالة التغيير).

   2. **كلاس الحالة (_HomeScreenState):** وهو المكان الذي نكتب فيه الأكواد والمتغيرات التفاعلية وواجهة الـ build().

بما أن المتغيرات isDarkMode و onThemeChanged مسجلة في الكلاس الأب (HomeScreen) ونحن نحاول قراءتها من داخل كلاس الحالة (_HomeScreenState)، فإن لغة Dart تتطلب منا كتابة كلمة **widget.** في البداية لكي تفهم أننا نقصد: *"اذهب إلى الكلاس الأب (widget) وأحضر لنا هذه القيمة منه"*.

هل أصبحت الصورة واضحة تماماً بالنسبة لك؟ تحليل ممتاز، وإذا أردت أن نخطو الخطوة التالية نحو إدارة الحالة المتقدمة، فأنا جاهز!

*/