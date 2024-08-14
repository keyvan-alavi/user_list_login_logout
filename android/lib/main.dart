import 'package:flutter/material.dart';
import 'package:myloginlogout/firstviewpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'nika'),
      home: Firstviewpage(),
    );
  }
}
