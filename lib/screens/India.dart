import 'dart:io';
import 'package:testdailyapp/screens/Graphical%20Data/graphicalRepresentation.dart';
import 'package:testdailyapp/widgets/exceptionHandle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testdailyapp/app/repositories/data_repository.dart';
import 'package:testdailyapp/main.dart';
import 'package:testdailyapp/models/IndiaStats.dart';
import 'package:testdailyapp/screens/bottomSheet.dart';
import 'package:testdailyapp/widgets/box.dart';

class India extends StatefulWidget {
  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India>
    with AutomaticKeepAliveClientMixin<India> {
  Map<String, dynamic> stats;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    updateIndiaData();
    getIndiaStates();
  }

  Future updateIndiaData() async {
    try {
      var data = await Provider.of<DataRepository>(context, listen: false)
          .getIndiaTotal();
      setState(() {
        stats = data;
      });
      return stats;
    } on SocketException catch (_) {
      showException(context);
    }
  }

  Future getIndiaStates() async {
    return await Provider.of<DataRepository>(context, listen: false)
        .getStates();
  }

  showBottomSheet(states) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Color(0xffFFF9EC),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Sheet(
              user: states,
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5, left: 10, right: 10),
        child: stats != null
            ? RefreshIndicator(
                onRefresh: updateIndiaData,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Box(
                            color.confirmed,
                            Colors.amber,
                            'Confirmed',
                            stats['TotalConfirmed'].toString(),
                            '+' + stats['NewConfirmed'].toString()),
                        Box(
                            color.deaths,
                            Colors.red,
                            'Deaths',
                            stats['TotalDeaths'].toString(),
                            '+' + stats['NewDeaths'].toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Box(
                            color.recovered,
                            Colors.green,
                            'Recovered',
                            stats['TotalRecovered'].toString(),
                            '+' + stats['NewRecovered'].toString()),
                        Box(
                            color.active,
                            Colors.blue,
                            'Active',
                            (stats['TotalConfirmed'] -
                                    stats['TotalRecovered'] -
                                    stats['TotalDeaths'])
                                .toString(),
                            ''),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: GraphicalData(
                        height: MediaQuery.of(context).size.height * 0.4,
                        myCountry: 'India',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        'State wise Table',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 15),
                      height: MediaQuery.of(context).size.height * 0.62,
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder(
                        future: getIndiaStates(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            IndiaStats states =
                                IndiaStats.fromJson(snapshot.data);
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(textScaleFactor: 1.0),
                              child: DataTable(
                                dataTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                                headingRowColor:
                                    MaterialStateProperty.all(color.recovered),
                                headingRowHeight: 65,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                headingTextStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 13.5
                                    ),
                                columnSpacing:
                                    MediaQuery.of(context).size.width * 0.045,
                                dataRowHeight: 55,
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    'States',
                                   
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Confirmed',
                                   
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Deaths',
                                   
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Recovered',
                                   
                                  )),
                                ],
                                rows: states.users
                                    .map((data) => DataRow(cells: [
                                          DataCell(
                                              Text(
                                                data.province,
                                               
                                              ),
                                              onTap: () =>
                                                  showBottomSheet(data)),
                                          DataCell(
                                              Text(
                                                data.confirmed.toString(),
                                                
                                              ),
                                              onTap: () =>
                                                  showBottomSheet(data)),
                                          DataCell(
                                              Text(
                                                data.deaths.toString(),
                                                
                                              ),
                                              onTap: () =>
                                                  showBottomSheet(data)),
                                          DataCell(
                                              Text(
                                                data.recovered.toString(),
                                               
                                              ),
                                              onTap: () =>
                                                  showBottomSheet(data)),
                                        ]))
                                    .toList(),
                              ),
                            ));
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
