import '../../../models/advice_screen_models/pay_advice_model.dart';

abstract class PayAdviceState {}

class PayAdviceInitial extends PayAdviceState {}

class PayAdviceLoading extends PayAdviceState {}

class PayAdviceLoaded extends PayAdviceState {
  PayAdviceModel? response;
  PayAdviceLoaded(this.response);
}

class PayAdviceError extends PayAdviceState {}
