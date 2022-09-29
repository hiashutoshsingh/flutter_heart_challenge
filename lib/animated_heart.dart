import 'package:flutter/material.dart';
import 'package:heart_animation/constants.dart';

import 'heart.dart';

class OuterAnimatedHeart extends StatefulWidget {
  final Size endSize;
  final double opacity;
  final AnimationController animationController;

  const OuterAnimatedHeart({
    Key? key,
    required this.endSize,
    required this.opacity,
    required this.animationController,
  }) : super(key: key);

  @override
  State<OuterAnimatedHeart> createState() => _OuterAnimatedHeartState();
}

class _OuterAnimatedHeartState extends State<OuterAnimatedHeart>
    with TickerProviderStateMixin {
  late final Animation<Size> _heartReleasedScaleAnimation;

  @override
  void initState() {
    super.initState();
    _heartReleasedScaleAnimation = Tween<Size>(
      begin: const Size(80, 90),
      end: widget.endSize,
    ).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _heartReleasedScaleAnimation,
        builder: (BuildContext context, Widget? child) {
          return Heart(
            backgroundColor: Constants.green.withOpacity(widget.opacity),
            borderColor: Colors.transparent,
            height: _heartReleasedScaleAnimation.value.height,
            width: _heartReleasedScaleAnimation.value.width,
          );
        },
      ),
    );
  }
}
