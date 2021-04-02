
class Graph {
  final DateTime date;
  final int confirmed;
  final int deaths;
  final int recovered;
  final int active;

  Graph({this.confirmed, this.date,this.active,this.deaths,this.recovered});

  factory Graph.fromJsom(Map<String, dynamic> map) {
    return Graph(
      confirmed: map["Confirmed"],
      date: DateTime.parse(map["Date"]),
      deaths: map['Deaths'],
      recovered: map['Recovered'],
      active: map["Active"]
    );
  }
}
