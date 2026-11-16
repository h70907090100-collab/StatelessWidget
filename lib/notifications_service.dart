

/*
ملف ادارة الاشعارات 
*/

import 'package:firebase_messaging/firebase_messaging.dart';//لابد من تنزيل الحزمة في ملف الاعتمادات 
import 'package:flutter/material.dart';
import 'notify.dart';

    
/*    
class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // 1. طلب الصلاحيات بشكل آمن لا يوقف التطبيق لو تم حظره
  Future<void> requestPermission() async {
    try {
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print("🔔 User granted notification permission");
      } else {
        print("🔔 User declined or restricted permission");
      }
    } catch (e) {
      print("⚠️ Permission request error (Ignored): $e");
    }
  }

  // 2. جلب التوكن بشكل آمن
  Future<String?> getDeviceToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print("====== DEVICE FCM TOKEN ======");
      print(token);
      print("==============================");
      return token;
    } catch (e) {
      print("⚠️ Error getting FCM token (Ignored): $e");
      return null;
    }
  }
    
  // 3. الاستماع للإشعارات عندما يكون التطبيق مفتوحاً في الواجهة الأمامية (Foreground)
  void initForegroundMessageListener(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Foreground Message Received: ${message.notification?.title}");
      
      if (message.notification != null) {
        // يمكنك إظهار تنبيه بصري للمستخدم داخل التطبيق
        _showNotificationDialog(
          context,
          message.notification!.title ?? 'إشعار جديد',
          message.notification!.body ?? '',
        );
      }
    });
  }
          
      
  // 4. الاشتراك في موضوع عام (Topics) للإشعارات الجماعية
  Future<void> subscribeToTopic(String topicName) async {
    await _firebaseMessaging.subscribeToTopic(topicName);
    print("📢 Subscribed to topic: $topicName");
  }
  
  // دالة مساعدة لعرض تنبيه داخل التطبيق
  void _showNotificationDialog(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}

*/




/*
⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐👇👇

الملف النهائي الاشعارات

ممتاز جداً! دعنا نجعل ملف notification_service.dart **كاملاً، احترافياً، ومتكاملاً بنسبة 100%** ليغطي جميع حالات الإشعارات (Foreground، Background، Terminated) مع حماية تكامل التطبيق ضد أي أخطاء في بيئات الويب أو الموبايل.

*/
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

// 🌟 1. معالج الخلفية والإغلاق التام (يجب أن يكون دالة مستقلة خارج الكلاس تماماً)

/*

هذا السطر (@pragma('vm:entry-point')) من الأسرار البرمجية المهمة جداً في لغة **Dart** و **Flutter**، وغالباً لا يراه المطورون إلا عند التعامل مع أشياء تعمل في "الخلفية" (Background) مثل الإشعارات، المهام المجدولة، أو العمليات التي تتم بمعزل عن واجهة المستخدم.

إليك معناه باختصار وببساطة شديدة:

### ما هو معناه؟

 * **pragma**: اختصار لـ *Pragmatic information*، وهي تعليمة خاصة تُعطى لمترجم الكود (Compiler) لتعطيه توجيهاً تقنياً خارج القواعد العادية.

 * **vm:entry-point**: تعني **"نقطة دخول للـ Virtual Machine (المحرك الافتراضي)"**.

### لماذا أضفناه تحديداً مع معالج الإشعارات في الخلفية (firebaseMessagingBackgroundHandler)؟

تطبيق Flutter العادي يبدأ دائماً من دالة main(). لكن عندما يُغلق التطبيق تماماً أو يصغر في الخلفية، ويصل إشعار فجأة، سيقوم نظام التشغيل (مثل أندرويد) باستدعاء دالة firebaseMessagingBackgroundHandler مباشرة.

المشكلة هنا أن **محرك Dart الافتراضي لا يعرف هذه الدالة لأنها لا تُستدعى من داخل التطبيق بشكل مباشر**، ولذلك قد يقوم مُترجم الكود (أثناء عملية ضغط وبناء التطبيق Release/Production) بحذف هذه الدالة تماماً ليوفّر مساحة، باعتبارها "دالة غير مستخدمة"!

هنا يأتي دور @pragma('vm:entry-point'):

فهي بمثابة **"تحذير صارم" للمترجم:**

> *"إياك أن تحذف هذه الدالة أو تعيد تسميتها أو تختصرها! حتى لو لم ترَ أحداً يستدعيها بداخل التطبيق، فهناك نظام خارجي (مثل نظام التشغيل أو Firebase) سيقوم بندائها بشكل مفاجئ في الخلفية، لذا اتركها في الذاكرة دائماً."*

> 

### باختصار شديد:

هي حماية برمجية تضمن ألا يقوم تطبيقك بحذف دالة استقبال الإشعارات في الخلفية عند بناء النسخة النهائية (Release) للتطبيق.

*/

@pragma('vm:entry-point')

// دالة استقبال اشعارات في الخلفية تاخد متغير من RemoteMessage

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print("🌙 Background Message Received: ${message.messageId}");

  print("Title: ${message.notification?.title}");

  print("Body: ${message.notification?.body}");

  // هنا يمكنك معالجة البيانات الواردة في الخلفية (مثل حفظها محلياً أو تحديث قاعدة البيانات)

}

  // 2. طلب الصلاحيات باستقبال الشعارات بشكل آمن لا يوقف التطبيق لو تم حظره  وذلك بوضع الكود في try catch

class NotificationService {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestPermission() async {

    try {

      NotificationSettings settings = await _firebaseMessaging.requestPermission(

        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {

        print("🔔 User granted notification permission");

      } else {

        print("🔔 User declined or restricted permission");

      }

    } catch (e) {

      print("⚠️ Permission request error (Ignored): $e");

    }

  }

//#####################

  // 3. جلب التوكن الخاص بالجهاز/المتصفح بشكل آمن لاستخدامه في ارسال اشعارات أو رسائل محدد لصاحب الجهاز او المتصفح 

  

  Future<String?> getDeviceToken() async {

    try {

      String? token = await _firebaseMessaging.getToken();

      print("====== DEVICE FCM TOKEN ======");

      print(token);

      print("==============================");

      return token;

    } catch (e) {

      print("⚠️ Error getting FCM token (Ignored): $e");

      return null;

    }

  }

//#####################

  // 4. الاستماع للإشعارات عندما يكون التطبيق مفتوحاً (Foreground) noMessage.listn(RemoteMessage message)

  void initForegroundMessageListener(BuildContext context) { FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Foreground Message Received: ${message.notification?.title}");

      if (message.notification != null) {
        _showNotificationDialog(
          context,
          message.notification!.title ?? 'إشعار جديد',
          message.notification!.body ?? '',

        );

      }

    });

  }

  // 5. التعامل مع الضغط على الإشعار وتوجيه المستخدم عندما يكون التطبيق في الخلفية (Background) أو مغلقاً (Terminated)

  void initNotificationClickListeners(BuildContext context) {

    // أ. التطبيق في الخلفية وتم الضغط على الإشعار onMessageOpendApp ايضا يقبل باىاميترز من نوع RemoteMessage 
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🚀 App opened from Background by notification!");
      _handleNavigation(context, message);
    });
    // ب. التطبيق كان مغلقاً تماماً وتم فتحه بواسطة الإشعار
 _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print("🎯 App opened from Terminated state by notification!");

        // نستخدم PostFrameCallback لضمان اكتمال بناء الشاشة قبل التوجيه
 WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleNavigation(context, message);

        });

      }

    });

  }

//#####################

  // 6. الاشتراك في قناة أو موضوع عام (Topics) ارسال رسائل لكل المستخدمين اللذين يشتركون في التطبيق أو الموضوع المحدد اللذي تحدده 

  

  Future<void> subscribeToTopic(String topicName) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topicName);

      print("📢 Subscribed to topic: $topicName");
    } catch (e) {
      print("⚠️ Error subscribing to topic: $e");

    }

  }

  // 7. إرسال إشعار موجه لتوكن معين (تجريبي من داخل التطبيق)  وممكن ترسل من لوحة تحكم firebaes وعدم استخدام هذه الدالة 

 

  

  /*👇👇

  سؤال ممتاز جداً وفي مَحَلّه!

البيانات الموجودة في هذا الجزء (title و bodyMessage و targetToken) يتم إرسالها إلى الدالة **كـ "مُعاملات" (Parameters)** عندما تقوم باستدعائها من أي مكان في تطبيقك.

دعنا نوضح كيف تعمل الدالة بالكامل وكيف يتم جلب هذه البيانات وتمريرها إليها:

### 1. كيف شكل الدالة في الأساس؟

لاحظ شكل تعريف الدالة في كلاس NotificationService، حيث تتطلب منك تمرير 4 أشياء أساسية:

```dart

Future<void> sendNotificationToToken(

  String targetToken,  // 1. توكن الجهاز المستهدف

  String title,        // 2. عنوان الإشعار

  String bodyMessage,  // 3. نص الإشعار

  String serverKey,    // 4. مفتاح سيرفر Firebase

) async {

  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  

  var headers = {

    'Content-Type': 'application/json',

    'Authorization': 'key=$serverKey',

  };

  // هنا يتم استخدام البيانات التي أرسلتها للدالة:

  var body = {

    "to": targetToken, 

    "notification": {

      "title": title,

      "body": bodyMessage,

    }

  };

  // بقية كود الـ http.post ...

}

```

### 2. إذن، من أين تأتي هذه البيانات عملياً؟

تؤخذ هذه البيانات بحسب السيناريو الذي تريد تنفيذه في التطبيق، وغالباً تأتي من مصدرين:

#### أ. الـ targetToken (توكن الجهاز):

 * **من أين يأتي؟** من الدالة التي قمنا ببرمجتها مسبقاً getDeviceToken() أو من **قاعدة بيانات Firestore**.

 * **كيف؟** عندما يسجل المستخدم دخوله، تحفظ أنت الـ Token الخاص به في قاعدة البيانات تحت حسابه. فلو أراد مستخدم إرسال تنبيه لمستخدم آخر، تبحث في قاعدة البيانات عن userId للمستخدم الثاني، وتأخذ الـ Token الخاص به وتمرره هنا.

 * *(أو لو أردت تجربة إرسال إشعار لنفسك، يمكنك نسخ التوكن الذي يظهر في الـ Console وتمريره كنص مباشر بين علامتي تنصيص).*

#### ب. الـ title و bodyMessage (العنوان والنص):

 * **من أين يأتيان؟** من واجهة المستخدم (UI) التي يصممها المستخدم أو المشرف.

 * **كيف؟** لو افترضنا أنك أنشأت شاشة لوحة تحكم للإدارة أو لإنشاء المهام، سيكون لديك حقول إدخال (TextField) يكتب فيها المشرف عنوان المهمة وتفاصيلها:

   ```dart

   // مثال داخل واجهة المستخدم (UI) عند الضغط على زر "إرسال إشعار":

   String token = "التوكن_الخاص_بالجهاز_المستهدف_هنا";

   String titleInput = "تذكير بمهام اليوم"; // مأخوذ من TextField مثلاً

   String bodyInput = "لا تنس إكمال مهارة البرمجة اليوم!"; // مأخوذ من TextField آخر

   String myServerKey = "مفتاح_السيرفر_الخاص بك_من_فايربيس";

   

   // استدعاء الدالة وتمرير البيانات:

   NotificationService().sendNotificationToToken(

     token, 

     titleInput, 

     bodyInput, 

     myServerKey,

   );

   

   ```

### خلاصة بسيطة:

الدالة sendNotificationToToken بمثابة **"آلية إرسال جاهزة"**. أنت <u>لا</u> تكتب البيانات داخلها ثابتة، بل تقوم باستدعائها وتمرير القيم (التوكن، العنوان، النص) إليها متى شئت ومن المكان الذي تختاره في تطبيقك!

  */

  Future<void> sendNotificationToToken(String targetToken, String title, String bodyMessage, String serverKey) async {

    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',//# يتم استخراجه من ال firebase لوحة التحكم 

    };
    var body = {
      "to": targetToken,
      "notification": {
        "title": title,
        "body": bodyMessage,
      }
    };
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        print("✅ Notification sent successfully to token!");

      } else {
        print("❌ Failed to send notification: ${response.body}");

      }
    } catch (e) {
      print("⚠️ Error sending notification: $e");
    }
  }

//#####################

  // دالة مساعدة لعرض تنبيه داخل التطبيق (Foreground)
  void _showNotificationDialog(BuildContext context, String title, String body) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  // دالة مساعدة لتوجيه المستخدم عند الضغط على الإشعار (Deep Linking / Navigation)  

  //#####################

  void _handleNavigation(BuildContext context, RemoteMessage message) {

    // يمكنك تخصيص التوجيه بناءً على البيانات المرسلة في الـ data payload
    print("Data payload: ${message.data}");
    // مثال توضيحي: الدالة التفاصيل 
     if (message.data['type'] == 'skill') {
        Navigator.push(context, MaterialPageRoute(builder: (_) => NotifyScreen()));
       }
  }

}
