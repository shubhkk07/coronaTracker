class GlobalData{
  final int totalDeaths;
  final int totalConfirmed;
  final int totalRecovered;
  final DateTime dateTime;

  GlobalData({this.totalConfirmed,this.dateTime,this.totalDeaths,this.totalRecovered});

  factory GlobalData.fromJson(Map<String,dynamic> map){
    return GlobalData(
      totalConfirmed: map["TotalConfirmed"],
      totalDeaths: map["TotalDeaths"],
      totalRecovered: map["TotalRecovered"],
      dateTime: DateTime.parse(map["Date"])
    );
  }
}