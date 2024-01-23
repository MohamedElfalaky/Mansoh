import '../../../models/Auth_models/login_model.dart';

abstract class IsNotificationState {}

class IsNotificationInitial extends IsNotificationState {}

class IsNotificationLoading extends IsNotificationState {}

class IsNotificationLoaded extends IsNotificationState {
  LoginModel? response;

  IsNotificationLoaded(this.response);
}

class IsNotificationError extends IsNotificationState {}
