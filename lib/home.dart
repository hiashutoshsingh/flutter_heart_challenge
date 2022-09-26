import 'package:flutter/material.dart';

import 'heart.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff191414),
      body: Center(
        // child: Icon(
        //   Icons.favorite_border_outlined,
        //   color: Colors.white,
        //   size: 48,
        // ),
        child: Heart(),
      ),
    );
  }
}
