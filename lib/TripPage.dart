import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

class TripPage extends StatelessWidget{
  final Color color;
  final String text;

  TripPage(this.color, this.text);

  @override
  Widget build(BuildContext context){
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            print(this.text);
          },
          child: Container(
            color: color,
          ),
        ),
      ],
    );
  }

}