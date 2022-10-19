import 'dart:math';

import 'package:flutter/material.dart';

import 'hearts_widget.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FractionalTranslation(
        translation: Offset(0, -0.03),
        child: Center(
          child: Hearts(),
        ),
      ),
    );
  }
}

class Heart extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final double height;
  final double width;

  const Heart({
    Key? key,
    required this.backgroundColor,
    required this.borderColor,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: HeartPainter(
        backgroundColor: backgroundColor,
        borderColor: borderColor,
      ),
    );
  }
}

class HeartPainter extends CustomPainter {
  final Color backgroundColor;
  final Color borderColor;

  HeartPainter({
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint strokePaint = Paint();
    strokePaint
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    Paint backgroundPaint = Paint()..style = PaintingStyle.fill;
    backgroundPaint.color = backgroundColor;

    Path path = Path();
    path.moveTo(
      size.width * 0.9250000,
      size.height * 0.1708333,
    );
    path.cubicTo(
      size.width * 1.037500,
      size.height * 0.2833333,
      size.width * 1.025000,
      size.height * 0.4583333,
      size.width * 0.9083333,
      size.height * 0.5666667,
    );
    path.lineTo(
      size.width * 0.5583333,
      size.height * 0.8958333,
    );
    path.cubicTo(
      size.width * 0.5250000,
      size.height * 0.9250000,
      size.width * 0.4708333,
      size.height * 0.9250000,
      size.width * 0.4375000,
      size.height * 0.8958333,
    );
    path.lineTo(
      size.width * 0.08750000,
      size.height * 0.5666667,
    );
    path.cubicTo(
      size.width * -0.02500000,
      size.height * 0.4583333,
      size.width * -0.03750000,
      size.height * 0.2833333,
      size.width * 0.07083333,
      size.height * 0.1708333,
    );
    path.cubicTo(
      size.width * 0.1916667,
      size.height * 0.05833333,
      size.width * 0.3833333,
      size.height * 0.05416667,
      size.width * 0.5000000,
      size.height * 0.1666667,
    );
    path.cubicTo(
      size.width * 0.6166667,
      size.height * 0.05416667,
      size.width * 0.8083333,
      size.height * 0.05833333,
      size.width * 0.9250000,
      size.height * 0.1708333,
    );
    path.close();

    canvas.drawPath(path, backgroundPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
