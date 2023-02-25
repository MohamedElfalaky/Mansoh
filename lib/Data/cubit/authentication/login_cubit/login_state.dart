

import '../../../models/user_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  UserModel? response;

  LoginLoaded(this.response);
}

class LoginError extends LoginState {}
