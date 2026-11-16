import 'package:flutter/material.dart';


// انشاء صفحة مؤقتة اسمها notify.dart
class NotifyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notify Screen')),
      body: Center(child: Text('This is a temporary notify screen.')),
    );
  }
}
