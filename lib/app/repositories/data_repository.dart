import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:testdailyapp/app/repositories/endpointData.dart';
import 'package:testdailyapp/app/services/api.dart';
import 'package:testdailyapp/app/services/api_services.dart';

class DataRepository{
  DataRepository({@required this.apiService,this.endpoint});
  final APIService apiService;
  final Endpoint endpoint;

  String _acesstoken;

  Future<int> getEndPoint(Endpoint endpoint) async => await _getDataRefreshToken<int>(
    onGetdata: () => apiService.getendPoint(acessToken: _acesstoken, endpoint: endpoint)
  );

  Future<EndpointData> getAllEndPointsData() async => await _getDataRefreshToken(
    onGetdata: _getAllEndPoint,
  );


  Future<T> _getDataRefreshToken<T>({Future<T> Function() onGetdata}) async{
    try{
    if(_acesstoken == null){
      _acesstoken = await apiService.getacessToken();
    }
    return await onGetdata();
    }on Response catch(response){
      if(response.statusCode == 401){
        _acesstoken = await apiService.getacessToken();
        return await onGetdata();
      }
      rethrow;
    }
  }

  Future<EndpointData> _getAllEndPoint() async{
    final values = await Future.wait([
      apiService.getendPoint(acessToken: _acesstoken, endpoint: Endpoint.cases),
      apiService.getendPoint(acessToken: _acesstoken, endpoint: Endpoint.deaths),
      apiService.getendPoint(acessToken: _acesstoken, endpoint: Endpoint.recovered),      
    ]);
    return EndpointData(
      values: {
        Endpoint.cases: values[0],
        Endpoint.deaths:values[1],
        Endpoint.recovered: values[2]
        
      }
    );
  }


}