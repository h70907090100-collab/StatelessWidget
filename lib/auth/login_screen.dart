
/*
import "package:flutter/material.dart";
import 'package:main.dart';

import 'package:provider/provider.dart';
import "../auth/register_screen.dart";

h20058771@yahoo.com
h212121

*/


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statefulwidget/main.dart';
import 'register_screen.dart';
  

// كلاسHomeScreen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //👇========== دالة ديالوج تظهر عند التقر نسيان كلمة المرور 
    
 void _showForgotPasswordDialog(BuildContext context) {
    final TextEditingController resetEmailController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('استعادة كلمة المرور'),
          content: TextField(
            controller: resetEmailController,
            decoration: const InputDecoration(
              labelText: 'أدخل بريدك الإلكتروني',
              prefixIcon: Icon(Icons.email),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
              onPressed: () async {
                if (resetEmailController.text.isNotEmpty) {
                  Navigator.pop(context); // إغلاق النافذة
               await context.read<MyModel>().resetPassword(
                        resetEmailController.text,
                        context,
                      );
                }
              },
              child: const Text('إرسال الرابط'),
            ),
          ],
        );
      },
    );
  }
   //👆========
    
    
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسجيل الدخول'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 80, color: Colors.teal),
              const SizedBox(height: 30),
              // حقل البريد الإلكتروني
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) =>
                    val!.isEmpty ? 'يرجى إدخال البريد الإلكتروني' : null,
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
              // زر تسجيل الدخول
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);
                            // استدعاء دالة تسجيل الدخول من المزود
                            bool success = await context.read<MyModel>().signIn(
                              _emailController.text,
                              _passwordController.text,
                              context,
                            );
                            setState(() => _isLoading = false);

                            if (success) {
                              // لو نجح الدخول، انتقل للصفحة الرئيسية تلقائياً
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            }
                          }
                        },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('دخول', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 15),
              
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
              ), // بجوجل                            
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
                
                //======
                
                   //  👇👇زر نسيت كلمة المرور

            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {               _showForgotPasswordDialog(context);
                },
                child: const Text('نسيت كلمة المرور؟', style: TextStyle(color: Colors.teal)),
              ),
            ),
                
            const SizedBox(height: 15),                   //=====     
                
                // زر الانتقال لصفحة إنشاء حساب
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text('ليس لديك حساب؟ سجل حساباً جديداً'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
