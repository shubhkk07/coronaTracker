import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testdailyapp/app/repositories/data_repository.dart';
import 'package:testdailyapp/main.dart';
import 'package:testdailyapp/widgets/indicators.dart';

import '../../models/graphicaldata.dart';

class GraphicalData extends StatefulWidget {
  final String myCountry;
  final String myProvince;
  final double height;
  GraphicalData({this.myCountry, this.myProvince, @required this.height});
  @override
  _GraphicalDataState createState() => _GraphicalDataState();
}

class _GraphicalDataState extends State<GraphicalData> {
  List<Graph> graph;

  Future getGraph() async {
    if (widget.myCountry != null) {
      graph = await Provider.of<DataRepository>(context, listen: false)
          .getCountriesGraph(myCountry: widget.myCountry);
      return graph;
    } else {
      graph = await Provider.of<DataRepository>(context, listen: false)
          .getGraphStates(myState: widget.myProvince);
      return graph;
    }
  }

  @override
  void initState() {
    super.initState();
    getGraph();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10, left: 10),
          child: Text(
            'Graphical Representation',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Indicator(),
        ),
        FutureBuilder(
            future: getGraph(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: widget.height,
                  width: MediaQuery.of(context).size.width,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(interval: 5),
                    primaryYAxis: NumericAxis(
                        isVisible: false),
                    tooltipBehavior: TooltipBehavior(
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
                        xValueMapper: (Graph graph, _) =>
                            DateFormat('MMMd').format(graph.date),
                        yValueMapper: (Graph graph, _) => graph.confirmed,
                      ),
                      LineSeries(
                        color: Colors.green,
                        name: 'Recovered',
                        xAxisName: 'Cases',
                        yAxisName: 'Date',
                        dataSource: snapshot.data,
                        xValueMapper: (Graph graph, _) =>
                            DateFormat('MMMd').format(graph.date),
                        yValueMapper: (Graph graph, _) => graph.recovered,
                      ),
                      LineSeries(
                        color: Colors.red,
                        name: 'Deaths',
                        xAxisName: 'Cases',
                        yAxisName: 'Date',
                        dataSource: snapshot.data,
                        xValueMapper: (Graph graph, _) =>
                            DateFormat('MMMd').format(graph.date),
                        yValueMapper: (Graph graph, _) => graph.deaths,
                      ),
                      LineSeries(
                        color: Colors.blue,
                        animationDuration: 3,
                        name: 'Active',
                        xAxisName: 'Cases',
                        yAxisName: 'Date',
                        dataSource: snapshot.data,
                        xValueMapper: (Graph graph, _) =>
                            DateFormat('MMMd').format(graph.date),
                        yValueMapper: (Graph graph, _) => graph.active,
                      )
                    ],
                  ),
                );
              } else if(snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              else{
                return Container(
                  padding: EdgeInsets.only(top: 25),
                  child: Center(
                    child: Text('sorry there is no graphical data available'),
                  ),
                );
              }
            })
      ],
    );
  }
}
