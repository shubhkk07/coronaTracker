import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testdailyapp/app/repositories/data_repository.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'chart.dart';
import '../../models/graphicaldata.dart';
import '../../models/timeSeriescase.dart';

class Trend extends StatefulWidget {
  final String myCountry;
  final String myProvince;
  
  Trend({this.myCountry,this.myProvince});
  @override
  _TrendState createState() => _TrendState();
}

class _TrendState extends State<Trend> {


  List<Graph> seriesList;

  Future getData()async{
    if(widget.myCountry != null){
    seriesList = await Provider.of<DataRepository>(context,listen:false).getGraphData(country: widget.myCountry);
    return seriesList;
    }
    else{
      seriesList = await Provider.of<DataRepository>(context,listen:false).getGraphStates(myState: widget.myProvince);
      return seriesList;
    }
  }

  @override
  void initState(){ 
    super.initState();
    getData();
  }

  static List<charts.Series<TimeSeriesCases, DateTime>> _createData(List<Graph> summaryList) {
    
    List<TimeSeriesCases> confirmedData = [];
    List<TimeSeriesCases> recoveredData = [];
    List<TimeSeriesCases> deathData = [];
    
    for (var item in summaryList) {
      confirmedData.add(TimeSeriesCases(item.date, item.confirmed));
      
      recoveredData.add(TimeSeriesCases(item.date, item.recovered));
      deathData.add(TimeSeriesCases(item.date, item.deaths));
    }

    return [ 

      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Confirmed',
        displayName: 'Confirmed',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.amber),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: confirmedData,
      ),
      
      
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Recovered',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: recoveredData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Death',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: deathData,
      ),
      
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top:30.0),
        child: FutureBuilder(
          future: getData(),
          builder:  (context,snapshot){
            if(snapshot.hasData){
              return Container(
                height: MediaQuery.of(context).size.height*0.3,
                child: Chart(
                  _createData(snapshot.data),
                  animate: true,
                ),
              );
            }
            else{
              return Container(
                child: Center(child: Text('Loading...'),),
              );
            }
          }),
      );
  }
}