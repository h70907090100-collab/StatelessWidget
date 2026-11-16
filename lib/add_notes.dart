
/*
### 1. صفحة إضافة الملاحظة (`add_notes.dart`)
#تحتوي هذه الصفحة على النموذج (`Form`) بحقول الإدخال الثلاثة (`note`, `title`, `color`) وحفظها في قاعدة البيانات، ثم التوجيه للصفحة الرئيسية عند نجاح الإضافة:
*/

import 'package:flutter/material.dart';
import 'sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء ملاحظة جديدة'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    controller: note,
                    decoration: const InputDecoration(
                      hintText: "الملاحظة (note)",
                    ),
                  ),
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(
                      hintText: "التفاصيل (title)",
                    ),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: const InputDecoration(
                      hintText: "اللون (color)",
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {
                      int response = await sqlDb.insertData('''
                        INSERT INTO notes ('note', 'title', 'color')
                        VALUES ("${note.text}", "${title.text}", "${color.text}")
                      ''');

                      if (response > 0) {
                        Navigator.of(context).pushReplacementNamed("home");
                      }
                    },
                    child: const Text("إضافة ملاحظة"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}