import 'package:flutter/material.dart';
import 'package:testdailyapp/Colors/colors.dart';
import 'package:testdailyapp/main.dart';
import 'package:testdailyapp/screens/India.dart';
import 'package:testdailyapp/widgets/tabbarBox.dart';

import 'global.dart';
import 'states.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffFFF9EC),
            toolbarHeight: 55,
            bottom: TabBar(
               
              isScrollable: false,
              physics: NeverScrollableScrollPhysics(),
              indicatorWeight: 3.0,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                TBox('Global'),
                TBox('India'),
             
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Global(),
              India(),
              
            ],
          )),
    );
  }
}
