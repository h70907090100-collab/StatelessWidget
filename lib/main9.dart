

/*
Api علي موقع jsonplaceholder 

 2. **إدارة الأخطاء (try - catch)** لحماية التطبيق لو انقطع الإنترنت.
 3. **شريط البحث (Search)** لتصفية المستخدمين القادمين من الـ API لحظياً!
### الخطوات العملية لبناء هذا التطبيق المصغر:
#### 1. إضافة حزمة الاتصال بالإنترنت (http) في ملف pubspec.yaml:
تحت قسم dependencies أضف الحزمة:
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0  # أو أحدث إصدار

```
flutter clean
flutter  pub get

*/



import 'dart:convert'; // للتعامل مع صيغة الـ JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // استيراد حزمة الـ API


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق جلب بيانات الـ API',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const ApiUsersScreen(),
    );
  }
}

class ApiUsersScreen extends StatefulWidget {
  const ApiUsersScreen({super.key});

  @override
  State<ApiUsersScreen> createState() => _ApiUsersScreenState();
}

class _ApiUsersScreenState extends State<ApiUsersScreen> {

  // قائمة لتخزين المستخدمين القادمين من الـ API
  
  List<dynamic> _usersList = [];
  List<dynamic> _filteredUsers = [];
  
  bool _isLoading = true;
  String _errorMessage = '';
  final TextEditingController _searchController = TextEditingController();

//==================

  @override
  void initState() {
    super.initState();
    _fetchUsersFromApi(); // جلب البيانات فور فتح الشاشة👉
  }
  
//==================
  
// ايقاف العمليات بعد. اغلاق التطبيق
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

//==================
  // دالة جلب البيانات مع تطبيق (Try - Catch) لإدارة الأخطاء
  
  Future<void> _fetchUsersFromApi() async {
    const String apiUrl = 'https://jsonplaceholder.typicode.com/users';

    try {
      // المحاولة: إرسال طلب HTTP لجلب البيانات من الموقع
      
      final response = await http.get(Uri.parse(apiUrl));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        
        setState(() {
          _usersList = data;
          _filteredUsers = data; // في البداية القائمة المفلترة تطابق القاصلية
          _isLoading = false;    // انتهى التحميل
        });
      } else {
        throw Exception('فشل الخادم في الرد (رمز الخطأ: ${response.statusCode})');
      }
    } catch (e) {
      // التعامل مع الأخطاء (مثل انقطاع الإنترنت أو خطأ في الـ URL)
      
      setState(() {
        _errorMessage = 'حدث خطأ أثناء الاتصال: $e';
        _isLoading = false;
      });
    }
  }

//==================
  // دالة البحث والفلترة بين أسماء المستخدمين القادمين من الـ API سواء بحث بالاسم او الايميل مع تحويل كلمة البحث إلي احرف صغيره وارجاع النتيجة التي تحتوي علي نفس كلمة البحث query
  
  void _filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredUsers = _usersList;
      } else {
        _filteredUsers = _usersList.where((user) {
          final name = user['name'].toString().toLowerCase();
          final email = user['email'].toString().toLowerCase();
          return name.contains(query.toLowerCase()) || email.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

//==================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دليل المستخدمين (من الـ API)'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        actions: [
        
        // refresh تنشيط إعادة تحميل 
        
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
                _errorMessage = '';
              });
              _fetchUsersFromApi(); // إعادة محاولة الجلب عند الضغط
            },
          ),
        ],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // حقل البحث لتصفية البيانات القادمة من الإنترنت
            TextField(
              controller: _searchController,
              onChanged: _filterUsers,
              decoration: InputDecoration(
                hintText: 'ابحث عن اسم أو بريد المستخدم...',
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
              ),
            ),
            const SizedBox(height: 15),

            // عرض المحتوى بناءً على الحالة (تحميل، خطأ، أو نجاح وعرض البيانات)
            
            Expanded(
            // التحميل ورسائل الخطأ 
            
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.teal))
                  : _errorMessage.isNotEmpty
                      ? Center(
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        )
                        
                      : _filteredUsers.isEmpty
                          ? const Center(child: Text('لا توجد نتائج مطابقة للبحث'))
                          
                          : ListView.builder(
                              itemCount: _filteredUsers.length,
                              itemBuilder: (context, index) {
                                final user = _filteredUsers[index];
                                
                                return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  margin: const EdgeInsets.symmetric(vertical: 6),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.teal.withOpacity(0.2),
                                      child: Text(
                                        user['name'][0], // أول حرف من اسم المستخدم
                                        style: const TextStyle(
                                            color: Colors.teal,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    title: Text(
                                      user['name'],
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    
                                    subtitle: Text(user['email']),
                                    trailing: const Icon(Icons.arrow_forward_ios,
                                        size: 16, color: Colors.grey),
                                    onTap: () {
                                      // تفاعل عند الضغط على المستخدم
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'تم اختيار: ${user['name']} (مدينة: ${user['address']['city']})')),
                                      );
                                    },
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

