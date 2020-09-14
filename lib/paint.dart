import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  final double sliderPozisyon;
  final double dragYuzdelik;
  final Color renk;
  final Paint fillPainter;
  final Paint wavePainter;

  Painter({this.sliderPozisyon, this.dragYuzdelik, this.renk})
      : fillPainter = Paint()
          ..color = renk
          ..style = PaintingStyle.fill,
        wavePainter = Paint()
          ..color = renk
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5;

  @override
  void paint(Canvas canvas, Size size) {
    _paintAnchors(canvas, size);
    // bu metodda çizim gerçekleştiriliyor.
    _paintLine(canvas, size);
  }

  _paintAnchors(Canvas canvas, Size size) {
    // canvas çizim yapılacak aractır. Size ise içerisine yerleştirilecek widgetin boyutunu belirtir.
    canvas.drawCircle(Offset(0.0, size.height), 5.0, fillPainter);
    canvas.drawCircle(Offset(size.width, size.height), 5.0, fillPainter);
  }

  _paintLine(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0.0, size.height); // çizginin başlangıç noktası
    path.lineTo(size.width, size.height); // çizginin bitiş noktası
    canvas.drawPath(path, wavePainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // bu metodda paintler arası versiyonlar inceleniyor. yani önceki versiyonları görebiliyoruz.
    return true;
  }
}
