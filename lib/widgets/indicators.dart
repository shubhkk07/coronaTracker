import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {

 buildMarker(Color color, String text){
   return Row(
     children: [
            Container(color: color,height: 5,width: 5,),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(text,style: TextStyle(fontSize: 11),),
            )
          ],
   );
 }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:[ 
        buildMarker(Colors.amber,'Confirmed'),
        buildMarker(Colors.red,'Deaths'),
        buildMarker(Colors.green,'Recovered'),
        buildMarker(Colors.blue,'Active'),
        ]
    );
  }
}


// [
//         Row(
//           children: [
//             Container(color: Colors.amber,height: 5,width: 5,),
//             Padding(
//               padding: const EdgeInsets.only(left:8.0),
//               child: Text('Confirmed',style: TextStyle(fontSize: 8),),
//             )
//           ],
//         ),
        
//         Container(color: Colors.amber,height: 5,width: 5,),
//         Container(color: Colors.amber,height: 5,width: 5,),
//         Container(color: Colors.amber,height: 5,width: 5,),
//       ],