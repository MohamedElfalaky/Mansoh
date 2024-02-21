import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/authentication/country_repo/country_repo.dart';
import 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(CountryInitial());
  CountryRepo countryRepo = CountryRepo();

  getCountries() async {
    try {
      emit(CountryLoading());
      final mList = await countryRepo.getCountries();
        emit(CountryLoaded(mList));

    } catch (e) {
      emit(CountryError());
    }
  }


}
