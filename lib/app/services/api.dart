enum Endpoint { global, stateGraph, countries, states }


class API {
  static final String host = "api.covid19api.com";
  final String country;
  API({this.country});

  Uri slugs(Endpoint endpoint) =>
      Uri(
      host: host, 
      scheme: 'https', 
      path: _url[endpoint],
     
      );

      Uri graphEndpoints(Endpoint endpoint,String date,String date2,[String country])=> Uri(
        host: host,
        scheme: 'https',
        path: _path[endpoint]+country??null,
        queryParameters: {
          'from': date,
          'to':date2
        }
      );



  static Map<Endpoint, String> _url = {
    Endpoint.global: '/summary',
    Endpoint.stateGraph:'/live/country/india/status/confirmed/date/',
    Endpoint.countries: '/summary',
    Endpoint.states: '/live/country/India',
  };

  Map<Endpoint, String> _path = {
    Endpoint.global: '/world',
    Endpoint.countries: '/country/',
  };
}
