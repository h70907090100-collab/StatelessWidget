
//OCR translator 
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:translator/translator.dart';

// تذكير: تأكد من وجود هذا السطر في android/app/src/main/AndroidManifest.xml
// <uses-permission android:name="android.permission.INTERNET" />

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Camera Translator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SmartCameraTranslator(),
    );
  }
}

class SmartCameraTranslator extends StatefulWidget {
  const SmartCameraTranslator({super.key});

  @override
  State<SmartCameraTranslator> createState() => _SmartCameraTranslatorState();
}

class _SmartCameraTranslatorState extends State<SmartCameraTranslator> {
  File? _selectedImage;
  String _extractedText = "";
  String _translatedText = "";
  String? _errorMessage;
  bool _isLoading = false;

  // #رقم الطلب الحالي: لتجاهل نتائج الطلبات القديمة عند تغيير اللغة بسرعة
  int _requestId = 0;

//# قائمة اللغات
  final Map<String, String> _supportedLanguages = {
    'العربية': 'ar',
    'English': 'en',
    'Français': 'fr',
    'Español': 'es',
    'Deutsch': 'de',
    'Türkçe': 'tr',
  };
  String _selectedLanguageCode = 'ar';//#الافتراضية
  

  final ImagePicker _imagePicker = ImagePicker();
  // #ملاحظة: Latin فقط. ML Kit لا يدعم الخط العربي. يعني تقرا الإنجليزي وغيره وتترجمه للعربي لكن لاتقرا العربي من الصور
  
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);
  final GoogleTranslator _googleTranslator = GoogleTranslator();

//# دالة معالجة الصور سواء الملتقطة من الكاميرا أو من المعرض
  Future<void> _processImage(ImageSource source) async {
    try {
      final XFile? pickedFile =
          await _imagePicker.pickImage(source: source, imageQuality: 85);
      if (pickedFile == null) return;
      if (!mounted) return;

      setState(() {
        _selectedImage = File(pickedFile.path);
        _isLoading = true;
        _extractedText = "";
        _translatedText = "";
        _errorMessage = null;
      });
//# بعد التقاط الصورة تمرر لنموذج المتعرف علي النصوص

      final inputImage = InputImage.fromFilePath(pickedFile.path);
      final RecognizedText recognizedText =
          await _textRecognizer.processImage(inputImage);
      if (!mounted) return;
//# قص الزوائد من النص 
      final String rawText = recognizedText.text.trim();

      if (rawText.isEmpty) {
        setState(() {
          _errorMessage = "لم يتم العثور على أي نص لاتيني داخل الصورة.";
          _isLoading = false;
        });
        return;
      }
//# بعد قص الزوائد تمريره للمتغير الخاص بالنستخرحات وتمريره الدالة الترجمة 
      setState(() => _extractedText = rawText);
      await _translateText(rawText);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = "حدث خطأ أثناء معالجة الصورة: $e";
        _isLoading = false;
      });
    }
  }
//###############
//# دالة الترجمة
  Future<void> _translateText(String text) async {
    if (text.isEmpty) return;
    //# زورد واحد علي متغير الidلبكون طلب اخر مختلف عن القديم
    final int currentId = ++_requestId;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
    //# متغير يخزن ترجمة النص بعد تمريؤه لنموذج جوجل لترجمتهللغة اللي ام اختيارها 
      final Translation translation = await _googleTranslator
          .translate(text, to: _selectedLanguageCode)
          .timeout(const Duration(seconds: 20));

      if (!mounted || currentId != _requestId) return;
      //# ولو اوكي خزن الترجمه في متغير _translatedText واوقف التحميل
      setState(() {
        _translatedText = translation.text;
        _isLoading = false;
      });
    } catch (e) {
    //#
      if (!mounted || currentId != _requestId) return;
      setState(() {
        _translatedText = "";
        _errorMessage = "حدث خطأ أثناء الترجمة، تأكد من الاتصال بالإنترنت.\n$e";
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabicTarget = _selectedLanguageCode == 'ar';

    return Scaffold(
        appBar: AppBar(
  backgroundColor: const Color(0xFF121212),
  elevation: 0,
  centerTitle: true,
  title: Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(30),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.auto_awesome, color: Colors.amber, size: 18),
        SizedBox(width: 8),
        Text(
          "Smart Translator",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    ),
  ),
),

        
        
        /*
      appBar: AppBar(
        title: const Text("المترجم الذكي - Smart Translator"),
        centerTitle: true,
        //backgroundColor:Colors.redAccent
      ),
      */
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              //# عند اختيار صورة طبق عليها هذا التنسيق 
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_selectedImage!, fit: BoxFit.cover),
                    )//#والا تظهر أيقونة الصورة يعني لسه مافيش اختبار أو التقاط
                  : const Center(
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
            ),
            
            const SizedBox(height: 16),
//#صف به زر التقاط صورة وزر اختيار من المعرض
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading
                        ? null
                        : () => _processImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("التقاط صورة"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading
                        ? null
                        : () => _processImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text("من المعرض"),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),

            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ترجمة إلى:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),//#قايمة اللغات
                    DropdownButton<String>(
                      value: _selectedLanguageCode,
                      icon: const Icon(Icons.arrow_drop_down),
                      
                      underline: const SizedBox(),
                      //#
                      items: _supportedLanguages.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.value,
                          child: Text(
                            entry.key,
                            style: const TextStyle(fontSize: 15),
                          ),
                        );
                      }).toList(),
                      
                      onChanged: (String? newLangCode) {
                        if (newLangCode != null &&
                            newLangCode != _selectedLanguageCode) {
                          setState(() => _selectedLanguageCode = newLangCode);
                          if (_extractedText.isNotEmpty) {
                            _translateText(_extractedText);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),

            if (_isLoading)
              const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text("جاري استخراج النص وترجمته..."),
                  ],
                ),
              ),
//#حالة  وجود أخطأ أظهر رسالة الخطأ ووقف التحميل 
            if (!_isLoading && _errorMessage != null) ...[
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red.shade900),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
//#, لو تم استخراج النص 
            if (!_isLoading && _extractedText.isNotEmpty) ...[
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "النص المستخرج من الصورة (Original Text):",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const Divider(),
                      
                      SelectableText(
                        _extractedText,
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
//# الترجمة أو النص المترجم
            if (!_isLoading && _translatedText.isNotEmpty) ...[
              Card(
                elevation: 2,
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "النص المترجم (Translated Text):",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Divider(),
                      
                      SizedBox(
                        width: double.infinity,
                        child: SelectableText(
                          _translatedText,
                          textDirection: isArabicTarget
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}



/*

خطوة مهمة قبل التشغيل

إذا كنت تستخدم DartPad أو تشغّل المشروع على متصفح Chrome، فلن يعمل هذا الكود لأن مكتبة التعرف على النصوص (google_mlkit_text_recognition) مخصصة لتطبيقات الهواتف فقط. يجب فتح المشروع في محرر مثل VS Code أو Android Studio وتحديد جهاز Android أو iOS في شريط التشغيل السفلي.
هل تشغّل الكود حالياً على DartPad / الويب أم داخل مشروع فلاتر حقيقي على VS Code / Android Studio
*/