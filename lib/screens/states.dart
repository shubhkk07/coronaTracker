import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testdailyapp/app/repositories/data_repository.dart';
import 'package:testdailyapp/models/users.dart';

class States extends StatefulWidget {
  @override
  _StatesState createState() => _StatesState();
}

class _StatesState extends State<States> {
  Map<String, dynamic> stats;
  @override
  void initState() {
    super.initState();
    updateIndiaData();
  }

  Future updateIndiaData() async {
    var data =
        await Provider.of<DataRepository>(context, listen: false)
            .getIndiaTotal();
    setState(() {
      stats = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: [
        stats != null?Text(stats["TotalConfirmed"].toString()):Text('...')
      ],),
    );
  }
}
