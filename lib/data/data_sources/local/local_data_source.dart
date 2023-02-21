// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.





import '../../../weather_app_core/error/exceptions.dart';
import '../../../weather_app_core/read_write/read_write.dart';
import '../../models/model.dart';



abstract class LocalDataSource {
  Future<Model> getWeatherData(String? concatenatedCoordinates);
}


class LocalDataSourceImpl implements LocalDataSource {

  LocalDataSourceImpl();
  
  @override
  Future<Model> getWeatherData(String? concatenatedCoordinates) async {
    return await _telemetry(concatenatedCoordinates!);
  }
  
  Future<Model> _telemetry(String fileName) async {
    try {
      return read(fileName);
    
    } on CacheException {
      throw CacheException();
  
    }
  }

}