import '../../../models/Auth_models/country_model.dart';
import '../../../models/Auth_models/nationality_model.dart';

abstract class CountryState {}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class CountryLoaded extends CountryState {
  CountryModel? response;

  CountryLoaded(this.response);
}

class CountryError extends CountryState {}

class NationalityInitial extends CountryState {}

class NationalityLoading extends CountryState {}

class NationalityLoaded extends CountryState {
  NationalityModel? response;

  NationalityLoaded(this.response);
}

class NationalityError extends CountryState {}
