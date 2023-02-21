// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.





import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/presentation/bloc/weather_app_bloc.dart';

import 'data/data_sources/remote/remote_data_source.dart';
import 'data/repository_contracts_extension/repository_contracts_extension.dart';
import 'domain/repository_contracts/repository_contracts.dart';
import 'domain/use_cases/use_cases.dart';

final sl = GetIt.instance;


Future<void> init() async {

  // Core

  // DataSources
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(sl()));

  // UseCases
  sl.registerLazySingleton(() => GetWeatherData(sl()));

  // Repository
  sl.registerLazySingleton<RepositoryContracts>(() => RepositoryContractsImpl(sl(), sl(), sl()));

  // Bloc
  sl.registerLazySingleton(() => WeatherAppBloc(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => HttpClient());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}