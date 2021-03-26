class IndiaStats {
  final List<Users> users;
  IndiaStats({this.users});

  factory IndiaStats.fromJson(List<dynamic> parseJson) {
    return IndiaStats(users: parseJson.map((e) => Users.fromJson(e)).toList());
  }
}

class Users {
  String province;
  int confirmed;
  int recovered;
  int deaths;
  int active;
  int newconfirmed;
  int newrecovered;
  int newdeaths;

  Users(
      {this.confirmed,
      this.province,
      this.deaths,
      this.recovered,
      this.active,
      this.newconfirmed,
      this.newdeaths,
      this.newrecovered});

  factory Users.fromJson(Map<String, dynamic> map) {
    return Users(
        active: map["Active"],
        confirmed: map['Confirmed'],
        deaths: map['Deaths'],
        province: map['Province'],
        recovered: map['Recovered'],
        newconfirmed: map['NewConfirmed'],
        newdeaths: map['NewDeaths'],
        newrecovered: map['NewRecovered'],

        );
  }
}
