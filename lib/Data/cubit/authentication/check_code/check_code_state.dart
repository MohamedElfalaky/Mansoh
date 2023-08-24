import '../../../models/Auth_models/check_code_model.dart';

abstract class CheckCodeState {}

class CheckCodeInitial extends CheckCodeState {}

class CheckCodeLoading extends CheckCodeState {}

class CheckCodeLoaded extends CheckCodeState {
  CheckCodeModel? response;

  CheckCodeLoaded(this.response);
}

class CheckCodeError extends CheckCodeState {}
