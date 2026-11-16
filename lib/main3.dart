


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
      home: InteractiveHomeScreen(),
    );
  }
}

// تحويل الواجهة إلى StatefulWidget للسماح بالتفاعل والتغيير
class InteractiveHomeScreen extends StatefulWidget {
  const InteractiveHomeScreen({super.key});

  @override
  State<InteractiveHomeScreen> createState() => _InteractiveHomeScreenState();
}

class _InteractiveHomeScreenState extends State<InteractiveHomeScreen> {
  // 1. المتغيرات التي تمثل "حالة الواجهة" (State)
  int _counter = 0;
  bool _isLightOn = false;

  // 2. دالة زيادة العداد
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // 3. دالة تبديل حالة المصباح
  void _toggleLight() {
    setState(() {
    // حولها من فولص إلي true !يعني ليست null أو فولص
      _isLightOn = !_isLightOn;
       
    });
    
  }

    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isLightOn ? Colors.yellow[50] : Colors.grey[900],
      appBar: AppBar(
        title: const Text('التطبيق التفاعلي الأول'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة تتغير حسب الحالة
            Icon(
              Icons.lightbulb,
              size: 100,
              color: _isLightOn ? Colors.amber : Colors.grey,
            ),
            const SizedBox(height: 20),
            
            // نص يتغير حسب اللون والحالة
            Text(
              _isLightOn ? 'الإضاءة تعمل' : 'الإضاءة مطفأة',
              style: TextStyle(
                fontSize: 22,
            // false => black  والا white 
                color: _isLightOn ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            // زر تبديل الإضاءة
            ElevatedButton(
            // دالة. التبديل
              onPressed: _toggleLight,
              child: Text(_isLightOn ? 'إطفاء' : 'تشغيل'),
            ),
            
            const Divider(height: 50, indent: 40, endIndent: 40),
            
            // عرض العداد
            Text(
              'عدد الضغطات: $_counter',
              style: TextStyle(
                fontSize: 20,
                color: _isLightOn ? Colors.black87 : Colors.white70,
              ),
            ),
            const SizedBox(height: 15),
            
            // زر زيادة العداد
            FloatingActionButton(
              onPressed: _incrementCounter,
              backgroundColor: Colors.teal,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}


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

      home: UserInputScreen(),

    );

  }

}

class UserInputScreen extends StatefulWidget {

  const UserInputScreen({super.key});

  @override

  State<UserInputScreen> createState() => _UserInputScreenState();

}

class _UserInputScreenState extends State<UserInputScreen> {

  // 1. إنشاء الـ Controller للتحكم في حقل النص

  final TextEditingController _nameController = TextEditingController();

  // قائمة لتخزين الأسماء التي يدخلها المستخدم

  final List<String> _namesList = [];

  // دالة إضافة الاسم إلى القائمة

  void _addName() {

    String enteredText = _nameController.text.trim();

    if (enteredText.isNotEmpty) {

      setState(() {

        _namesList.add(enteredText); // إضافة الاسم للقائمة

      });

      _nameController.clear(); // مسح النص من الحقل بعد الإضافة

    } else {

      // إظهار رسالة تنبيه إذا كان الحقل فارغاً

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text('يرجى كتابة اسم أولاً!'),

          duration: Duration(seconds: 2),

        ),

      );

    }

  }

  // التخلص من الـ Controller عند إغلاق الشاشة للحفاظ على الذاكرة

  @override

  void dispose() {

    _nameController.dispose();

    super.dispose();

  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('مدخلات المستخدم'),

        backgroundColor: Colors.teal,

        centerTitle: true,

      ),

      body: Padding(

        padding: const EdgeInsets.all(20.0),

        child: Column(

          children: [

            // حقل إدخال النص

            TextField(

              controller: _nameController,

              decoration: InputDecoration(

                labelText: 'اسم المستخدم',

                hintText: 'أدخل اسمك هنا...',

                prefixIcon: const Icon(Icons.person),

                suffixIcon: IconButton(

                  icon: const Icon(Icons.clear),

                  onPressed: () => _nameController.clear(),

                ),

                border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(12),

                ),

              ),

            ),

            const SizedBox(height: 15),

            // زر الإضافة

            SizedBox(

              width: double.infinity, // ليأخذ الزر عرض الشاشة المتاح

              height: 48,

              child: ElevatedButton.icon(

                onPressed: _addName,

                icon: const Icon(Icons.add),

                label: const Text('إضافة إلى القائمة', style: TextStyle(fontSize: 16)),

                style: ElevatedButton.styleFrom(

                  backgroundColor: Colors.teal,

                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(12),

                  ),

                ),

              ),

            ),

            const SizedBox(height: 25),

            const Align(

              alignment: Alignment.centerRight,

              child: Text(

                'الأسماء المضافة:',

                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

              ),

            ),

            const SizedBox(height: 10),

            // عرض الأسماء المضافة داخل القائمة

            Expanded(

              child: _namesList.isEmpty

                  ? const Center(

                      child: Text(

                        'لا يوجد أسماء مضافة بعد',

                        style: TextStyle(color: Colors.grey, fontSize: 16),

                      ),

                    )

                  : ListView.builder(

                      itemCount: _namesList.length,

                      itemBuilder: (context, index) {

                        return Card(

                          elevation: 2,

                          margin: const EdgeInsets.symmetric(vertical: 5),

                          child: ListTile(

                            leading: CircleAvatar(

                              backgroundColor: Colors.teal,

                              child: Text(

                                '${index + 1}',

                                style: const TextStyle(color: Colors.white),

                              ),

                            ),

                            title: Text(_namesList[index]),

                            trailing: IconButton(

                              icon: const Icon(Icons.delete, color: Colors.red),

                              onPressed: () {

                                setState(() {

                                  _namesList.removeAt(index);

                                });

                              },

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