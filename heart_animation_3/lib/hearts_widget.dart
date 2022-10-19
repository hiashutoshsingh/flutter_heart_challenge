import 'package:flutter/material.dart';

import 'heart_model.dart';

class Hearts extends StatefulWidget {
  const Hearts({
    Key? key,
  }) : super(key: key);

  @override
  _HeartsState createState() => _HeartsState();
}

class _HeartsState extends State<Hearts> with SingleTickerProviderStateMixin {
  static final base = [
    Colors.green,
    Colors.white,
    Colors.black,
  ].reversed.toList();
  final colors = base + base + base;

  late AnimationController animation;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(vsync: this);
    animation.duration = Duration(seconds: 8);
    animation.addListener(() => setState(() {}));
    animation.forward();
    animation.repeat();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var count = 0;
    final children = (colors.map((color) {
      final offset = 1 - (count++ / colors.length);
      final fraction = (animation.value + offset) % 1;

      return HeartHelper(
        Transform.scale(
          scale: 100 * Curves.decelerate.transform(fraction),
          child: Icon(Icons.favorite, color: color),
        ),
        fraction,
      );
    }).toList()
          ..sort((a, b) => -a.scale.compareTo(b.scale)))
        .map((helper) => helper.child)
        .toList();

    return Stack(
      fit: StackFit.expand,
      children: children,
    );
  }
}
