import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() => runApp(DailyToolkitApp());

class DailyToolkitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Toolkit',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: LoginPage(), // <--- ini penting biar ke halaman login
      debugShowCheckedModeBanner: false,
    );
  }
}
