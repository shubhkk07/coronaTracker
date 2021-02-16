import 'package:flutter/foundation.dart';
import 'package:testdailyapp/app/services/api_keys.dart';

enum Endpoint {cases, deaths, recovered}

class API {
  API({@required this.apiKey});
  final String apiKey;

  static final String host = "ncov2019-admin.firebaseapp.com";

  factory API.sandbox() => API(apiKey: APIkeys.ncovSandboxkey);
  
  //acessToken Url
  Uri tokenUri() => Uri(host: host, scheme: 'https', path: 'token');

  //endpoint Url's
  Uri endpointUri(Endpoint endpoint)=> Uri(
    host: host,
    scheme: 'https',
    path: _path[endpoint],
  );

  
  static Map<Endpoint, String> _path = {
    Endpoint.cases: 'cases',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
  };
}
