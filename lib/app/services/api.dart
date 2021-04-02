enum Endpoint { global, graph, countries, states }

class API {
  static final String host = "api.covid19api.com";

  Uri slugs(Endpoint endpoint) =>
      Uri(host: host, scheme: 'https', path: _url[endpoint]);

  static Map<Endpoint, String> _url = {
    Endpoint.global: '/summary',
    Endpoint.graph: '/total/country/',
    Endpoint.countries: '/summary',
    Endpoint.states: '/live/country/India',
  };
}
