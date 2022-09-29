import 'package:flutter/material.dart';
import 'package:heart_animation/constants.dart';

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
  late final Animation<Color?> _heartBorderColorAnimation;
  late final ColorTween _heartBorderColorTween;
  late final ColorTween _heartBackgroundColorTween;
  late final AnimationController _heartReleasedScaleController;
  late final Animation<Color?> _heartBackgroundConstantColorAnimation;
  late final ColorTween _heartConstantBorderColorTween;
  late final Animation<Color?> _heartConstantBorderColorAnimation;
  late final ColorTween _heartConstantBackgroundColorTween;
  late final Animation<Size> _heartReleasedScaleAnimation;
  late bool _isPressed;

  @override
  void initState() {
    super.initState();
    _isPressed = true;
    _heartPressedScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _heartReleasedScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _heartPressedScaleAnimation = Tween<Size>(
      begin: const Size(100, 110),
      end: const Size(80, 90),
    ).animate(_heartPressedScaleController);

    _heartReleasedScaleAnimation = Tween<Size>(
      begin: const Size(80, 90),
      end: const Size(100, 110),
    ).animate(_heartReleasedScaleController);

    _heartConstantBackgroundColorTween = ColorTween(
      begin: Constants.black,
      end: Constants.black,
    );

    _heartBackgroundColorTween = ColorTween(
      begin: Constants.black,
      end: Constants.green,
    );

    _heartBackgroundConstantColorAnimation = _heartConstantBackgroundColorTween
        .animate(_heartPressedScaleController);

    _heartBackgroundColorAnimation =
        _heartBackgroundColorTween.animate(_heartReleasedScaleController);

    _heartBorderColorTween = ColorTween(
      begin: Colors.white,
      end: Constants.black,
    );

    _heartBorderColorAnimation =
        _heartBorderColorTween.animate(_heartPressedScaleController);

    _heartConstantBorderColorTween = ColorTween(
      begin: Colors.black,
      end: Constants.black,
    );

    _heartConstantBorderColorAnimation =
        _heartConstantBorderColorTween.animate(_heartReleasedScaleController);
  }

  @override
  void dispose() {
    _heartPressedScaleController.dispose();
    super.dispose();
  }

  Animation<Color?> _getBackGroundAnimation() {
    return _isPressed
        ? _heartBackgroundConstantColorAnimation
        : _heartBackgroundColorAnimation;
  }

  Animation<Color?> _getBorderColorAnimation() {
    return _isPressed
        ? _heartBorderColorAnimation
        : _heartConstantBorderColorAnimation;
  }

  Animation<Size> _getHeartScaleAnimation() {
    return _isPressed
        ? _heartPressedScaleAnimation
        : _heartReleasedScaleAnimation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.black,
      body: GestureDetector(
        onTap: () {
          _heartPressedScaleController.forward().then((value) {
            setState(() {
              _isPressed = false;
            });
            _heartReleasedScaleController.forward();
          });
        },
        child: Center(
          child: AnimatedBuilder(
            animation: _getHeartScaleAnimation(),
            builder: (BuildContext context, Widget? child) {
              return AnimatedBuilder(
                animation: _getBackGroundAnimation(),
                builder: (BuildContext context, Widget? child) {
                  return AnimatedBuilder(
                    animation: _getBorderColorAnimation(),
                    builder: (BuildContext context, Widget? child) {
                      return Heart(
                        backgroundColor: _getBackGroundAnimation().value!,
                        borderColor: _getBorderColorAnimation().value!,
                        height: _getHeartScaleAnimation().value.height,
                        width: _getHeartScaleAnimation().value.width,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
