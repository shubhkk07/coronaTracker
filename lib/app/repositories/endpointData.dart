import 'package:flutter/foundation.dart';
import 'package:testdailyapp/app/services/api.dart';

class EndpointData {
  final Map<Endpoint, int> values;

  EndpointData({@required this.values});

  int get cases => values[Endpoint.cases];
  int get deaths => values[Endpoint.deaths];
  int get recovered => values[Endpoint.recovered];
  
}
