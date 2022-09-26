import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const HeartApp());
}

class HeartApp extends StatelessWidget {
  const HeartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
