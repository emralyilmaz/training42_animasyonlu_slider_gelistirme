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
    _paintAnchors(canvas, size); // bu metodda çizim gerçekleştiriliyor.
    //_paintLine(canvas, size);
    //_paintBlock(canvas, size);
    _paintWaveLine(canvas, size);
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

  _paintBlock(Canvas canvas, Size size) {
    Rect sliderRect =
        Offset(sliderPozisyon, size.height - 7.5) & Size(5.0, 15.0);
    canvas.drawRect(sliderRect, fillPainter);
  }

  _paintWaveLine(Canvas canvas, Size size) {
    double bendWidth =
        40.0; // bend: bükmek anlamında bendwidth: bükülme genişliği demek
    double bezierWidth = 40.0;

    double startOfBend =
        sliderPozisyon - bendWidth / 2; //bükmenin başlangıç noktası.
    double startOfBezierWidth = startOfBend - bezierWidth;
    double endOfBend = sliderPozisyon + bendWidth / 2;
    double endOfBezier = endOfBend + bezierWidth / 2;

    double leftControlPoint1 = startOfBend;
    double leftControlPoint2 = startOfBend;
    double rightControlPoint1 = endOfBend;
    double rightControlPoint2 = endOfBend;

    double controlHeight = 0;
    double centerPoint = sliderPozisyon;

    Path path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(startOfBezierWidth, size.height);
    path.cubicTo(leftControlPoint1, size.height, leftControlPoint2,
        controlHeight, centerPoint, controlHeight);
    path.cubicTo(rightControlPoint1, controlHeight, rightControlPoint2,
        size.height, endOfBezier, size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, wavePainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // bu metodda paintler arası versiyonlar inceleniyor. yani önceki versiyonları görebiliyoruz.
    return true;
  }
}
