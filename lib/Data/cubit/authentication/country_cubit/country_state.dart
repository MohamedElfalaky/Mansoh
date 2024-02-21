
import '../../../models/countries_and_nationalities_model.dart';

abstract class CountryState {}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class CountryLoaded extends CountryState {
  CountriesAndNationalitiesModel? response;

  CountryLoaded(this.response);
}

class CountryError extends CountryState {}
