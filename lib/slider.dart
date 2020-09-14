import 'package:flutter/material.dart';

// NOT: localda _onDragStart ve _onDragEnd metodları oluşturulmasada localde konumlandırma yapılabilir.

// drag işlemi mause'a tıklayıp sağa-sola yukarı-aşağı hareket ettirilmesidir.
// mause'a tıklanıldığı ilk alan: drag start
// mause'un tıklı bir şekilde gezdirildiği alan: update
// mause'a tıklanıldığı bitirildi alan: drag end

class CustomSlider extends StatefulWidget {
  final double genislik;
  final double yukseklik;

  CustomSlider({Key key, this.genislik = 300.0, this.yukseklik = 50.0});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double dragPozisyon = 0;
  double dragYuzdelik = 0;

  void _udpateDragPozition(Offset val) {
    double _yeniDragPozisyon = 0;

    if (val.dx <= 0) {
      _yeniDragPozisyon = 0;
    } else if (val.dx >= widget.genislik) {
      _yeniDragPozisyon = widget.genislik;
    } else {
      _yeniDragPozisyon = val.dx;
    }

    setState(() {
      dragPozisyon = _yeniDragPozisyon;
      dragYuzdelik = dragPozisyon / widget.genislik;
      print(dragPozisyon);
    });
  }

  void _onDragUpdate(BuildContext cont, DragUpdateDetails update) {
    RenderBox box = cont.findRenderObject();
    // findRenderObject bir kutu donderecek
    Offset offset =
        box.globalToLocal(update.globalPosition); // offset verisi yer belirtir.
    // globalToLocal metodu ile sahip olunan pozisyon bilgileri locala göre yeniden dizayn edilmesini saglar.
    // print(offset.dx); // sadece x eksenindeki degişiklikleri yazacak
    _udpateDragPozition(offset);
  }

  void _onDragStart(BuildContext cont, DragStartDetails start) {
    RenderBox box = cont.findRenderObject();
    Offset offset = box.globalToLocal(start.globalPosition);
    // print(offset.dx);
    _udpateDragPozition(offset);
  }

  void _onDragEnd(BuildContext cont, DragEndDetails update) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Container(
          width: widget.genislik,
          height: widget.yukseklik,
          color: Colors.black,
          child: Column(
            children: [
              Text(
                dragYuzdelik.toString(),
                style: TextStyle(color: Colors.white),
              ),
              Text(
                dragPozisyon.toString(),
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        onHorizontalDragUpdate: (DragUpdateDetails update) =>
            _onDragUpdate(context, update),
        //  print(update.globalPosition); // mause'un o anki pozisyonu
        // container içinde de dışındada pozisyonu gösterir.
        onHorizontalDragStart: (DragStartDetails start) =>
            _onDragStart(context, start),
        onHorizontalDragEnd: (DragEndDetails end) => _onDragEnd(context, end),
      ),
    );
  }
}
