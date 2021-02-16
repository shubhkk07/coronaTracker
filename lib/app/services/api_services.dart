import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class APIService {
  APIService({this.api});
  final API api;

  //Getting Acess Token
  Future<String> getacessToken() async {
    final Response response = await http.post(api.tokenUri().toString(),
        headers: {'Authorization': 'Basic ${api.apiKey}'});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken =
          data['access_token']; //bkl spelling to shaii likha krr
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        '${api.tokenUri()} \n ${response.statusCode} ${response.reasonPhrase} ${response.body}');
    throw response;
  }
   

  //Get end points
  Future<int> getendPoint(
      {@required String acessToken, @required Endpoint endpoint}) async {
    final Response response = await http.get(api.endpointUri(endpoint).toString(),
        headers: {'Authorization': 'Bearer $acessToken'});
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointdata = data[0];
        final String responseJsonKey = _responseJsonKey[endpoint];
        final int result = endpointdata[responseJsonKey];
        if (result != null) {
          return result;
        }
      }
    }
    throw response;
  }
  
  //mapping endpoints with Strings
  Map<Endpoint, String> _responseJsonKey = {
    Endpoint.cases: 'cases',
    Endpoint.deaths: 'data',
    Endpoint.recovered: 'data',
  };
}
