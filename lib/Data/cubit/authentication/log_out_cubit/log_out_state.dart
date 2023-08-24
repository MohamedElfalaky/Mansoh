import '../../../models/Auth_models/log_out_model.dart';

abstract class LogOutState {}

class LogOutInitial extends LogOutState {}

class LogOutLoading extends LogOutState {}

class LogOutLoaded extends LogOutState {
  LogOutModel? response;

  LogOutLoaded(this.response);
}

class LogOutError extends LogOutState {}
