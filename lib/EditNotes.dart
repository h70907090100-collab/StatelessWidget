
import 'package:flutter/material.dart';
import 'sqldb.dart'; // تأكد من استيراد ملف قاعدة البيانات الخاص بك

class EditNotes extends StatefulWidget {
  final note;
  final title;
  final color;
  final id;
  
  const EditNotes({
    Key? key, 
    required this.note, 
    required this.title, 
    required this.color, 
    required this.id
  }) : super(key: key);
    
  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes>{
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController colorController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.title;
    noteController.text = widget.note;
    colorController.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تعديل ملاحظة")),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formstate,
          child: Column(
            children:[
              TextFormField(controller: titleController, decoration: const InputDecoration(hintText: "العنوان")),
              TextFormField(controller: noteController, decoration: const InputDecoration(hintText: "الملاحظة")),
              TextFormField(controller: colorController, decoration: const InputDecoration(hintText: "اللون")),
              const SizedBox(height: 20),

              MaterialButton(
                onPressed: () async {
                  int response = await sqlDb.updateData('''
                    UPDATE notes SET
                     title = '${titleController.text}',
                     note = '${noteController.text}', 
                     color = '${colorController.text}'
                    WHERE id = ${widget.id}
                  ''');
                  if (response > 0) {
                    Navigator.of(context).pop(); // الرجوع للصفحة السابقة
                  }
                },
                color: Colors.blue,
                child: const Text("حفظ التعديلات", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}