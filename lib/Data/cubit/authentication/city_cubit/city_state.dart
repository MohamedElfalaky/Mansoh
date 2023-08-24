import '../../../models/Auth_models/city_model.dart';

abstract class CityState {}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  CityModel? response;

  CityLoaded(this.response);
}

class CityError extends CityState {}
