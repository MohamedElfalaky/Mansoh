import '../../../models/advice_screen_models/show_advice_model.dart';

abstract class DoneAdviceState {}

class DoneAdviceInitial extends DoneAdviceState {}

class DoneAdviceLoading extends DoneAdviceState {}

class DoneAdviceLoaded extends DoneAdviceState {
  ShowAdviceModel? response;
  DoneAdviceLoaded(this.response);
}

class DoneAdviceError extends DoneAdviceState {}
