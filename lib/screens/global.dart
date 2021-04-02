import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testdailyapp/app/repositories/data_repository.dart';
import 'package:testdailyapp/app/services/api.dart';
import 'package:testdailyapp/main.dart';
import 'package:testdailyapp/models/users.dart';
import 'package:testdailyapp/screens/bottomSheet.dart';
import 'package:testdailyapp/widgets/box.dart';

class Global extends StatefulWidget {
  @override
  _GlobalState createState() => _GlobalState();
}

class _GlobalState extends State<Global>
    with AutomaticKeepAliveClientMixin<Global> {
  Endpoint endpoint;
  List<int> _endpointData;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    updateStatsData();
    _updateData();
  }

  Future updateStatsData() async {
    return await Provider.of<DataRepository>(context, listen: false)
        .getCountriesStats();
  }

  Future<void> _updateData() async {
    var endpointData = await Provider.of<DataRepository>(context, listen: false)
        .getGlobaltotal();
    setState(() {
      _endpointData = endpointData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: _endpointData != null
          ? ListView(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Box(
                      color.confirmed,
                      Colors.amber,
                      'Confirmed',
                      _endpointData[0].toString(),
                      '+' + _endpointData[3].toString()),
                  Box(
                      color.deaths,
                      Colors.redAccent,
                      'Deaths',
                      _endpointData[1].toString(),
                      '+' + _endpointData[4].toString()),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Box(
                    color.recovered,
                    Colors.green,
                    'Recovered',
                    _endpointData[2].toString(),
                    '+' + _endpointData[5].toString()),
                Box(
                    color.active,
                    Colors.blueAccent,
                    'Active',
                    (_endpointData[0] - _endpointData[2] - _endpointData[1])
                        .toString(),
                    ''),
              ]),
              // Container(
              //   height: 350,
              //   padding: EdgeInsets.only(top: 20),
              //   child: Trend(),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  'Country-wise Table',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 20, bottom: 15),
                  height: MediaQuery.of(context).size.height * 0.62,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                      future: updateStatsData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Stat stat = Stat.fromJson(snapshot.data);
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                headingTextStyle:
                                    TextStyle(fontWeight: FontWeight.w400),
                                columnSpacing: 25,
                                dataRowHeight: 55,
                                columns: [
                                  DataColumn(
                                      label: Text('Country',
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
                                rows: stat.users
                                    .map((data) => DataRow(cells: [
                                          DataCell(
                                            Text(
                                              data.country,
                                              textScaleFactor: 1.0,
                                            ),
                                            onTap: () {
                                              showModalBottomSheet(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  backgroundColor:
                                                      Color(0xffFFF9EC),
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8),
                                                      child: Sheet(
                                                        data: data,
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                          DataCell(Text(
                                            data.confirmed.toString(),
                                            textScaleFactor: 1.0,
                                          )),
                                          DataCell(Text(
                                            data.deaths.toString(),
                                            textScaleFactor: 1.0,
                                          )),
                                          DataCell(Text(
                                            data.recovered != 0
                                                ? data.recovered.toString()
                                                : '-',
                                            textScaleFactor: 1.0,
                                          )),
                                        ]))
                                    .toList()),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }))
            ])
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
