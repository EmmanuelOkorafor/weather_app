// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.





import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:weather_app/data/data_sources/local/local_data_source.dart';

import '../../../weather_app_core/error/exceptions.dart';
import '../../data/models/model.dart';




Future<Model> read(String fileName) async {

  final directory = await getApplicationDocumentsDirectory();
  final fileExits = await directory.exists();

  if(fileExits) {
    try {
      final file = File('{$directory.path}/weather_app_local_data.json');
      final contents = await file.readAsString();

      final json = jsonDecode(contents);
      return Model.fromJson(json[fileName]);
    
    } catch (e) {
      throw CacheException();

    }
    
  } throw CacheException();

}

void write(String body, String fileName) async {
  /// Summary
  /// 
  /// We want to uphold the integrity of our weather app with and without
  /// internet connection.
  /// To do that we have to store our retrieved weather data for every successful
  /// request we make to the end point locally(on the user's machine for persistence).
  /// 
  /// We want to organize our locally stored data in such a way that data for all 
  /// 15 cities are stored in a single json to enable us easily access it later by
  /// key-value pair matching.
  /// 
  /// For successful request made, we'll open our local data,
  /// 

  final Map<String, dynamic> data = {fileName: json.decode(body)};

  final stringifyJson = jsonEncode(data);

  final directory = await getApplicationDocumentsDirectory();
  final file = File('{$directory.path}/weather_app_local_data.json');

  file.writeAsString(stringifyJson);

}














Future<Map<String, dynamic>> readCities() async {

  final directory = await getApplicationDocumentsDirectory();
  final fileExits = await directory.exists();

  if(fileExits) {
    try {
      final file = File('{$directory.path}/weather_app_local_city_data.json');
      final contents = await file.readAsString();

      final json = jsonDecode(contents);
      return json;
    
    } catch (e) {
      throw CacheException();

    }
    
  } throw CacheException();

}


Future<List<String>> readCityKeys() async {
  final directory = await getApplicationDocumentsDirectory();
  final fileExits = await directory.exists();

  

  if(fileExits) {
    try {
      final file = File('{$directory.path}/weather_app_local_city_keys.txt');
      final contents = await file.readAsLines().then((value) => value);
      return contents;
    
    } catch (e) {
      throw CacheException();

    }
    
  } throw CacheException();

}






void writeCities(Map<String, dynamic> body, String fileName) async {

  final Map<String, dynamic> data = {fileName: body};

  final stringifyJson = jsonEncode(data);

  final directory = await getApplicationDocumentsDirectory();
  final file = File('{$directory.path}/weather_app_local_city_data.json');

  file.writeAsString(stringifyJson);
}


void writeCityKeys(String key) async {

  final directory = await getApplicationDocumentsDirectory();
  final file = File('{$directory.path}/weather_app_local_city_keys.txt');

  file.writeAsString('$key' + '\n');

}







void deleteCity(String fileName) async {

  final directory = await getApplicationDocumentsDirectory();
  final fileExits = await directory.exists();
  final Map<String, dynamic> tempData = {};

  if(fileExits) {
    try {
      final file = File('{$directory.path}/weather_app_cites.json');
      final contents = await file.readAsString();

      File('{$directory.path}/weather_app_local_city_keys.txt').readAsLines().then((value) => value.removeWhere((element) => element == fileName));


      final json = jsonDecode(contents);
      tempData.addAll(json);
      tempData[fileName].clear();
      tempData[fileName] = "";

      

      final stringifyJson = jsonEncode(tempData);
      file.writeAsString(stringifyJson);
    
    } catch (e) {
      throw CacheException();

    }
    
  } throw CacheException();

}


// Future<Model> switcher(String fileName, LocalDataSource localDataSource) {
  // switch(fileName) {
    // case 'Lagos':
      // return localDataSource.getWeatherDataForLagos();
// 
    // case 'Kano':
      // return localDataSource.getWeatherDataForKano();
// 
    // case 'Ibadan':
      // return localDataSource.getWeatherDataForIbadan();
// 
    // case 'Onitsha':
      // return localDataSource.getWeatherDataForOnitsha();
// 
    // case 'Owerri':
      // return localDataSource.getWeatherDataForOwerri();
// 
    // case 'Abuja':
      // return localDataSource.getWeatherDataForAbuja();
// 
    // case 'Maiduguri':
      // return localDataSource.getWeatherDataForMaiduguri();
// 
    // case 'BeninCity':
      // return localDataSource.getWeatherDataForBeninCity();
// 
    // case 'Ikare':
      // return localDataSource.getWeatherDataForIkare();
// 
    // case 'Ogbomoso':
      // return localDataSource.getWeatherDataForOgbomoso();
// 
    // case 'PortHarcourt':
      // return localDataSource.getWeatherDataForPortHarcourt();
// 
    // case 'Abeokuta':
      // return localDataSource.getWeatherDataForAbeokuta();
// 
    // case 'Jos':
      // return localDataSource.getWeatherDataForJos();
// 
    // case 'Ilorin':
      // return localDataSource.getWeatherDataForIlorin);
// 
    // case 'Warri':
      // return localDataSource.getWeatherDataForWarri();
// 
    // default:
      // return localDataSource.getWeatherDataForLagos();
  // }


