import '../../models/advice_screen_models/show_advice_model.dart';

abstract class SendAdviseState {}

class SendAdviseInitial extends SendAdviseState {}

class SendAdviseLoading extends SendAdviseState {}

class SendAdviseLoaded extends SendAdviseState {
  ShowAdviceModel? response;

  SendAdviseLoaded(this.response);
}

class SendAdviseError extends SendAdviseState {}
