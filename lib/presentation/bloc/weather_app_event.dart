// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.




part of 'weather_app_bloc.dart';

abstract class WeatherAppEvent extends Equatable {

  const WeatherAppEvent({List props = const <dynamic>[]});

  @override
  List<Object?> get props => [];

}


class GetWeatherDataEvent extends WeatherAppEvent {

  final double? latitude;
  final double? longitude;

  const GetWeatherDataEvent(this.latitude, this.longitude);

  @override 
  List<Object?> get props => [latitude, longitude];

}

