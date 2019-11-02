import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

class LookupPage extends StatelessWidget{
  final Color color;

  LookupPage(this.color);

  @override
  Widget build(BuildContext context){
    return Stack(

      children: <Widget>[

        Container(
          color: color,

        )

      ],

    );
  }
}