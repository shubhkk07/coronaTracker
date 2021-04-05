import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:testdailyapp/models/graphicaldata.dart';
import 'package:testdailyapp/models/world.dart';
import 'api.dart';
import 'package:intl/intl.dart';

class APIService {
  APIService({this.api});
  final API api;

  int index;
  final List<dynamic> finalList = [];

  DateTime date = DateTime.now().subtract(Duration(days: 1));

  String getDate(int days) {
    String finaldate = DateFormat('yyyy-MM-dd')
            .format((DateTime.now().subtract(Duration(days: days)))) +
        'T00:00:00Z';
    print(finaldate);
    return finaldate;
  }

//get the data globally
  Future<List<int>> getSummary() async {
    final Response response =
        await http.get(api.slugs(Endpoint.global).toString());
    if (response.statusCode == 200) {
      final Map<String, dynamic> map = json.decode(response.body);
      if (map.isNotEmpty) {
        final Map<String, dynamic> data = map["Global"];
        final List<int> values = [];
        values.addAll([
          data["TotalConfirmed"],
          data["TotalDeaths"],
          data["TotalRecovered"],
          data["NewConfirmed"],
          data["NewDeaths"],
          data["NewRecovered"],
        ]);
        return values;
      }
    }
    throw response;
  }

//get all countries Data
  Future getCountries() async {
    final Response response =
        await http.get(api.slugs(Endpoint.countries).toString());
    if (response.statusCode == 200) {
      final Map<String, dynamic> map = json.decode(response.body);
      if (map.isNotEmpty) {
        final List<dynamic> list = await map["Countries"];
        list.sort(
            (a, b) => (b["TotalConfirmed"]).compareTo(a["TotalConfirmed"]));
        return list;
      }
    }
    throw response;
  }

//data of India on 2nd Tab
  Future getIndia() async {
    final Response response =
        await http.get(api.slugs(Endpoint.global).toString());
    if (response.statusCode == 200) {
      final Map<String, dynamic> map = json.decode(response.body);
      if (map.isNotEmpty) {
        final List<dynamic> list = await map["Countries"];
        return list.singleWhere((element) => element["Country"] == "India");
      }
    }
    throw response;
  }

//All states data of India
  Future getIndiaStates() async {
    final Response response =
        await http.get(api.slugs(Endpoint.states).toString());
    if (response.statusCode == 200) {
      final List<dynamic> list = await json.decode(response.body);
      if (list.isNotEmpty) {
        final List<dynamic> _list = list
            .where((element) =>
                element["Date"] == getDate(0)??element["Date"] == getDate(1))
            .toList();
        _list.sort((a, b) => (b["Confirmed"]).compareTo(a["Confirmed"]));
        return _list;
      }
    }
    throw response;
  }

//accurate graphical state data
  Future getStatesGraph({String state}) async {
    final Response response = await http.get(
        api.slugs(Endpoint.stateGraph).toString() + getDate(35) + 'T00:00:00Z');
    if (response.statusCode == 200) {
      if (response.statusCode == 200) {
        final List<dynamic> list = json.decode(response.body);
        if (list.isNotEmpty) {
          final List<Graph> graphList = list
              .where((element) => element["Province"] == state)
              .map((e) => Graph.fromJsom(e))
              .toList();
          return graphList;
        }
      }
      throw response;
    }
  }

//graphical data representation of all countries
  Future getDatainRange({String country}) async {
    final Response response = await http.get(api.graphEndpoints(
        Endpoint.countries, getDate(35), getDate(1), country));
    if (response.statusCode == 200) {
      final List<Graph> list = (json.decode(response.body) as List)
          .map((item) => Graph.fromJsom(item))
          .toList();
      print(list.length);
      return list;
    }
    throw response;
  }

// 'https://api.covid19api.com/world?from=2021-03-03T00:00:00Z&to=2021-04-04T00:00:00Z'
  Future getWorldGraph() async {
    final Response response = await http
        .get(api.graphEndpoints(Endpoint.global, getDate(35), getDate(1), ''));
    if (response.statusCode == 200) {
      final List<dynamic> list = json.decode(response.body);
      if (list.isNotEmpty) {
        list.sort((a, b) => (a['Date']).compareTo(b['Date']));
        List<GlobalData> glist =
            list.map((item) => GlobalData.fromJson(item)).toList();
        return glist;
      }
    }
    throw response;
  }
}
