import 'package:flutter/material.dart';
import 'package:kutubuku/screens/addbook.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KutuBuku',
      theme: ThemeData(
      ),
      home: SearchBookScreen(),
    );
  }
}
