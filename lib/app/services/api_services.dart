import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'package:intl/intl.dart';

class APIService {
  APIService({this.api});
  final API api;

  int index;

  DateTime date = DateTime.now().subtract(Duration(days: 1));

  String finaldate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()) + 'T00:00:00Z';

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

//Both functions can be called from here states and countries data, statistics of all together
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

  Future getIndiaTotal() async {
    final Response response =
        await http.get(api.slugs(Endpoint.india).toString());
    if (response.statusCode == 200) {
      final List<dynamic> list = json.decode(response.body);
      if (list.isNotEmpty) {
        final Map<String, dynamic> data = list.last;
        return data;
      }
    }
    throw response;
  }

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
                element["Date"] ==
                DateFormat('yyyy-MM-dd')
                        .format((DateTime.now().subtract(Duration(days: 1)))) +
                    'T00:00:00Z')
            .toList();
        _list.sort((a, b) => (b["Confirmed"]).compareTo(a["Confirmed"]));
        return _list;
      }
    }
    throw response;
  }
}
