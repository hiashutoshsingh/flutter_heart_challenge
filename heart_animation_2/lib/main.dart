import 'package:flutter/material.dart';
import 'package:heart_animation_2/animation.dart';

void main() {
  runApp(MaterialApp(
    title: "Flutter Like Button Animation",
    theme: ThemeData(primarySwatch: Colors.pink),
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: height * 0.3,
          width: width * 0.9,
          constraints: const BoxConstraints(
            minHeight: 300,
            maxWidth: 600,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: const HeartAnimation(),
        ),
      ),
    );
  }
}
