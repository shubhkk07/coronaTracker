import 'package:flutter/material.dart';

class TBox extends StatelessWidget {
  final String text;
  TBox(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top:10,bottom: 12,left:5,right: 5),
        child: Center(
            child: Text(
          '$text',
        )));
  }
}
