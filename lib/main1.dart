
/*

//StatelessWidget: يُستخدم في الصفحات التي لا تحتوي على تفاعل أو تغييرات في واجهة المستخدم، أي أنها صفحات ثابتة لا تحتاج لتحديث بياناتها أمام عين المستخدم (0:49 - 0:54).

//StatefulWidget: يُستخدم عندما تكون الصفحة تفاعلية، أي عندما تحتاج واجهة المستخدم إلى التغير أو التحديث بناءً على تفاعل المستخدم (مثل الضغط على أزرار لزيادة عداد أو تغيير شكل أيقونة). يتطلب هذا النوع استخدام دالة setState لإخبار التطبيق بضرورة إعادة بناء الواجهة لعرض التحديثات الجديدة (0:40

 

*/


import 'package:flutter/material.dart';

void main () {
    runApp(MyApp());
 }

class MyApp extends StatefulWidget {
    const MyApp({super.key});
 // انشاء حالة لكلاس هعرفة تحته وعمل اوڤررايد علي دالة ال State  وهو كلاس private _M6AppStateالمدمجة لتنشي حالة جديدة للكلاس الاتي
    State<MyApp> createState()=> _MyAppState();
}

//  ويأخذ من ويدجت الحالة عشان عند التغيير لعي شي فيه تفاعلي هذه الدالة تغيره او تعيد بناؤه وتحثه بالقيم الجديدة تعريفه
class  _MyAppState extends State<MyApp> {
 int i = 0 ; // المتغير الذي نريد تحديثه
   
 // دالة البناء إجبارية مع الكلاس للزم تعملها هي التي تبني الكلاس او العناصر وبعمل أوفر رايد علبها بالبيانات الجديدة 
 @override
 Widget build(BuildContext context){
      return Scaffold(
         body:Center(
             child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:[
                  IconButton (
                    onPressed : () {
                     setState( () {
                     i++;
                     });//setState
                    },                   
            icon:const Icon(Icons.add),                      ), //IconButton       
                     Text("$i"),
                   // نقصان  
                   IconButton (
                    onPressed : () {
                     setState( () {
                     i--;
                     });//setState
                     },                   
            icon:const Icon(Icons.remove),
                     ), //IconButton       
            ],//children                 
          ),//Row
      ),// body Center
   );// Scaffold 
      
 } // build 
}





