
//################# home.dart

//### 2. الصفحة الرئيسية (`home.dart`)
//#تحتوي على الزر العائم (**FloatingActioonButton**) للانتقال لصفحة الإضافة، وعرض الملاحظات المسجلة من قاعدة البيانات باستخدام **FutureBuilder**:

/*
import 'package:flutter/material.dart';
import 'sqldb.dart';
import 'EditNotes.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];
  
  // متحكم لحقل البحث لتتبع ما يكتبه المستخدم
  TextEditingController searchController = TextEditingController();

  // جلب البيانات (مع إمكانية البحث بـ SQL)
  Future readData({String query = ''}) async {
    List response;
    
    if (query.isEmpty) {
      // جلب كل الملاحظات إذا كان حقل البحث فارغاً
      response = await sqlDb.readData("SELECT * FROM notes");
    } else {
      // استخدام Raw SQL مع LIKE للبحث في العنوان أو النص
      response = await sqlDb.readData(
        "SELECT * FROM notes WHERE title LIKE '%$query%' OR note LIKE '%$query%'"
      );
    }

    notes.clear();
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState(){
    readData();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دفتر الملاحظات'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed("addnotes");
          // تحديث القائمة عند العودة مع الحفاظ على نتيجة البحث
          readData(query: searchController.text); 
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // 🌟 1. حقل البحث باستخدام Raw SQL
            TextField(
              controller: searchController,
              onChanged: (value) {
                // البحث الفوري كلما كتب المستخدم حرفاً
                readData(query: value);
              },
              decoration: InputDecoration(
                hintText: "ابحث في الملاحظات...",
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          readData(); // إعادة تحميل كل الملاحظات عند مسح البحث
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
            const SizedBox(height: 10),

            // 🌟 2. عرض الملاحظات أو رسالة عدم وجود نتائج
            Expanded(
              child: isLoading 
                  ? const Center(child: CircularProgressIndicator())
                  : notes.isEmpty
                      ? const Center(
                          child: Text(
                            "لا توجد ملاحظات مطابقة للبحث 🔍",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (context, i){
                            return Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text(
                                  "${notes[i]['title']}",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text("${notes[i]['note']}"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // زر الحذف
                                    IconButton(
                                      onPressed: () async {
                                        int response = await sqlDb.deleteData(
                                          "DELETE FROM notes WHERE id = ${notes[i]['id']}"
                                        );
                                        if (response > 0){
                                          notes.removeWhere((element) => element['id'] == notes[i]['id']);
                                          setState(() {});
                                        }
                                      },                  
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),                    
                                    ),
                                    // زر التعديل
                                    IconButton(
                                      onPressed: () async {
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => EditNotes(                    
                                              note: notes[i]['note'],
                                              title: notes[i]['title'],
                                              color: notes[i]['color'],
                                              id: notes[i]['id'],
                                            ),
                                          ),
                                        );
                                        readData(query: searchController.text);
                                      },
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                    ),                    
                                  ],
                                ),                 
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
*/




/*
### كيف يعمل هذا الاستعلام؟ (LIKE '%query%')
 * الرمز % في SQL يعني "أي عدد من الحروف قبل أو بعد الكلمة".
 * عندما يبحث المستخدم عن حرف أو كلمة، فإن الاستعلام يبحث في عمود الـ title أو الـ note عن أي ملاحظة تحتوي على هذه الحروف، بغض النظر عن مكانها في النص.
*/





/*
 خطوة رائعة جداً! الآن بعد أن استقر الجانب البرمجي وقاعدة البيانات، حان الوقت لنمنح التطبيق طابعاً جمالياً واحترافياً يرفع من تجربة المستخدم (UI/UX).
سنبدأ بتطبيق **أهم تحسينين بصريين ووظيفيين** في الصفحة الرئيسية (home.dart):
 1. **تفعيل الألوان الديناميكية للبطاقات:** جعل لون خلفية الملاحظة يتغير بناءً على القيمة المخزنة في حقل color.
 2. **نافذة تأكيد الحذف (AlertDialog):** لمنع حذف أي ملاحظة بالخطأ ولإعطاء شعور بالتطبيقات الاحترافية.
### أولاً: كيف نحول قيمة حقل اللون (color) إلى لون حقيقي في الفلاتر؟
يمكننا دالة بسيطة تحول النص المدخل (مثل red, blue, green, yellow) إلى لون حقيقي، أو استخدام ألوان افتراضية إذا كان الحقل فارغاً.
### الكود المحدث لـ home.dart (مع الألوان وتأكيد الحذف):
قم بتحديث ملف **home.dart** بالكامل بهذا الكود المحسّن:
```dart
    */
/*
import 'package:flutter/material.dart';
import 'sqldb.dart';
import 'EditNotes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  Object? loadError;
  List notes = [];
  int _readRequest = 0;

  final TextEditingController searchController = TextEditingController();

  Future<void> readData({String query = ''}) async {
    final request = ++_readRequest;
    if (mounted) {
      setState(() {
        isLoading = true;
        loadError = null;
      });
    }

    try {
      final List response;
      if (query.isEmpty) {
        response = await sqlDb.readData('SELECT * FROM notes');
      } else {
        response = await sqlDb.readData(
          'SELECT * FROM notes WHERE title LIKE ? OR note LIKE ?',
          ['%$query%', '%$query%'],
        );
      }

      if (!mounted || request != _readRequest) return;
      setState(() {
        notes = response;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted || request != _readRequest) return;
      setState(() {
        loadError = error;
        isLoading = false;
      });
    }
  }

  // 🎨 دالة لتحويل نص اللون إلى كائن Color حقيقي في فلاتر
  Color _getNoteColor(String? colorStr) {
    if (colorStr == null) return Colors.white;
    switch (colorStr.trim().toLowerCase()) {
      // اللون الأحمر أو الوردي
      case 'red':
      case 'أحمر':
      case 'احمر':
        return Colors.red.shade50;
      // اللون الأصفر أو البرتقالي
      case 'yellow':
      case 'أصفر':
      case 'اصفر':
        return Colors.amber.shade50;
      // اللون الأخضر
      case 'green':
      case 'أخضر':
      case 'اخضر':
        return Colors.green.shade50;
      // اللون الأزرق
      case 'blue':
      case 'أزرق':
      case 'ازرق':
        return Colors.blue.shade50;
      default:
        return Colors.white; // اللون الافتراضي
    }
  }

  // 🛑 دالة إظهار نافذة تأكيد الحذف
  void _showDeleteDialog(int noteId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد من رغبتك في حذف هذه الملاحظة نهائياً؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // إغلاق النافذة بدون حذف
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // إغلاق النافذة أولاً
              try {
                final response = await sqlDb.deleteData(
                  'DELETE FROM notes WHERE id = ?',
                  [noteId],
                );
                if (response > 0 && mounted) {
                  setState(() {
                    notes.removeWhere((element) => element['id'] == noteId);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم حذف الملاحظة بنجاح 🗑️')),
                  );
                }
              } catch (error) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تعذر حذف الملاحظة: $error')),
                  );
                }
              }
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('دفتر الملاحظات'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed("addnotes");
          readData(query: searchController.text);
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // حقل البحث
            TextField(
              controller: searchController,
              onChanged: (value) => readData(query: value),
              decoration: InputDecoration(
                hintText: "ابحث في الملاحظات...",
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          readData();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
            const SizedBox(height: 10),

            // عرض الملاحظات
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : loadError != null
                      ? Center(child: Text('تعذر التحميل: $loadError'))
                      : notes.isEmpty
                          ? const Center(
                              child: Text(
                                "لا توجد ملاحظات مطابقة للبحث 🔍",
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: notes.length,
                              itemBuilder: (context, i) {
                                final noteItem = notes[i];
                                final colorString = noteItem['color']?.toString();
                                
                                return Card(
                                  elevation: 3,
                                  margin: const EdgeInsets.symmetric(vertical: 6),
                                  // 🎨 تطبيق لون خلفية ديناميكي للبطاقة بناءً على حقل color
                                  color: _getNoteColor(colorString),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      "${noteItem['title']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text("${noteItem['note']}"),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // زر الحذف (يفتح نافذة التأكيد)
                                        IconButton(
                                          onPressed: () => _showDeleteDialog(noteItem['id'] as int),
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                        ),
                                        // زر التعديل
                                        IconButton(
                                          onPressed: () async {
                                            await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => EditNotes(
                                                  note: noteItem['note'] as String,
                                                  title: noteItem['title'] as String,
                                                  color: colorString ?? '',
                                                  id: noteItem['id'] as int,
                                                ),
                                              ),
                                            );
                                            await readData(query: searchController.text);
                                          },
                                          icon: const Icon(Icons.edit, color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
### ماذا أضفنا في هذا التحديث؟
 1. **دالة _getNoteColor:** تفحص الكلمة المكتوبة في حقل اللون (مثل red أو أصفر) وتعطي البطاقة درجة لون خفيفة ومريحة للعين، وتتركها بيضاء افتراضياً إذا كان الحقل فارغاً.
 2. **دالة _showDeleteDialog:** تمنع الحذف المفاجئ وتعرض رسالة منبثقة احترافية تتأكد من رغبة المستخدم في الحذف.
جرب هذا التحديث في مشروعك، وأخبرني كيف تبدو النظرة الجمالية للبطاقات الآن!

*/


/*

../lib/home.dart:241:45: Error: Too many positional arguments: 1 allowed, but 2 found.

Try removing the extra positional arguments.

        List response = await sqlDb.readData(

                                            ^

../lib/home.dart:249:17: Error: Final variable 'response' must be assigned before it can be used.

        notes = response;

                ^^^^^^^^

../lib/home.dart:302:56: Error: Too many positional arguments: 1 allowed, but 2 found.

Try removing the extra positional arguments.

                final response = await sqlDb.deleteData(

                                                       ^

Compile failed

../lib/home.dart:241:45: Error: Too many positional arguments: 1 allowed, but 2 found.

Try removing the extra positional arguments.

        List response = await sqlDb.readData(

                                            ^

../lib/home.dart:249:17: Error: Final variable 'response' must be assigned before it can be used.

        notes = response;

                ^^^^^^^^

../lib/home.dart:302:56: Error: Too many positional arguments: 1 allowed, but 2 found.

Try removing the extra positional arguments.

                final response = await sqlDb.deleteData(

                                        
السبب في هذا الخطأ واضح 
في الكود السابق، قمنا بتحديث استدعاءات sqlDb.readData و sqlDb.deleteData لتستقبل معاملين (مثل استعلام الـ SQL وقائمة المعاملات arguments)، ولكن ملف قاعدة البيانات لديك (sqldb.dart) في النسخة الحالية يقبل **معاملاً واحداً فقط** (نص الاستعلام sql فقط).

### 🛠️ الحل بكل بساطة:

لديك خياران، والأسهل والأسرع هو **تعديل استدعاءات الدوال في home.dart** لتتوافق مع ما يقبله ملف sqldb.dart لديك حالياً (والذي يعتمد على تمرير قيم المتغيرات داخل جملة الـ SQL مباشرة).

قم بتحديث ملف **home.dart** بالكامل بالنسخة التالية المتوافقة تماماً:

```dart
*/
import 'package:flutter/material.dart';

import 'sqldb.dart';

import 'EditNotes.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override

  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  Object? loadError;
  List notes = [];
  int _readRequest = 0;

  final TextEditingController searchController = TextEditingController();

  Future<void> readData({String query = ''}) async {

    final request = ++_readRequest;

    if (mounted) {

      setState(() {
        isLoading = true;
        loadError = null;

      });

    }

    try {
      final List response;
      if (query.isEmpty) {
        response = await sqlDb.readData('SELECT * FROM notes');

      } else {
        // استخدام الطريقة المباشرة لتجنب مشاكل الـ arguments في sqldb الحالي

        response = await sqlDb.readData(
          "SELECT * FROM notes WHERE title LIKE '%$query%' OR note LIKE '%$query%'"

        );

      }

      if (!mounted || request != _readRequest) return;

      setState(() {

        // تحويل الاستجابة إلى List> بسلام

        notes = List.from(response);
        isLoading = false;
      });

    } catch (error) {
      if (!mounted || request != _readRequest) return;

      setState(() {
        loadError = error;
        isLoading = false;

      });

    }

  }

  // 🎨 دالة لتحويل نص اللون إلى كائن Color حقيقي في فلاتر

  Color _getNoteColor(String? colorStr) {

    if (colorStr == null) return Colors.white;

    switch (colorStr.trim().toLowerCase()) {

      case 'red':
      case 'أحمر':
      case 'احمر':  

        return Colors.red.shade50;

      case 'yellow':
      case 'أصفر':
      case 'اصفر':

        return Colors.amber.shade50;

      case 'green':
      case 'أخضر':
      case 'اخضر':    

        return Colors.green.shade50;

      case 'blue':
      case 'أزرق':
      case 'ازرق':

        return Colors.blue.shade50;
      default:
        return Colors.white;

    }

  }

  // 🛑 دالة إظهار نافذة تأكيد الحذف

  void _showDeleteDialog(int noteId) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(

        title: const Text('تأكيد الحذف'),

        content: const Text('هل أنت متأكد من رغبتك في حذف هذه الملاحظة نهائياً؟'),

        actions: [

          TextButton(

            onPressed: () => Navigator.of(context).pop(),

            child: const Text('إلغاء'),

          ),

          TextButton(

            onPressed: () async {

              Navigator.of(context).pop();

              try {

                final response = await sqlDb.deleteData(

                  'DELETE FROM notes WHERE id = $noteId',

                );

                if (response > 0 && mounted) {

                  setState(() {

                    notes.removeWhere((element) => element['id'] == noteId);

                  });

                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(content: Text('تم حذف الملاحظة بنجاح 🗑️')),

                  );

                }

              } catch (error) {

                if (mounted) {

                  ScaffoldMessenger.of(context).showSnackBar(

                    SnackBar(content: Text('تعذر حذف الملاحظة: $error')),

                  );

                }

              }

            },

            child: const Text('حذف', style: TextStyle(color: Colors.red)),

          ),

        ],

      ),

    );

  }

  @override

  void initState() {

    super.initState();

    readData();

  }

  @override

  void dispose() {

    searchController.dispose();

    super.dispose();

  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text('دفتر الملاحظات'), centerTitle: true),

      floatingActionButton: FloatingActionButton(

        onPressed: () async {

          await Navigator.of(context).pushNamed("addnotes");

          readData(query: searchController.text);

        },

        child: const Icon(Icons.add),

      ),

      body: Container(

        padding: const EdgeInsets.all(10),

        child: Column(

          children: [

            // حقل البحث

            TextField(

              controller: searchController,

              onChanged: (value) => readData(query: value),

              decoration: InputDecoration(

                hintText: "ابحث في الملاحظات...",

                prefixIcon: const Icon(Icons.search, color: Colors.blue),

                suffixIcon: searchController.text.isNotEmpty

                    ? IconButton(

                        icon: const Icon(Icons.clear),

                        onPressed: () {

                          searchController.clear();

                          readData();

                        },

                      )

                    : null,

                border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(10),

                ),

                filled: true,

                fillColor: Colors.grey.shade100,

              ),

            ),

            const SizedBox(height: 10),

            // عرض الملاحظات

            Expanded(

              child: isLoading

                  ? const Center(child: CircularProgressIndicator())

                  : loadError != null

                      ? Center(child: Text('تعذر التحميل: $loadError'))

                      : notes.isEmpty

                          ? const Center(

                              child: Text(

                                "لا توجد ملاحظات مطابقة للبحث 🔍",

                                style: TextStyle(fontSize: 16, color: Colors.grey),

                              ),

                            )

                          : ListView.builder(

                              itemCount: notes.length,

                              itemBuilder: (context, i) {

                                final noteItem = notes[i];

                                final colorString = noteItem['color']?.toString();

                                

                                return Card(

                                  elevation: 3,

                                  margin: const EdgeInsets.symmetric(vertical: 6),

                                  color: _getNoteColor(colorString),

                                  shape: RoundedRectangleBorder(

                                    borderRadius: BorderRadius.circular(12),

                                  ),

                                  child: ListTile(

                                    title: Text(

                                      "${noteItem['title']}",

                                      style: const TextStyle(

                                        fontWeight: FontWeight.bold,

                                      ),

                                    ),

                                    subtitle: Text("${noteItem['note']}"),

                                    trailing: Row(

                                      mainAxisSize: MainAxisSize.min,

                                      children: [

                                        IconButton(

                                          onPressed: () => _showDeleteDialog(noteItem['id'] as int),

                                          icon: const Icon(Icons.delete, color: Colors.red),

                                        ),

                                        IconButton(

                                          onPressed: () async {

                                            await Navigator.of(context).push(

                                              MaterialPageRoute(

                                                builder: (context) => EditNotes(

                                                  note: noteItem['note'] as String,

                                                  title: noteItem['title'] as String,

                                                  color: colorString ?? '',

                                                  id: noteItem['id'] as int,

                                                ),

                                              ),

                                            );

                                            await readData(query: searchController.text);

                                          },

                                          icon: const Icon(Icons.edit, color: Colors.blue),

                                        ),

                                      ],

                                    ),

                                  ),

                                );

                              },

                            ),

            ),

          ],

        ),

      ),

    );

  }

}

