import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/authentication/city_repo/city_repo.dart';
import 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit() : super(CityInitial());
  CityRepo cityRepo = CityRepo();

  getCities(String id) async {
    try {
      emit(CityLoading());
      final mList = await cityRepo.getCities(id: id);
      // if (mList?.status == 1) {
      emit(CityLoaded(mList));
      // } else {
      //   emit(CityError());
      // }
    } catch (e) {
      emit(CityError());
    }
  }
}
