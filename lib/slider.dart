import 'package:flutter/material.dart';

// drag işlemi mause'a tıklayıp sağa-sola yukarı-aşağı hareket ettirilmesidir.
// mause'a tıklanıldığı ilk alan: drag start
// mause'un tıklı bir şekilde gezdirildiği alan: update
// mause'a tıklanıldığı bitirildi alan: drag end

class CustomSlider extends StatefulWidget {
  final double genislik;
  final double yukseklik;

  CustomSlider({Key key, this.genislik = 350.0, this.yukseklik = 50.0});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Container(
          width: widget.genislik,
          height: widget.yukseklik,
          color: Colors.black,
        ),
        onHorizontalDragUpdate: (DragUpdateDetails update) {
          print(update.globalPosition);
        },
      ),
    );
  }
}
