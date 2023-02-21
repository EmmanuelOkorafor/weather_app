// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.





import 'dart:convert';


import '../../../weather_app_core/error/exceptions.dart';
import '../../../weather_app_core/read_write/read_write.dart';
import '../../models/model.dart';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';



abstract class RemoteDataSource {
  Future<Model> getWeatherData(double? longitude, double? latitude);
}


class RemoteDataSourceImpl implements RemoteDataSource {

  final http.Client client;

  RemoteDataSourceImpl(this.client);
  
 
  @override
  Future<Model> getWeatherData(double? longitude, double? latitude) async {
    final _client = RetryClient(client);
    return await _telemetry(_client,  'lat', latitude, 'lon', longitude);
  }




  Future<Model> _telemetry(RetryClient client, String fieldNameOne, Object? fieldValueOne, String fieldNameTwo, Object? fieldValueTwo) async {
    try {
      final response = await client.post(
        Uri.https(
          'api.openweathermap.org', 
          '/data/2.5/post/weather',
          {
            fieldNameOne: fieldValueOne,
            fieldNameTwo: fieldValueTwo,
            'appid': 'Api key'
          }
        ),
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        write(response.body, '${fieldValueOne.toString()}${fieldValueTwo.toString()}');
        return Model.fromJson(json.decode(response.body));
        
      } else {
        throw ServerException();

      }

    } finally {
      client.close();

    }   

  }



}