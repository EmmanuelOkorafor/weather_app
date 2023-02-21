// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.







import 'package:weather_app/weather_app_core/error/errors.dart';

import 'package:weather_app/domain/entity/entity.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repository_contracts/repository_contracts.dart';
import '../../weather_app_core/error/exceptions.dart';
import '../../weather_app_core/platform/network.dart';
import '../data_sources/local/local_data_source.dart';
import '../data_sources/remote/remote_data_source.dart';
import '../models/model.dart';


// ignore: camel_case_types
typedef getData = Future<Model> Function();

// ignore: camel_case_types
// typedef _getWeatherData = Future<Model> Function();

class RepositoryContractsImpl implements RepositoryContracts {

  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final Network network;

  RepositoryContractsImpl(this.remoteDataSource, this.localDataSource, this.network);

  late String fileName; 

  @override
  Future<Either<Errors, Entity>> getWeatherData(double? longitude, double? latitude) async {
    return await _getPostData(() {fileName = '${longitude.toString()}${latitude.toString()}'; return remoteDataSource.getWeatherData(longitude, latitude);});
  }


  Future<Either<Errors, Entity>> _getPostData(getData getData) async {

    if (await network.isConnected) {
      try {
        final remoteWeatherData = await getData();
        return Right(remoteWeatherData);

      } on ServerException {
        return const Left(ServerError());
      
      }
    } else {
      try {
        
        final localWeatherData = await localDataSource.getWeatherData(fileName);
        return Right(localWeatherData);
      
      } on CacheException {
        return const Left(CacheError());
      }
    }
  }
  

}