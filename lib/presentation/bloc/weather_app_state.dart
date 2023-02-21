// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.




part of 'weather_app_bloc.dart';

abstract class WeatherAppState extends Equatable {
  
  const WeatherAppState();
  
  @override
  List<Object?> get props => [];

}

class WeatherAppInitial extends WeatherAppState {}

class WeatherAppLoading extends WeatherAppState {}

class WeatherAppLoaded extends WeatherAppState {

  final Entity entity;

  const WeatherAppLoaded(this.entity);

  @override 
  List<Object?> get props => [entity];

}

class Err extends WeatherAppState {

  final String? message;

  const Err(this.message);

  @override 
  List<Object?> get props => [message];
  
}