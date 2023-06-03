import 'package:flutter/material.dart';
import 'dart:math' as math;

class HalfCircleBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final double strokeWidth = 5.0;
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Path path = Path()
      ..addArc(
        Rect.fromCircle(
            center: Offset(radius, radius), radius: radius - (strokeWidth / 2)),
        -math.pi,
        math.pi,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
