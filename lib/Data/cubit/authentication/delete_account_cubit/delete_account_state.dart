import '../../../models/Auth_models/log_out_model.dart';

abstract class DeleteAccountState {}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountLoaded extends DeleteAccountState {
  LogOutModel? response;

  DeleteAccountLoaded(this.response);
}

class LogOutError extends DeleteAccountState {}
