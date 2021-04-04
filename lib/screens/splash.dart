import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testdailyapp/screens/tabbar.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() { 
    super.initState();
    Timer(Duration(milliseconds: 4000),()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Tabbar())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children:[
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage('images/splash.png'),)),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize:25,color: Colors.black,fontWeight: FontWeight.w500 ),
                text: 'corona',
                children: [
                  TextSpan(
                    text: 'Tracker',
                    style: TextStyle(color: Colors.green)
                  )
                ]
              ))
              // Text('Corona Tracker',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
            ]
          ),
        ),
      ),
    );
  }
}