import '../../../models/advice_screen_models/payment_list_model.dart';

abstract class PaymentListState {}

class PaymentListInitial extends PaymentListState {}

class PaymentListLoading extends PaymentListState {}

class PaymentListLoaded extends PaymentListState {
  PaymentListModel? response;

  PaymentListLoaded(this.response);
}

class PaymentListError extends PaymentListState {}
