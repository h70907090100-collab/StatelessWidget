//##################
//######## 3. ملف التعامل مع قاعدة البيانات (`sqldb.dart`)

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

// # تستخدم عند ترقية التطبيق باضافة عمود أو جدول جديد 
  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("onUpgrade =====================================");
  }
  
//# استخدام ال Batch عند إضافة أكثر من جدول أو حتي من غير إضافة أكثر من جدول يفضل استخدامها 

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    
    batch.execute('''
      CREATE TABLE "notes" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "note" TEXT NOT NULL,
        "title" TEXT NOT NULL,
        "color" TEXT NOT NULL
      )
    ''');
    
    /*
    // جدول اخر 
      batch.execute('''
      CREATE TABLE "users" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "name" TEXT NOT NULL,
        "age" TEXT NOT NULL,
        "address" TEXT NOT NULL
      )
    ''');
    */
    await batch.commit();
    
    
    print("onCreate =================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
  

/*
دالة **_onUpgrade** في مكتبة sqflite تُعتبر **"صمام الأمان" لإدارة التحديثات وتطور هيكل قاعدة البيانات (Database Migration)** على أجهزة المستخدمين.
إليك تفصيل فوائدها ومتى تُستخدم وكيف تعمل:
### 1. ما هي فوائدها الأساسية؟
 * **تحديث هيكل الجداول دون فقدان بيانات المستخدم:** عندما تقوم بإصدار تحديث جديد لتطبيقك (مثلاً إضافة عمود جديد لجدول الملاحظات، أو إنشاء جدول جديد مثل users)، فإن المستخدم الذي لديه النسخة القديمة من التطبيق لن يتم حذف بياناته، بل ستعمل هذه الدالة لإجراء التعديلات المطلوبة على قاعدة البيانات الحالية لديه.
 * **منع انهيار التطبيق (Crashes):** لو قام المستخدم بتحديث التطبيق وزاد رقم الـ version في كود openDatabase (مثلاً من 1 إلى 2) ولم تكن هذه الدالة موجودة أو مهيأة للتعامل مع التغيير، سيتوقف التطبيق عن العمل أو يحدث خطأ فادح.
### 2. كيف تعمل ومتى يتم استدعاؤها؟
تعتمد تماماً على رقم الإصدار (**version**) الذي ترسله داخل دالة openDatabase في ملف تهيئة القاعدة (sqldb.dart):
```dart
Database mydb = await openDatabase(
  path,
  onCreate: _onCreate, 
  version: 2, // <--- رقم الإصدار الحالي
  onUpgrade: _onUpgrade // <--- الدالة المسؤولة عن الترقية
);

```
 * عندما يفتح المستخدم التطبيق، تقوم مكتبة sqflite بمقارنة **رقم الإصدار المخزن مسبقاً على جهازه** مع **رقم الإصدار الجديد (version)** الموجود في الكود.
 * **إذا وجدته أكبر** (مثلاً كان الإصدار القديم 1 وأصبح الجديد 2)، فإن فلاتر يترك دالة _onCreate (لأنها لا تعمل إلا مرة واحدة عند إنشاء القاعدة لأول مرة) ويقوم **تلقائياً** باستدعاء دالة **_onUpgrade**.
### 3. مثال عملي: كيف نستخدمها عند إضافة جدول جديد أو عمود جديد؟
غالباً ما يتم استخدام معامل oldVersion داخل الدالة لمعرفة النسخة التي كان عليها المستخدم، وتطبيق التعديلات تدريجياً:
```dart
_onUpgrade(Database db, int oldVersion, int newVersion) async {
  print("onUpgrade =====================================");
  
  // إذا كان المستخدم على الإصدار القديم 1 ويريد الانتقال للإصدار 2
  if (oldVersion < 2) {
    // نفترض أننا نريد إضافة عمود جديد اسمه "importance" لجدول notes
    await db.execute('ALTER TABLE notes ADD COLUMN importance TEXT');
  }
  
  // إذا قمت لاحقاً بعمل إصدار رقم 3 لإضافة جدول جديد
  if (oldVersion < 3) {
    await db.execute('''
      CREATE TABLE "categories" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "name" TEXT NOT NULL
      )
    ''');
  }
}

```
**باختصار:** هي الدالة المسؤولة عن إجراء "الترقيات والصيانة" على قاعدة بيانات المستخدمين القدامى عندما تقوم بتطوير تطبيقك وإضافة ميزات جديدة تتطلب تعديل شكل الجداول.


*/