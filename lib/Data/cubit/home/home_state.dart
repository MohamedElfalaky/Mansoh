import '../../models/home_models/home_slider_model.dart';

abstract class HomeState {}

class HomeSliderInitial extends HomeState {}

class HomeSliderLoading extends HomeState {}

class HomeSliderLoaded extends HomeState {
  HomeSlider? response;

  HomeSliderLoaded(this.response);
}

class HomeSliderError extends HomeState {}


