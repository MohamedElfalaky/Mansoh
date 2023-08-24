import '../../../models/Auth_models/register_model.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  RegisterModel? response;

  RegisterLoaded(this.response);
}

class RegisterError extends RegisterState {}
