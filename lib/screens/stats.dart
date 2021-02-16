import 'package:flutter/material.dart';
import 'package:testdailyapp/screens/India.dart';
import 'package:testdailyapp/widgets/tabbarBox.dart';

import 'global.dart';
import 'states.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

// TabController controller = TabController(
//   initialIndex: 0,
//   length: 3,
//   vsync:
// );

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffFFF9EC),
            toolbarHeight: 70,
            bottom: TabBar(
              indicatorWeight: 3.0,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                TBox('Global'),
                TBox('India'),
                TBox('States'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Global(),
              India(),
              States(),
            ],
          )),
    );
  }
}
