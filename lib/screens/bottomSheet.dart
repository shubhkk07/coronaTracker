import 'package:flutter/material.dart';
import 'package:testdailyapp/screens/Graphical%20Data/graphicalRepresentation.dart';
import 'package:testdailyapp/main.dart';
import 'package:testdailyapp/models/IndiaStats.dart';
import 'package:testdailyapp/models/users.dart';
import 'package:testdailyapp/widgets/box.dart';

class Sheet extends StatefulWidget {
  final Users data;
  final User user;
  Sheet({this.data, this.user});
  @override
  _SheetState createState() => _SheetState(data: this.data, user: this.user);
}

class _SheetState extends State<Sheet> {
  final Users data;
  final User user;
  _SheetState({this.data, this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.82,
      child: Center(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 15),
                child: Text(data != null ? data.country : user.province,
                    style: TextStyle(fontSize: 18)),
              ),
              Row(
                children: [
                  Box(
                      color.confirmed,
                      Colors.amber,
                      'Confirmed',
                      (data != null ? data.confirmed : user.confirmed)
                          .toString(),
                      ((data != null ? ('+' + '${data.newConfirmed}') : '')
                          .toString())),
                  Box(
                      color.deaths,
                      Colors.red,
                      'Deaths',
                      (data != null ? data.deaths : user.deaths).toString(),
                      ((data != null ? ('+' + '${data.newDeaths}') : '')
                          .toString()))
                ],
              ),
              Row(
                children: [
                  Box(
                      color.recovered,
                      Colors.green,
                      'Recovered',
                      (data != null
                              ? (data.recovered != 0 ? data.recovered : '-')
                              : user.recovered)
                          .toString(),
                      ((data != null
                              ? (data.newRecovered != 0
                                  ? ('+' + '${data.newConfirmed}')
                                  : '')
                              : '')
                          .toString())),
                  Box(
                      color.active,
                      Colors.blue,
                      'Active',
                      (data != null
                              ? data.confirmed - data.deaths - data.recovered
                              : user.confirmed - user.deaths - user.recovered)
                          .toString(),
                      '')
                ],
              ),
              Container(
                padding: EdgeInsets.only(top:20),
                child: GraphicalData(
                  height: MediaQuery.of(context).size.height*0.35,
                  myCountry: data != null ? (data.country) : null,
                  myProvince: user != null ? user.province : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
