// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.




import 'package:dartz/dartz.dart';

import '../../weather_app_core/error/errors.dart';
import '../entity/entity.dart';

abstract class RepositoryContracts {
  Future<Either<Errors, Entity>> getWeatherData(double? longitude, double? latitude);
}
