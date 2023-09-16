import '../../../models/advice_screen_models/show_advice_model.dart';

abstract class PayAdviceState {}

class PayAdviceInitial extends PayAdviceState {}

class PayAdviceLoading extends PayAdviceState {}

class PayAdviceLoaded extends PayAdviceState {
  ShowAdviceModel? response;
  PayAdviceLoaded(this.response);
}

class PayAdviceError extends PayAdviceState {}
