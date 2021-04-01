

import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  Box(this.color1,this.color2,this.text1,this.text2,[this.text3]);
  final Color color1;
  final Color color2;
  final String text1;
  final String text2;
  final String text3;
  
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 4,right: 4),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:10,vertical:12),
          margin: EdgeInsets.only(top: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: color1
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom:6.0),
                child: Text(text1,style: TextStyle(color:color2,fontWeight: FontWeight.bold),),
              ),
              Text(text2,style: TextStyle(fontSize:22,color:color2)),
              Text(text3,style: TextStyle(color: color2),)
            ],
          ),
        ),
      ),
    );
  }
}