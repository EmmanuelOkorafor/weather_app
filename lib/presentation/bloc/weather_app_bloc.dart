// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.





import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/entity/entity.dart';
import 'package:weather_app/domain/use_cases/use_cases.dart';

import '../../weather_app_core/error/errors.dart';

part 'weather_app_event.dart';
part 'weather_app_state.dart';


// ignore: constant_identifier_names
const String NETWORK_ERROR_MESSAGE = 'No internet';
// ignore: constant_identifier_names
const String SERVER_ERROR_MESSAGE = 'Request timeout';
// ignore: constant_identifier_names
const String CACHE_ERROR_MESSAGE = 'Error';


class WeatherAppBloc extends Bloc<WeatherAppEvent, WeatherAppState> {

  final GetWeatherData getWeatherData;


  WeatherAppBloc(this.getWeatherData) : super(WeatherAppInitial()) {
    on<WeatherAppEvent>((event, emit) async {
      if (event is GetWeatherDataEvent) {
        emit(WeatherAppLoading());
        
        final data = await getWeatherData.get(Parameters(longitude: event.longitude, latitude: event.latitude));

        emit(data.fold(
          (l) => Err(mapErrorsToErrorMessage(l)), 
          (r) => WeatherAppLoaded(r)
        ));
      
      }
    });
  }


  String? mapErrorsToErrorMessage(Errors errors) {
    switch (errors.runtimeType) {
      case ServerError: 
        return  SERVER_ERROR_MESSAGE;
      case NetWorkError:
        return NETWORK_ERROR_MESSAGE;
      case CacheError:
        return CACHE_ERROR_MESSAGE;
      default:
        return null;
    }
  }

}
