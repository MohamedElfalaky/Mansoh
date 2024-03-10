import '../../../models/orders_models/orders_status_model.dart';

abstract class OrdersStatusState {}

class OrdersStatusInitial extends OrdersStatusState {}

class OrdersStatusLoading extends OrdersStatusState {}

class OrdersStatusLoaded extends OrdersStatusState {
  OrdersStatusModel? response;

  OrdersStatusLoaded(this.response);
}

class OrdersStatusError extends OrdersStatusState {}

class OrdersStatusEmpty extends OrdersStatusState {}
