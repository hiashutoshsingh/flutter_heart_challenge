import 'package:flutter/material.dart';
import 'package:heart_animation/constants.dart';

import 'heart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final AnimationController _heartScaleController;
  late final Animation<Size> _heartScaleAnimation;

  @override
  void initState() {
    super.initState();
    _heartScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _heartScaleAnimation = Tween<Size>(
      begin: const Size(100, 110),
      end: const Size(80, 90),
    ).animate(_heartScaleController);
  }

  @override
  void dispose() {
    _heartScaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.black,
      body: GestureDetector(
        onTap: () {
          _heartScaleController
              .forward()
              .then((value) => _heartScaleController.reverse());
        },
        child: Center(
          child: AnimatedBuilder(
            animation: _heartScaleAnimation,
            builder: (BuildContext context, Widget? child) {
              return Heart(
                backgroundColor: Constants.black,
                borderColor: Colors.white,
                height: _heartScaleAnimation.value.height,
                width: _heartScaleAnimation.value.width,
              );
            },
          ),
        ),
      ),
    );
  }
}

// 0xff1DB954 green color
// 0xff191414 black color
