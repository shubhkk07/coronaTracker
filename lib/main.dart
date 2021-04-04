import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:testdailyapp/Colors/colors.dart';
import 'package:testdailyapp/app/repositories/data_repository.dart';
import 'package:testdailyapp/app/services/api_services.dart';
import 'package:testdailyapp/screens/Graphical%20Data/graphicalRepresentation.dart';
import 'package:testdailyapp/screens/splash.dart';
import 'package:testdailyapp/screens/Graphical%20Data/worldGraph.dart';
import 'app/services/api.dart';


const color = colors();

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xffFFF9EC),
      statusBarIconBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(apiService: APIService(api: API())),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xffd0f5ba),
            accentColor: Colors.green,
            fontFamily: 'Sen',
            scaffoldBackgroundColor: Color(0xffFFF9EC)),
        home: Splash(),
      ),
    );
  }
}

//TODO:font family should be replaced
//TODO:USa ka data null hai vaha null check lgaa
//TODOLaunch Date = 5th April,2020