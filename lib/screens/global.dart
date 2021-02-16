import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testdailyapp/app/repositories/data_repository.dart';
import 'package:testdailyapp/app/repositories/endpointData.dart';
import 'package:testdailyapp/app/services/api.dart';
import 'package:testdailyapp/screens/stats.dart';

import 'package:testdailyapp/widgets/container.dart';

class Global extends StatefulWidget {
  @override
  _GlobalState createState() => _GlobalState();
}

class _GlobalState extends State<Global> {
  Endpoint endpoint;

  EndpointData _endpointData;

  @override
  void initState() {
    _updateData();
    super.initState();
  }

  Future<void> _updateData() async {
    final endpointsData =
        await Provider.of<DataRepository>(context, listen: false)
            .getAllEndPointsData();
    setState(() => _endpointData = endpointsData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: RefreshIndicator(
          onRefresh: _updateData,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Box(
                        Color(0xfffff5cc),
                        Colors.amber,
                        'Confirmed',
                        _endpointData != null
                            ? _endpointData.values[Endpoint.values[0]]
                                .toString()
                            : '...'),
                    Box(
                        Color(0xffffebeb),
                        Colors.redAccent,
                        'Deaths',
                        _endpointData != null
                            ? _endpointData.values[Endpoint.values[1]]
                                .toString()
                            : '...'),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Box(
                          Color(0xffdcffc9),
                          Colors.green,
                          'Recovered',
                          _endpointData != null
                              ? _endpointData.values[Endpoint.values[2]]
                                  .toString()
                              : '...'),
                      Box(
                          Color(0xffe6f1ff),
                          Colors.blueAccent,
                          'Active',
                          _endpointData != null
                              ? (_endpointData.values[Endpoint.values[0]] -
                                      _endpointData.values[Endpoint.values[2]])
                                  .toString()
                              : '...'),
                    ]),
               
              ]),
            ),
          ),
        ),
    );
    
  }
}
