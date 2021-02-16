import 'package:flutter/material.dart';

class TBox extends StatelessWidget {
  final String text;
  TBox(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height:45,
      margin: EdgeInsets.symmetric(horizontal: 6,),
      decoration: BoxDecoration(
        color: Color(0xffd0f5ba),
        
        ),
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('$text',style: TextStyle(fontSize: 30),),
      )
    );
  }
}