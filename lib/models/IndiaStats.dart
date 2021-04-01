class IndiaStats {
  final List<User> users;
  IndiaStats({this.users});

  factory IndiaStats.fromJson(List<dynamic> parseJson) {
    return IndiaStats(users: parseJson.map((e) => User.fromJson(e)).toList());
  }
}

class User {
  String province;
  int confirmed;
  int recovered;
  int deaths;
  int active;

  User({
    this.confirmed,
    this.province,
    this.deaths,
    this.recovered,
    this.active,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      active: map["Active"],
      confirmed: map['Confirmed'],
      deaths: map['Deaths'],
      province: map['Province'],
      recovered: map['Recovered'],
    );
  }
}
