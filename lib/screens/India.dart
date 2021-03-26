import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testdailyapp/app/repositories/data_repository.dart';
import 'package:testdailyapp/main.dart';
import 'package:testdailyapp/models/IndiaStats.dart';
import 'package:testdailyapp/widgets/box.dart';

class India extends StatefulWidget {
  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India> {
  Map<String, dynamic> stats;

  @override
  void initState() {
    super.initState();
    updateIndiaData();
    getIndiaStates();
  }

  Future updateIndiaData() async {
    var data = await Provider.of<DataRepository>(context, listen: false)
        .getIndiaTotal();
    setState(() {
      stats = data;
    });
    return stats;
  }

  Future getIndiaStates() async {
    return await Provider.of<DataRepository>(context, listen: false)
        .getStates();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        child: stats != null
            ? Column(
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
                          '+' + stats['TotalConfirmed'].toString()),
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
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: FutureBuilder(
                      future: getIndiaStates(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          IndiaStats states =
                              IndiaStats.fromJson(snapshot.data);
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                headingTextStyle:
                                    TextStyle(fontWeight: FontWeight.w400),
                                columnSpacing: 25,
                                dataRowHeight: 55,
                                columns: [
                                  DataColumn(
                                      label: Text('States',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              color: Colors.black45))),
                                  DataColumn(
                                      label: Text('Confirmed',
                                          textScaleFactor: 1.0,
                                          style:
                                              TextStyle(color: Colors.amber))),
                                  DataColumn(
                                      label: Text('Deaths',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(color: Colors.red))),
                                  DataColumn(
                                      label: Text('Recovered',
                                          textScaleFactor: 1.0,
                                          style:
                                              TextStyle(color: Colors.green))),
                                ],
                                rows: states.users
                                    .map((data) => DataRow(cells: [
                                          DataCell(Text(
                                            data.province,
                                            textScaleFactor: 1.0,
                                          )),
                                          DataCell(Text(
                                            data.confirmed.toString(),
                                            textScaleFactor: 1.0,
                                          )),
                                          DataCell(Text(
                                            data.deaths.toString(),
                                            textScaleFactor: 1.0,
                                          )),
                                          DataCell(Text(
                                            data.recovered.toString(),
                                            textScaleFactor: 1.0,
                                          )),
                                        ]))
                                    .toList(),
                              ),
                            ),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
