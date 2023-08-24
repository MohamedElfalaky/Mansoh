import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/home_repos/home_slider_repo.dart';
import 'home_state.dart';

class HomeSliderCubit extends Cubit<HomeState> {
  HomeSliderCubit() : super(HomeSliderInitial());
  HomeSliderRepo homeSliderData = HomeSliderRepo();

  getDataHomeSlider() async {
    try {
      emit(HomeSliderLoading());
      final mList = await homeSliderData.getSliders();
      emit(HomeSliderLoaded(mList));
    } catch (e) {
      emit(HomeSliderError());
    }
  }
}
