// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.





import 'package:shared_preferences/shared_preferences.dart';

import '../error/exceptions.dart';

const String keyOne = "keyOne";
const String keyTwo = "keyTwo";
const String keyThree = "keyThree";

abstract class SaveUserPreferredCity {
  Future<List<String>?> getUserPreferredCities();
  Future<void> setUserPreferredCities(List<String> cities);

  // Future<List<String>?> getUserStateAndCountry();
  // Future<void> setUserStateAndCountry(List<String> sc);

  // Future<List<String>?> getUserCoordinates();
  // Future<void> setUserCoordinates(List<String> coordinates);
}

class SaveUserPreferredCityImpl implements SaveUserPreferredCity {

  final SharedPreferences sharedPreferences;

  const SaveUserPreferredCityImpl(this.sharedPreferences);
  
  @override
  Future<List<String>?> getUserPreferredCities() async {
    try {
      return sharedPreferences.getStringList(keyOne);
    
    } on Exception {
      throw CacheException();
    
    }
  }
  
  @override
  Future<void> setUserPreferredCities(List<String> cities) async {
    sharedPreferences.setStringList(keyOne, cities);
  }
  
}