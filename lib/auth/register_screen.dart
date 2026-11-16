
/*
codespace GitHub 
import "package:flutter/material.dart";
import "package:main.dart";
import "package:provider/provider.dart";
*/
    
//flatlab.io

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// استيراد الملف الرئيسي للوصول إلى MyModel
import 'package:statefulwidget/main.dart';
import'login_screen.dart';  

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // المتحكمات الجديدة والقديمة
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إنشاء حساب جديد'), centerTitle: true),
      body: SingleChildScrollView( // لجعل الشاشة قابلة للتمرير عند ظهور الحقول الجديدة لوحة المفاتيح
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_add, size: 80, color: Colors.teal),
              const SizedBox(height: 20),

               // حقل اسم المستخدم (Username)
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'اسم المستخدم',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) =>
                    val!.trim().isEmpty ? 'يرجى إدخال اسم المستخدم' : null,
              ),
              
              
              const SizedBox(height: 15),

              // حقل رقم الهاتف (Phone)
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) => val!.isEmpty ? 'يرجى إدخال رقم الهاتف' : null,
              ),
              const SizedBox(height: 15),

              // حقل البريد الإلكتروني
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) => val!.isEmpty ? 'يرجى إدخال البريد الإلكتروني' : null,
              ),
              const SizedBox(height: 15),

              // حقل كلمة المرور
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) => val!.length < 6
                    ? 'كلمة المرور يجب أن تكون 6 أحرف على الأقل'
                    : null,
              ),
              const SizedBox(height: 25),

              // زر إنشاء الحساب الأساسي
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),                                              
                    onPressed: _isLoading
    ? null
    : () async {
        if (_formKey.currentState!.validate()) {
          setState(() => _isLoading = true);
          
          bool success = await context.read<MyModel>().signUp(
            _emailController.text,
            _passwordController.text,
            context,
          );
          
          setState(() => _isLoading = false);

          // إذا نجحت العملية، نعرض الرسالة ونحول المستخدم لصفحة تسجيل الدخول
          if (success && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إنشاء الحساب بنجاح! يرجى تفقد بريدك الإلكتروني للتفعيل ثم تسجيل الدخول.'),
                backgroundColor: Colors.teal,
                duration: Duration(seconds: 4),
              ),
            );
            
            // التوجيه لصفحة تسجيل الدخول وإزالة صفحة التسجيل من الشاشات السابقة
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen() ),
            );
          }
        }
      },
                                           
                    
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'إنشاء الحساب',
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),

              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('أو', style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),

              // زر التسجيل بواسطة جوجل (Google Sign-In UI)
                
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    // رسالة توضيحية حالياً لتجربة الزر
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('ميزة تسجيل الدخول بواسطة جوجل ستُفعّل قريباً!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.g_mobiledata, size: 35, color: Colors.red),
                  label: const Text(
                    'المتابعة باستخدام جوجل',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
              
              
                
                      // زر التسجيل بواسطة جوجل (Google Sign-In UI)
                /*
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    // استدعاء دالة جوجل من الـ Provider
                    bool success = await context.read<MyModel>().signInWithGoogle(context);
                    
                    if (success && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم تسجيل الدخول بواسطة جوجل بنجاح!'),
                          backgroundColor: Colors.teal,
                        ),
                      );
                      
                      // الانتقال إلى الشاشة الرئيسية وإزالة صفحة الدخول من الذاكرة
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()), // استبدل بـ HomeScreen لديك
                      );
                    }
                  },
                  icon: const Icon(Icons.g_mobiledata, size: 35, color: Colors.red),
                  label: const Text(
                    'المتابعة باستخدام جوجل',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ),
                */
                
                
                
            ],
          ),
        ),
      ),
    );
  }
}
