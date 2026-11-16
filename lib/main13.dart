


import 'package:flutter/material.dart';

// Animated in Flutter  الأنيميشن
/*
انواعه
أولاً الـ implicit animation 
وهو أبسط أنواع الأنيميشن ويمكن استخدام ويدجت مثل الـ AnimatedContainer 
وأيضاً ويدجت الـ AnimatedOpacity
AnimatedPositionedDirectional 
AnimatedPositioned
AnimateddSize
*/

/*
//⭐⭐
void main() {
  // تم إصلاح الخطأ هنا بإضافة home:
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // متغيرات الـ AnimatedContainer الافتراضية للقيم
  double w = 200;
  double h = 200;
  Color colorcontainer = Colors.red;
  double br = 50;

  // متغير الـ AnimatedOpacity (الشفافية) الافتراضي 
  double op = 1.0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Example"),
      ), 
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          InkWell(
            onTap: () {
              // عند الضغط تتغير كل القيم لتشغيل الأنيميشن
              setState(() {
                w = w == 200 ? 300 : 200;
                h = h == 200 ? 300 : 200;
                br = br == 50 ? 100 : 50;
              // عند التقر غيؤ من الافتراضي إلي شفافية ضفر يعني اختفاء العنصر ولو نقر مرة اخري رجع الشفافية الي 1.0, يعني أظهره 
                  op = op == 1.0 ? 0.0: 1.0;
                colorcontainer = colorcontainer == Colors.red ? Colors.green : Colors.red;
              });
                
            },
            child: Center(
              // تم دمج AnimatedOpacity مع AnimatedContainer لرؤية التأثيرين معاً
              child: AnimatedOpacity(
                curve: Curves.ease,
                duration: const Duration(seconds: 2),
                opacity: op,
                child: AnimatedContainer(
                  curve: Curves.bounceIn,    
                  duration: const Duration(seconds: 2),
                  width: w,
                  height: h,
                  decoration: BoxDecoration(
                    color: colorcontainer,
                    bclass _HomeState extends State<Home> {
  // متغيرات الـ AnimatedContainer الافتراضية للقيم
  double w = 200;
  double h = 200;
  Color colorcontainer = Colors.red;
  double br = 50;

  // متغير الـ AnimatedOpacity (الشفافية) الافتراضي 
  double op = 1.0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Example"),
      ), 
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          InkWell(
            onTap: () {
              // عند الضغط تتغير كل القيم لتشغيل الأنيميشن
              setState(() {
                w = w == 200 ? 300 : 200;
                h = h == 200 ? 300 : 200;
                br = br == 50 ? 100 : 50;
              // عند التقر غيؤ من الافتراضي إلي شفافية ضفر يعني اختفاء العنصر ولو نقر مرة اخري رجع الشفافية الي 1.0, يعني أظهره 
                  op = op == 1.0 ? 0.0: 1.0;
                colorcontainer = colorcontainer == Colors.red ? Colors.green : Colors.red;
              });
                
            },
            child: Center(
              // تم دمج AnimatedOpacity مع AnimatedContainer لرؤية التأثيرين معاً
              child: AnimatedOpacity(
                curve: Curves.ease,
                duration: const Duration(seconds: 2),
                opacity: op,
                child: AnimatedContainer(
                  curve: Curves.bounceIn,    
                  duration: const Duration(seconds: 2),
                  width: w,
                  height: h,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(br),                      
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/


//import 'package:flutter/material.dart';

// Animated in flutter  الانيميشن

/*

انواعه
اولا ال  implicit animation 
وهو ابسط انواع الانيميشن ويمكن استخدام ويدجت مثل ال animatedContainer 
ايضا ويدجت ال Opacity 
والاولي مثلا تستطيع التحكم في كونتينر معين طول وعرض ولون وسرعه وبادنج ومارجن الخ 
واستخدام curve للتحكم في سرعة الانيميشن curve: Curve.leanier 
or ease or easeIn وده يمكن استخدامه مع أي نوع ويدجت انيمي 

ويوجد أنيمي متحرك جاهز من خلال صور جاهزة للوضع أو بكجز علي موقع lotti مثلا. ومنها  الكود وهي ال implicit وغيرها 

*/
/*
void main(){
  runApp(const MaterialApp(home:Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

double w =300;
double h =500;
Color colorcontainer= Colors.red;
double br = 50;

double op =1.0;// قيمة الشفاغية الافتراضية


@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title:Text("anima"),
    ),//appBar 
      
    body: Container(
    child:ListView(
        padding: const EdgeInsets.all(16),
        children:[
          InkWell(
             onTap:(){
             w =400;
             h = 600;
             br = 100;      
             
             op=0.5;// عند النقر خلي ااشفافية بهذا القدر
             
             colorcontainer=Colors.green;         
             setState (() {});    
             },//onTap
             
             child:Center(
               /*
               child: AnimatedContainer(
                 curve:Curves.bounceIn,// linear,ease    
                 duration: Duration (seconds:4),
                 width:w,
                 height:h,
                              
                     decoration:BoxDecoration (
                       color:colorcontainer,
                      borderRadius: BorderRadius.circular (br),                      
               ),//decor
             ),//anim
             */
             // الشفافية Opacity
             child:AnimatedOpacity(
               curve: Curves.ease,
               duration: Duration (seconds:2),
               opacity:op,
               child:Container(
                 height:200,
                 width:200,
                 color:Colors.red,
                
               )
             ),
             ),//center
             ),//Ink
        ],
      ),//list
   )//c on
  );//scaf
  
}

}

*/
/*
import 'package:flutter/material.dart';


void main() {
  // تم إضافة home: هنا
  runApp(const MaterialApp(home: Home())); 
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double w = 300;
  double h = 500;
  Color colorcontainer = Colors.red;
  double br = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("anima"),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            InkWell(
              onTap: () {
                w = 400;
                h = 600;
                br = 100;
                colorcontainer = Colors.green;
                setState(() {});
              },
              child: Center(
                // تعديل الـ AnimatedContainer
                child: AnimatedContainer(
                  duration: const Duration(seconds: 4), // مكانها الصحيح خارج الـ decoration
                  width: w,                            // مكانها الصحيح خارج الـ decoration
                  height: h,                           // مكانها الصحيح خارج الـ decoration
                  curve: Curves.bounceIn,              // تعديل السبلنج الصحيح bounceIn
                  decoration: BoxDecoration(
                    color: colorcontainer,             // يمكنك تفعيل اللون هنا وسيتحرك بسلاسة
                    borderRadius: BorderRadius.circular(br),
                  ),
                ),
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
//AnimatedPositione && AnimatedPositionedDirectional 

void main() {
  // تم إصلاح الخطأ هنا بإضافة home:

  runApp(const MaterialApp(home: MyAnimation()));
}

class MyAnimation extends StatefulWidget {
@override
const MyAnimation({super.key});

State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation>{
// متغير بقيمة افتراضية صفر جهة اليسار يعني العنصر ٦ اليسار حاليا 

double myLeft = 0.0;
double mTop=0.0;
@override
Widget build(BuildContext context) {
    return Scaffold(
    body: GestureDetector(
        onTap: () {
        setState(() {
        myLeft = 50.0;// حركه من ناحية اليسار عند عمل tap بدرجة ٢٠٠ 
        mTop = 300.0;// تحرك بعيد عن الاعلي بمقدار 
        });
        },
        
    child: Stack(
        children: [      
        Container(height: 600, color: Colors.blue),
            /*
        AnimatedPositioned(
        duration: Duration(seconds: 2),
        left: myLeft,
        top: mTop, // يمكن ربطها أيضاً بمتغير للتحريك العمودي
       // كونتينر داخله اللي بيتحرك
        child: Container(
        height: 200,
        width: 200,
        color: Colors.green,
        ),
        ),
           */ 
            
    //AnimatedPositionedDirectional   
    
           AnimatedPositionedDirectional (
        duration: Duration(seconds: 2),
        start: myLeft,
                  
                // كونتينر داخله اللي بيتحرك
        child: Container(
        height: 200,
        width: 200,
        color: Colors.green,
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
//##########

`AnimatedPhysicalModel` و `AnimatedPadding`.

1. AnimatedPhysicalModel

تُستخدم هذه الويدجت لإضافة تأثيرات بصرية مثل الظلال (Elevation) وتغيير اللون بشكل انسيابي. وتغيير الشكل من مربع لدائرة أو مستطيل الخ

النقاط الرئيسية:

يجب تعريف المتغيرات المراد تغييرها (مثل `elevation` أو `color`) وتغيير قيمتها داخل `setState` لتشغيل الأنيميشن.

ملحوظة 

خاصية `shape` في `AnimatedPhysicalModel` لا تدعم الأنيميشن، لذا سيتغير الشكل فوراً دون حركة. للالتفاف على ذلك، يمكن استخدام `AnimatedContainer` مع `borderRadius`.

خاصية `animateColor` و `animateShadowColor` تسمح لك بتحديد ما إذا كنت تريد تغيير اللون أو الظل ضمن الأنيميشن أم لا.

//##########

2. AnimatedPadding 

تُستخدم لتغيير المسافات (Padding) حول عنصر ما بشكل انسيابي.

النقاط الرئيسية:

تعمل بنفس مبدأ `AnimatedPhysicalModel`؛ عند تغيير قيمة الـ `padding` داخل `setState`، ستقوم الويدجت بتحريك المسافة تلقائياً خلال المدة المحددة (`duration`).

يمكنك استخدام `curve` للتحكم في نمط حركة الأنيميشن (مثل `Curves.easeIn`).

*/


/*
void main(){

  runApp(const MaterialApp(home:AnimationScreen()));

}

class AnimationScreen extends StatefulWidget {

const AnimationScreen({super.key});

@override
State<AnimationScreen> createState() => _AnimationScreenState();

}

class _AnimationScreenState extends State<AnimationScreen>{

// متغيرات AnimatedPhysicalModel

double myElevation = 0.0;
Color myColor = Colors.red;
BoxShape myShape = BoxShape.circle;
// متغيرات AnimatedPadding
double myPadding = 10.0;

@override

Widget build(BuildContext context) {
return Scaffold(
body: Column(

    mainAxisAlignment: MainAxisAlignment.center,

    children: [

    // مثال AnimatedPhysicalModel

        AnimatedPhysicalModel(
        duration: Duration(seconds: 1),
        elevation: myElevation,
        color: myColor,
        shadowColor: Colors.black,
        shape: myShape,
        child: Container(height: 200, width: 200),

        ),

          // مثال AnimatedPadding
          
          AnimatedPadding(
            padding: EdgeInsets.all(myPadding),
            duration: Duration(seconds: 1),
            curve: Curves.easeIn,
            child: Container(color: Colors.green, height: 100, width: 100),
          ),
      
          ElevatedButton(
            onPressed: () {
              setState(() {
                myElevation = myElevation == 0 ? 20 : 0;
                myColor = myColor == Colors.red ? Colors.green : Colors.red;
                myPadding = myPadding == 10 ? 200 : 10;
              });
            },

            child: Text("Start Animation"),
          ),
        ],
  ),
);
}
}
*/
//###################


/*
//TweenAnimationBuilder👇

void main(){

  runApp(const MaterialApp(home:TweenAnimationBuilderScreen()));

}

class TweenAnimationBuilderScreen extends StatefulWidget {

const TweenAnimationBuilderScreen({super.key});

@override
State<TweenAnimationBuilderScreen> createState() => _TweenAnimationBuilderScreenState();

}

class _TweenAnimationBuilderScreenState extends State<TweenAnimationBuilderScreen>{
       
@override
Widget build(BuildContext context) {
    return Scaffold(
    body:  Container (
        child: TweenAnimationBuilder (
        duration: Duration(seconds: 5),
        tween :Tween(begin:30.0, end:300.0),
        builder:(context, value, child){
            return Container(
            height:value,//قيمتها begin
            width:value,// قيمتها end
            color:Colors.green,          
                 // لووعايز النص يفضل زي ماهو مايتاثرش باحركة او التكبيرلاتضع له style                   
                child:Text("TweenAnimationBuilder",
                 style: TextStyle(
                  color: Colors.white,
                  fontWeight: 
                  FontWeight.bold,
                  fontSize: value /6,
                ), ),
                
            );
        },
        )
    ),
    );
}

}

*/



/*
// Transform ##########

void main() {
  runApp(const MaterialApp(home: HomeScreen()));
}
class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});

@override
State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
 Widget build(BuildContext context) {
    return Scaffold (
     appBar: AppBar(
     title:Text("transform"),),
     body: Container (
       child: Column (
        children:[
        TweenAnimationBuilder (
        tween:Tween(begin:0.0, end :2 * 2.14 ) ,
        duration: Duration (seconds:4),
        builder :(context, value, child){
       // rotate,scale, translate 
            return Transform.scale (
       // angle: value,//rotate 
   //offset:Offset(value,value),//tras
            scale:value,//Scale
            origin:Offset(0,0),//Scale
                
        child : Center (
            child: Container (
                alignment: Alignment.center,
                child:Text("Container"),
                height:200,
                width:300,
                color:Colors.yellow ,
            ),//cont
        ),//centre 
        );// transform 
        },//builder 
        ),//TweenAnimationBuilder
        ],//children 
    ),//column 
),// cont
);//scaffold 
    }
    }

*/





//#################################
//Explicit Animation 
/*
void main() {
  runApp(const MaterialApp(home: HomeScreen()));
}

   
class HomeScreen  extends StatefulWidget {
const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{         


late AnimationController controller; // المدة

    // AlignmentGeometryمم نوع 
late Animation<AlignmentGeometry> alignmentcontroller ; // التحكم في المحاذاة

late Animation<double> rotatecontroller ;// التحكم في الدوران


@override
void initState (){
    super.initState();
    
// المتحكم في المدة 
controller= AnimationController (vsync:this, 
duration: Duration (seconds:4))..repeat(reverse:true);// مدة في وتكرار وعكس الحركة مع حركة انيمي عند الرجوع

// المتحكم في المحاذاة  توين من نوع انيميشن جيوميتري يبدأ من منتصف اليسار وينتهي إلي منتصف اليمين مع تمرير المتحكم له لضبط المدة وهو ال controller 

alignmentcontroller= Tween<AlignmentGeometry> (
begin:Alignment.centerLeft ,
 end : Alignment.centerRight,
).animate(controller);

// الدوران
rotatecontroller = Tween<double>(
begin: 0 , end : 2 ,
). animate(controller);
}


@override
  void dispose() {
    // هام جداً: إيقاف المحرك وحذفه من الذاكرة لمنع تسريب الموارد (Memory Leak)
    controller.dispose();    
    super.dispose();
  }
  


Widget build(BuildContext context) {
    return Scaffold (
     appBar: AppBar(
     title:Text("explicit animation ")),
     
     body: Container (
     child :Column (
     mainAxisAlignment : MainAxisAlignment.center,
     crossAxisAlignment :CrossAxisAlignment.center,
     
         children:[
         // ويدجت جاهز للمحاذاة
         AlignTransition(
            alignment :alignmentcontroller ,
            // ويدجت جاهز للدوران
            child: RotationTransition(
            turns : rotatecontroller,
            child: Container (
                width:100,
                height:100,
                color:Colors.green,
            ),
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
void main() {
  runApp(const MaterialApp(home: AnimatedBuilderDemoScreen()));
}

class AnimatedBuilderDemoScreen extends StatefulWidget {
  const AnimatedBuilderDemoScreen({super.key});

  @override
  State<AnimatedBuilderDemoScreen> createState() => _AnimatedBuilderDemoScreenState();
}

class _AnimatedBuilderDemoScreenState extends State<AnimatedBuilderDemoScreen>
    with SingleTickerProviderStateMixin {
  
  // 1. تعريف المتحكم والمحول (AnimationController & Tween)
  late AnimationController _controller;
    // متغير من double 
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    //  تهيئة المتحكم بمدة زمنية ثانيتين
    _controller = AnimationController(
      vsync: this,// الاشاره الي هذه الشاشة الحالية المفتوحه من قبل المستخدم 
      duration: const Duration(seconds: 2),
    );

    // ربط المحرك بـ Tween لتغيير قيم الحجم (مثلاً من 100إلى 250) أو الدوران
    _animation = Tween<double>(begin: 100.0, end: 250.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    // التخلص من المحرك لمنع تسريب الذاكرة
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تجربة AnimatedBuilder الاحترافية'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      // استخدام AnimatedBuilder للتحكم بالكونتينر
            AnimatedBuilder(
              animation: _controller,
              
              // 🌟 ميزة الأداء الخارقة: هذا النص يُبنى مرة واحدة فقط ولا يتكرر بناءه مع كل إطار
              child: const Text(
                'Flutter Animation',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
                
                
                
              // Buikderبياخد context, child
              builder: (context, staticChild) {
               // ال cont اللي بنتحكم فيه
                return Container(
                  width: _animation.value,  //  beginيتغير العرض بناءً على قيمة الأنيميشن
                 height: _animation.value, // end يتغير الطول بناءً على قيمة الأنيميشن
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(_animation.value / 4), // تغيير حواف الكونتينر تدريجياً
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.4),
                        blurRadius: _animation.value / 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    // هنا قمنا باستعمال الـ child الثابت الذي عرفناه بالأعلى لتحسين الأداء
                    child: staticChild,
                  ),
                );
              },
            ),
            
            const SizedBox(height: 50),

              
              
              
            // أزرار التحكم الكاملة بالحركة (Animation Controls)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _controller.forward(),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Forward'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _controller.reverse(),
                  icon: const Icon(Icons.replay),
                  label: const Text('Reverse'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _controller.stop(),
                  icon: const Icon(Icons.stop),
                  label: const Text('Stop'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _controller.repeat(reverse: true),
                  icon: const Icon(Icons.loop),
                  label: const Text('Repeat'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _controller.reset(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/


//###########App⭐⭐⭐#############

// شلشة ترحيبية بحركة انيميشن قبل الدخول الشاشة الرئيسية 
/*
سنقوم ببناء شاشة ترحيب متكاملة ومستقلة (WelcomeScreen) تجمع بين عدة تأثيرات أنيميشن صريحة (Explicit Animations):
 1. **تكبير الأيقونة والشعار (ScaleTransition)**: لتبدو وكأنها تنبض وتكبر من المنتصف.
 2. **الشفافية والظهور (FadeTransition)**: لتظهر العناصر تدريجياً بشكل ناعم.
 3. **الانتقال التلقائي**: بعد انتهاء الأنيميشن، سنقوم بنقلك بسلاسة إلى شاشة التطبيق الرئيسية (HomeScreen).
### كود شاشة الترحيب (Welcome Screen) المتكامل:
*/


import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skills Tracker Animation',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const WelcomeScreen(),
    );
  }
}

// ==================== 1. شاشة الترحيب (Welcome Screen) ====================
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;// التحكم في المدة 
    // التكبير
  late Animation<double> _scaleAnimation;
  // الشفافية او الظل
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 1. تعريف المتحكم بمدة زمنية ثانيتين
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds:5),
    );

    // 2. تحريك الحجم (من صغير جداً 0.0 إلى الحجم الطبيعي 1.0)
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut, // تعطي حركة مرنة تشبه النابض (Spring)
    );

    // 3. تحريك الشفافية (من مخفي تماماً 0.0 إلى ظاهر 1.0)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn), // تبدأ وتكتمل في أول 60% من الوقت
      ),
    );

    // تشغيل الأنيميشن فور فتح الشاشة
    _controller.forward();

    // 4. الانتقال التلقائي للشاشة الرئيسية بعد انتهاء الأنيميشن بفتحة صغيرة
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // يمكنك الانتظار قليلاً ثم الانتقال
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade800,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // أيقونة التطبيق بتصميم جذاب
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.psychology, // رمز يعبر عن المهارات والتفكير
                    size: 80,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 24),
                // عنوان التطبيق
                const Text(
                  'Skills Tracker',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'تتبع مهاراتك واحترافتك بانسيابية',
                  style: TextStyle(
                    color: Colors.teal.shade100,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== 2. الشاشة الرئيسية (Home Screen) ====================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الشاشة الرئيسية - Skills Tracker'),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text(
          'مرحباً بك في تطبيقك الرائع!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}


/*
 1. **CurvedAnimation مع Curves.elasticOut**: أعطت الشعار حركة "نابض مرن" (Elastic) عند ظهوره، وهي حركة بصرية ممتازة تمنح التطبيق شعوراً بالحيوية والنشاط.
 2. **Interval**: جعلتنا نتحكم في توقيت ظهور الشفافية بالتوازي مع حركة التكبير بدقة متناهية.
 3. **Navigator.pushReplacement**: تضمن أن المستخدم بعد أن ينتقل للشاشة الرئيسية، لا يمكنه العودة لشاشة الترحيب عند الضغط على زر الرجوع في الهاتف.
*/


