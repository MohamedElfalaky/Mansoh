import '../../models/notification_model/notification_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  List<NotificationData>? response;

  NotificationLoaded(this.response);
}

class NotificationError extends NotificationState {}
