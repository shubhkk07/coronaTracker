import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:testdailyapp/app/repositories/data_repository.dart';
import 'package:testdailyapp/app/services/api_services.dart';

import 'package:testdailyapp/screens/stats.dart';

import 'app/services/api.dart';
    
void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xffFFF9EC),
    statusBarIconBrightness: Brightness.dark
  ));
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(apiService: APIService(api: API.sandbox())),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xffd0f5ba),
          accentColor: Colors.green,
          fontFamily: 'Sen',
          scaffoldBackgroundColor:Color(0xffFFF9EC)
        ),
        home: Stats(),
      ),
    );
  }
}
