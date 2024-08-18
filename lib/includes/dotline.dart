
import 'package:flutter/material.dart';
import 'package:meteomuse/includes/colors.dart';

class DrawDottedhorizontalline extends CustomPainter {
  late Paint _paint;
  DrawDottedhorizontalline() {
    _paint = Paint()
      ..color = MyColors.lighttextcolor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
  }


  @override
  void paint(Canvas canvas, Size size) {
    for(double i = -300; i < 300; i = i + 15){
      if(i% 3 == 0) {
        canvas.drawLine(Offset(i, 0.0), Offset(i+10, 0.0), _paint);
      }
    }
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
