import 'package:flutter/material.dart';
import 'package:training42_animasyonlu_slider_gelistirme/slider.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animasyonlu Slider"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: CustomSlider(),
        ),
      ),
    );
  }
}
