import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:testdailyapp/Colors/colors.dart';
import 'package:testdailyapp/app/repositories/data_repository.dart';
import 'package:testdailyapp/app/services/api_services.dart';
import 'package:testdailyapp/screens/splash.dart';
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
//TODO:pehle to graph class mein hi graph ko shi krro name vgera vhi aaye hme bs call krna hai
//TODO:data bdaa chutiya lgg rha hai graph ka isse theek krro bc, one day ka data do nhi to 
//dekho ki moth ya last 2 month
//TODO:function v as a constructor pass honge fr jo call krege provider ke saath vo fxn waha call hogaa
//TODO:cache data ka dekh agr kuch hotta to and make sure ki vo data mein commas aw ja aaye.
//TODOLaunch Date = 5th April,2020