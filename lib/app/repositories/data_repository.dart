import 'package:flutter/foundation.dart';
import 'package:testdailyapp/app/services/api_services.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  final APIService apiService;

  //worldwide total cases
  Future<List<int>> getGlobaltotal() async {
    return await apiService.getSummary();
  }

  //retrieve all countries data
  Future getCountriesStats() async {
    return await apiService.getCountries();
  }

  //get all data of India
  Future getIndiaTotal() async {
    return await apiService.getIndia();
  }

  //get all data of India States
  Future getStates() async {
    return await apiService.getIndiaStates();
  }

  //getStatesGraph
  Future getGraphStates({String myState}) async {
    return await apiService.getStatesGraph(state: myState);
  }

  //get Countries Graph
  Future getCountriesGraph({String myCountry}) async {
    return await apiService.getDatainRange(country: myCountry);
  }

  Future getWorldGraphData()async{
    return await apiService.getWorldGraph();
  }
}
