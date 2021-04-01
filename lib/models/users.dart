class Stat {
  final List<Users> users;
  Stat({this.users});

  factory Stat.fromJson(List<dynamic> parseJson) {
    return Stat(users: parseJson.map((e) => Users.fromJson(e)).toList());
  }
}

class Users {
  String country;
  int confirmed;
  int recovered;
  int deaths;
  int newConfirmed;
  int newRecovered;
  int newDeaths;

  Users(
      {this.confirmed,
      this.country,
      this.deaths,
      this.recovered,
      this.newConfirmed,
      this.newDeaths,
      this.newRecovered});

  factory Users.fromJson(Map<String, dynamic> map) {
    return Users(
        confirmed: map['TotalConfirmed'],
        deaths: map['TotalDeaths'],
        country: map['Country'],
        recovered: map['TotalRecovered'],
        newConfirmed: map['NewConfirmed'],
        newDeaths: map['NewDeaths'],
        newRecovered: map['NewRecovered'],
);
  }
}
