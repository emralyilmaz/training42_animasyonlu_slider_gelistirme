import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  final double sliderPozisyon;
  final double dragYuzdelik;
  final Color renk;
  final Paint fillPainter;

  Painter({this.sliderPozisyon, this.dragYuzdelik, this.renk})
      : fillPainter = Paint()
          ..color = renk
          ..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    _paintAnchors(canvas, size);
    // bu metodda çizim gerçekleştiriliyor.
  }

  _paintAnchors(Canvas canvas, Size size) {
    // canvas çizim yapılacak aractır. Size ise içerisine yerleştirilecek widgetin boyutunu belirtir.
    canvas.drawCircle(Offset(0.0, size.height), 5.0, fillPainter);
    canvas.drawCircle(Offset(size.width, size.height), 5.0, fillPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // bu metodda paintler arası versiyonlar inceleniyor. yani önceki versiyonları görebiliyoruz.
    return true;
  }
}
