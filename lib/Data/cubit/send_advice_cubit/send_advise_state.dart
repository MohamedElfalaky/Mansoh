import '../../models/send_advise_model.dart';

abstract class SendAdviseState {}

class SendAdviseInitial extends SendAdviseState {}

class SendAdviseLoading extends SendAdviseState {}

class SendAdviseLoaded extends SendAdviseState {
  SendAdviseModel? response;

  SendAdviseLoaded(this.response);
}

class SendAdviseError extends SendAdviseState {}
