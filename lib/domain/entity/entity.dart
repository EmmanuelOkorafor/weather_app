// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.





import 'package:equatable/equatable.dart';

class Entity extends Equatable {

  final Map<String, dynamic>? cord;
  final List<Map<String, dynamic>>? weather;
  final String? base;
  final Map<String, dynamic>? main;
  final String? visibility;
  final Map<String, dynamic>? wind;
  final Map<String, dynamic>? rain;
  final Map<String, dynamic>? clouds;
  final String? dt;
  final Map<String, dynamic>? sys;
  final String? timezone;
  final String? id;
  final String? name;
  final String? cod;

  const Entity({this.cord, this.weather, this.base, this.main, this.visibility, this.wind, this.rain, this.clouds, this.dt, this.sys, this.timezone, this.id, this.name, this.cod});

  @override 
  List<Object?> get props => [cord, weather, base, main, visibility, wind, rain, clouds, dt, sys, timezone, id, name, cod];
  
}