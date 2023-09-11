
import '../../../models/orders_models/orders_filter_model.dart';

abstract class OrdersFiltersState {}

class OrdersFiltersInitial extends OrdersFiltersState {}

class OrdersFiltersLoading extends OrdersFiltersState {}

class OrdersFiltersLoaded extends OrdersFiltersState {
  OrdersFiltersModel? response;

  OrdersFiltersLoaded(this.response);
}

class OrdersFiltersError extends OrdersFiltersState {}


