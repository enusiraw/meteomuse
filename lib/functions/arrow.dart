import 'dart:math';
import 'dart:ui' as ui; // Importing dart:ui for ui.Image
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle

class ArrowPainter extends CustomPainter {
  final double progress;
  final ui.Image arrowImage; 

  ArrowPainter({required this.progress, required this.arrowImage});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 8,
    );
    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

    const arrowSize = 40.0;
    final imageRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: arrowSize,
      height: arrowSize,
    );

    canvas.drawImageRect(
      arrowImage,
      Rect.fromLTWH(0, 0, arrowImage.width.toDouble(), arrowImage.height.toDouble()),
      imageRect,
      Paint(),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}