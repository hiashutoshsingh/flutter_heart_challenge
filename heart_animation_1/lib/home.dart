import 'package:flutter/material.dart';
import 'package:heart_animation/constants.dart';

import 'outer_animated_heart.dart';
import 'heart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final AnimationController _heartPressedScaleController;
  late final Animation<Size> _heartPressedScaleAnimation;
  late final Animation<Color?> _heartBackgroundColorAnimation;
  late final ColorTween _heartBackgroundColorTween;
  late final AnimationController _heartReleasedScaleController;
  late final Animation<Size> _heartReleasedScaleAnimation;
  late final AnimationController _outerHeartReleasedScaleController;
  late bool _showBorder;

  @override
  void initState() {
    super.initState();
    _showBorder = true;
    _initHeartPressedAnimation();
    _initHeartReleasedAnimation();
    _initOuterHeartReleasedAnimation();
  }

  void _initHeartPressedAnimation() {
    _heartPressedScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _heartPressedScaleAnimation = Tween<Size>(
      begin: const Size(100, 110),
      end: const Size(80, 90),
    ).animate(_heartPressedScaleController);
  }

  void _initHeartReleasedAnimation() {
    _heartReleasedScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _heartReleasedScaleAnimation = Tween<Size>(
      begin: const Size(80, 90),
      end: const Size(110, 120),
    ).animate(
      CurvedAnimation(
        parent: _heartReleasedScaleController,
        curve: Curves.easeOutBack,
      ),
    );

    _heartBackgroundColorTween = ColorTween(
      begin: Colors.transparent,
      end: Constants.green,
    );

    _heartBackgroundColorAnimation =
        _heartBackgroundColorTween.animate(_heartReleasedScaleController);
  }

  void _initOuterHeartReleasedAnimation() {
    _outerHeartReleasedScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
    );
  }

  Animation<Size> _getHeartScaleAnimation() {
    return !_heartPressedScaleController.isCompleted
        ? _heartPressedScaleAnimation
        : _heartReleasedScaleAnimation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.black,
      body: GestureDetector(
        onTap: () {
          if (_heartPressedScaleController.isCompleted) {
            setState(() {
              _showBorder = true;
            });
            _heartPressedScaleController.reset();
            _heartReleasedScaleController.reset();
            _outerHeartReleasedScaleController.reset();
          } else {
            _heartPressedScaleController.forward().then((value) {
              setState(() {
                _showBorder = false;
              });
              _heartReleasedScaleController.forward();
              _outerHeartReleasedScaleController.forward().then((value) {
                _outerHeartReleasedScaleController.reverse();
              });
            });
          }
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: OuterAnimatedHeart(
                endSize: const Size(180, 190),
                opacity: .3,
                animationController: _outerHeartReleasedScaleController,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: OuterAnimatedHeart(
                endSize: const Size(250, 260),
                opacity: .1,
                animationController: _outerHeartReleasedScaleController,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _getHeartScaleAnimation(),
                builder: (context, child) {
                  return AnimatedBuilder(
                    animation: _heartBackgroundColorAnimation,
                    builder: (context, child) {
                      return Heart(
                        backgroundColor: _heartBackgroundColorAnimation.value!,
                        borderColor:
                            _showBorder ? Colors.white : Colors.transparent,
                        height: _getHeartScaleAnimation().value.height,
                        width: _getHeartScaleAnimation().value.width,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heartPressedScaleController.dispose();
    _heartReleasedScaleController.dispose();
    super.dispose();
  }
}
