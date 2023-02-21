// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.



import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../weather_app_core/error/errors.dart';
import '../../weather_app_core/usecases/usecase.dart';
import '../entity/entity.dart';
import '../repository_contracts/repository_contracts.dart';


class GetWeatherData extends UseCases<Entity, Parameters> {

  final RepositoryContracts repositoryContracts;

  GetWeatherData(this.repositoryContracts);

  @override
  Future<Either<Errors, Entity>> get(Parameters parameters) async {
    return await repositoryContracts.getWeatherData(parameters.longitude, parameters.latitude);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
  
}



class Parameters extends Equatable {

  final double? longitude;
  final double? latitude;

  const Parameters({this.longitude, this.latitude});

  @override 
  List<Object?> get props => [longitude, latitude];

}