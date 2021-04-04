import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testdailyapp/app/repositories/data_repository.dart';
import 'package:testdailyapp/main.dart';
import 'package:testdailyapp/models/world.dart';
import 'package:testdailyapp/widgets/indicators.dart';

class WorldGraph extends StatefulWidget {
  @override
  _WorldGraphState createState() => _WorldGraphState();
}

class _WorldGraphState extends State<WorldGraph> {
  Future getWorldData() async {
    return await Provider.of<DataRepository>(context, listen: false)
        .getWorldGraphData();
  }

  @override
  void initState() {
    super.initState();
    getWorldData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
          padding: EdgeInsets.only(bottom: 10,left: 10),
          child: Text('Graphical Representation',style: TextStyle(fontSize: 18),),
        ), 
        Padding(padding: EdgeInsets.only(top:10),
          child: Indicator(),), 
        FutureBuilder(
            future: getWorldData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height*0.4,
                  child: SfCartesianChart(
                    
                    primaryXAxis: CategoryAxis(interval: 10),
                    primaryYAxis: NumericAxis(
                        title: AxisTitle(text: 'cases'),
                        anchorRangeToVisiblePoints: false,
                        isVisible: false),

                    tooltipBehavior: TooltipBehavior(
                      tooltipPosition: TooltipPosition.pointer,
                      enable: true,
                      animationDuration: 3,
                      color: color.recovered,
                      textStyle: TextStyle(color: Colors.black),
                      elevation: 10,
                      shadowColor: Colors.grey,
                    ),
                    series: [
                      LineSeries(
                        color: Colors.amber,
                        name: 'Confirmed',
                        xAxisName: 'Cases',
                        yAxisName: 'Date',
                        dataSource: snapshot.data,
                        xValueMapper: (GlobalData graph, _) =>
                            DateFormat('MMMd').format(graph.dateTime),
                        yValueMapper: (GlobalData graph, _) =>
                            graph.totalConfirmed,
                            dataLabelSettings: DataLabelSettings()
                      ),
                      LineSeries(
                        color: Colors.green,
                        name: 'Recovered',
                        xAxisName: 'Cases',
                        yAxisName: 'Date',
                        dataSource: snapshot.data,
                        xValueMapper: (GlobalData graph, _) =>
                            DateFormat('MMMd').format(graph.dateTime),
                        yValueMapper: (GlobalData graph, _) =>
                            graph.totalRecovered,
                      ),
                      LineSeries(
                        color: Colors.red,
                        name: 'Deaths',
                        xAxisName: 'Cases',
                        yAxisName: 'Date',
                        dataSource: snapshot.data,
                        xValueMapper: (GlobalData graph, _) =>
                            DateFormat('MMMd').format(graph.dateTime),
                        yValueMapper: (GlobalData graph, _) =>
                            graph.totalDeaths,
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ]),
    );
  }
}
