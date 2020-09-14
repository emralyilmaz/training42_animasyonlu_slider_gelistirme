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

  WaveLineDefinitions _useWaveLineDefinitions() {
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

    WaveLineDefinitions waveLine = WaveLineDefinitions(
        bendWidth: bendWidth,
        bezierWidth: bezierWidth,
        startOfBend: startOfBend,
        startOfBezierWidth: startOfBezierWidth,
        endOfBend: endOfBend,
        endOfBezier: endOfBezier,
        leftControlPoint1: leftControlPoint1,
        leftControlPoint2: leftControlPoint2,
        rightControlPoint1: rightControlPoint1,
        rightControlPoint2: rightControlPoint2,
        controlHeight: controlHeight,
        centerPoint: centerPoint);
    return waveLine;
  }

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

  // _paintLine(Canvas canvas, Size size) {
  //   Path path = Path();
  //   path.moveTo(0.0, size.height); // çizginin başlangıç noktası
  //   path.lineTo(size.width, size.height); // çizginin bitiş noktası
  //   canvas.drawPath(path, wavePainter);
  // }

  // _paintBlock(Canvas canvas, Size size) {
  //   Rect sliderRect =
  //       Offset(sliderPozisyon, size.height - 7.5) & Size(5.0, 15.0);
  //   canvas.drawRect(sliderRect, fillPainter);
  // }

  _paintWaveLine(Canvas canvas, Size size) {
    WaveLineDefinitions waveLine = _useWaveLineDefinitions();

    Path path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(waveLine.startOfBezierWidth, size.height);
    path.cubicTo(
        waveLine.leftControlPoint1,
        size.height,
        waveLine.leftControlPoint2,
        waveLine.controlHeight,
        waveLine.centerPoint,
        waveLine.controlHeight);
    path.cubicTo(
        waveLine.rightControlPoint1,
        waveLine.controlHeight,
        waveLine.rightControlPoint2,
        size.height,
        waveLine.endOfBezier,
        size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, wavePainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // bu metodda paintler arası versiyonlar inceleniyor. yani önceki versiyonları görebiliyoruz.
    return true;
  }
}

class WaveLineDefinitions {
  double bendWidth;
  double bezierWidth;

  double startOfBend;
  double startOfBezierWidth;
  double endOfBend;
  double endOfBezier;

  double leftControlPoint1;
  double leftControlPoint2;
  double rightControlPoint1;
  double rightControlPoint2;

  double controlHeight;
  double centerPoint;

  WaveLineDefinitions(
      {this.bendWidth,
      this.bezierWidth,
      this.startOfBend,
      this.startOfBezierWidth,
      this.endOfBend,
      this.endOfBezier,
      this.leftControlPoint1,
      this.leftControlPoint2,
      this.rightControlPoint1,
      this.rightControlPoint2,
      this.controlHeight,
      this.centerPoint});
}
