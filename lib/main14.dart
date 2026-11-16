

// لعبة تعيير الاشكال 

// إضافة تأثير صوتي للنقر 

/*

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; 
/*
// 1. استيراد حزمة الصوت
// ووضعها في ملف ال supspace.yml في ال dependences
audioplayers: ^6.0.0
*/

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShapeShifter(),
    ));

class ShapeShifter extends StatefulWidget {
  const ShapeShifter({super.key});

  @override
  State<ShapeShifter> createState() => _ShapeShifterState();
}

class _ShapeShifterState extends State<ShapeShifter> {
  final _random = Random();
  
  // 2. إنشاء مشغل الصوت (AudioPlayer)
  final AudioPlayer _audioPlayer = AudioPlayer();

  double _size = 120;
  double _radius = 16;
  Color _color = Colors.blue;

  // دالة اللخبطة وتشغيل الصوت
  Future<void> _shuffle() async {
    // 3. تشغيل التأثير الصوتي فور النقر
    try {
    
    await _audioPlayer.play(AssetSource('Assets/extracted_audio.mp3'));// من مجلد محلي 
    /*
      await _audioPlayer.play(UrlSource('https://www.soundjay.com/buttons/sounds/button-     
      3.mp3'));//  مباشرة من الانترنت 
   */
    
    }catch (e) {
      print("خطأ في تشغيل الصوت: $e");
    }

    setState(() {
      _size = 80 + _random.nextDouble() * 160;
      _radius = _random.nextDouble() * _size / 2;
      _color = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
  }

  @override
  void dispose() {
    // 4. التخلص من المشغل لمنع تسريب الموارد
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tap the shape with Sound!')),
      body: Center(
        child: GestureDetector(
          onTap: _shuffle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutBack,
            width: _size,
            height: _size,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(_radius),
            ),
          ),
        ),
      ),
    );
  }
}
*/



import 'package:flutter/material.dart';

void main () {
    return runApp( const MaterialApp(
        debugShowCheckedModeBanner: false,
            home: MyApp() ,               
    ));
   }

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _ImageCarouselState();

}

class _ImageCarouselState extends State<MyApp> {

  final _pageController = PageController();

  var _currentPage = 0;

  @override

  Widget build(BuildContext context) {

    return 
        Scaffold(

      appBar: AppBar(title: const Text('Gallery')),

      body: Column(

        children: [

          Expanded(

            child: PageView.builder(

              controller: _pageController,

              onPageChanged: (i) => setState(() => _currentPage = i),

              itemCount: 10,

              itemBuilder: (context, i) {

                return Container(

                  margin: const EdgeInsets.all(16),

                  decoration: BoxDecoration(

                    color: Colors.primaries[i].withValues(alpha: 0.5),

                    borderRadius: BorderRadius.circular(16),

                  ),

                  child: Icon(

                    Icons.image,

                    size: 64,

                    color: Colors.white.withValues(alpha: 0.8),

                  ),

                );

              },

            ),

          ),

          Padding(

            padding: const EdgeInsets.all(16),

            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: List.generate(5, (i) => Container(

                margin: const EdgeInsets.symmetric(horizontal: 4),

                width: _currentPage == i ? 24 : 8,

                height: 8,

                decoration: BoxDecoration(

                  color: _currentPage == i

                      ? Theme.of(context).colorScheme.primary

                      : Colors.grey[400],

                  borderRadius: BorderRadius.circular(4),

                ),

              )),

            ),

          ),

        ],

      ),

    );

  }

}


/*
class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Subject',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.attach_file),
              const SizedBox(width: 8),
              Text(
                'Attachment (placeholder)',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {},
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
*/