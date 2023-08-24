import '../../../models/advice_screen_models/show_advice_model.dart';

abstract class ShowAdviceState {}

class ShowAdviceInitial extends ShowAdviceState {}

class ShowAdviceLoading extends ShowAdviceState {}

class ShowAdviceLoaded extends ShowAdviceState {
  ShowAdviceModel? response;
  ShowAdviceLoaded(this.response);
}

class ShowAdviceError extends ShowAdviceState {}
