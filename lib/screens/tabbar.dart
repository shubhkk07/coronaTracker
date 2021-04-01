import 'package:flutter/material.dart';
import 'package:testdailyapp/main.dart';
import 'package:testdailyapp/screens/India.dart';
import 'package:testdailyapp/widgets/tabbarBox.dart';

import 'global.dart';


class Tabbar extends StatefulWidget {
  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffFFF9EC),
            toolbarHeight: 55,
            bottom: TabBar(
              indicator: BoxDecoration(
                shape: BoxShape.rectangle,
                color: color.recovered,
                border:Border(bottom: BorderSide(color: Colors.green,width: 3,style: BorderStyle.solid))
              ),
              isScrollable: false,
              physics: NeverScrollableScrollPhysics(),
              
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
