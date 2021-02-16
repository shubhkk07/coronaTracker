import 'dart:convert';

import 'package:http/http.dart' as http;

class DataRepository2{

  Future fetchData() async{
    var url = 'https://api.covidindiatracker.com/total.json';
    var response = await http.get(url);
    if(response.statusCode == 200){
      final List<dynamic> data = json.decode(response.body);  
      print(response.body);
      
      
    }
    else{
      return 'try again...';
    }
  }
}