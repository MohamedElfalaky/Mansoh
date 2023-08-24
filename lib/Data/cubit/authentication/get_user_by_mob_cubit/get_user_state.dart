
import 'package:nasooh/Data/models/Auth_models/register_model.dart';

abstract class GetUserState {}

class GetUserInitial extends GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserLoaded extends GetUserState {
  RegisterModel? response;

  GetUserLoaded(this.response);
}

class GetUserError extends GetUserState {}
