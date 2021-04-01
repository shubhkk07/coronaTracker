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
    Timer(Duration(milliseconds: 5000),()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Tabbar())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Image(image: AssetImage('images/splash.png'),),
              Text('Corona Tracker',style: TextStyle(fontSize: 24),)
            ]
          ),
        ),
      ),
    );
  }
}