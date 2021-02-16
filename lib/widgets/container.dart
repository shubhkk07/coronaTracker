

import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  Box(this.color1,this.color2,this.text1,this.text2);
  final Color color1;
  final Color color2;
  final String text1;
  final String text2;

  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.47,
      height: 120,
      padding: EdgeInsets.symmetric(horizontal:10,vertical:12),
      margin: EdgeInsets.only(top: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: color1
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
       
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:6.0),
            child: Text(text1,style: TextStyle(fontSize:18,color:color2.withOpacity(0.5),fontWeight: FontWeight.bold),),
          ),
          Text(text2,style: TextStyle(fontSize:40,color:color2))
        ],
      ),
    );
  }
}