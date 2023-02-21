// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.




import 'package:weather_app/domain/entity/entity.dart';


class Model extends Entity {
  
  const Model({Map<String, dynamic>? cord, List<Map<String, dynamic>>? weather, String? base, Map<String, dynamic>? main, String? visibility, Map<String, dynamic>? wind, Map<String, dynamic>? rain, Map<String, dynamic>? clouds, String? dt, Map<String, dynamic>? sys, String? timezone, String? id, String? name, String? cod}) : super(cord: cord, weather: weather, base: base, main: main, visibility: visibility, wind: wind, rain: rain, clouds: clouds, dt: dt, sys: sys, timezone: timezone, id: id, name: name, cod: cod);

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      cord: json['cord'],
      weather: json['weather'],
      base: json['base'],
      main: json['main'],
      visibility: json['visibility'],
      wind: json['wind'],
      sys: json['sys'],
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod']
    );
  }

}