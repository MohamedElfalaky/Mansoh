import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/authentication/country_repo/country_repo.dart';
import '../../../repositories/authentication/nationality_repo/nationality_repo.dart';
import 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(CountryInitial());
  CountryRepo countryRepo = CountryRepo();

  getCountries() async {
    try {
      emit(CountryLoading());
      final mList = await countryRepo.getCountries();
      // if (mList?.status == 1) {
        emit(CountryLoaded(mList));
      // } else {
      //   emit(CountryError());
      // }
    } catch (e) {
      emit(CountryError());
    }
  }

  NationalityRepo nationalityRepo = NationalityRepo();

  getNationalities() async {
    try {
      emit(NationalityLoading());
      final listData = await nationalityRepo.getNationalities();
      // if (mList?.status == 1) {
      emit(NationalityLoaded(listData));
      // } else {
      //   emit(NationalityError());
      // }
    } catch (e) {
      emit(NationalityError());
    }
  }
}
