import '../../../models/Auth_models/login_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  LoginModel? response;

  LoginLoaded(this.response);
}

class LoginError extends LoginState {}
