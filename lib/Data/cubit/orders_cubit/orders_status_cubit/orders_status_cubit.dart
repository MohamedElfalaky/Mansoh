import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/orders_repos/orders_status_repo.dart';
import 'orders_status_state.dart';

class OrdersStatusCubit extends Cubit<OrdersStatusState> {
  OrdersStatusCubit() : super(OrdersStatusInitial());
  OrdersStatusRepo ordersStatus = OrdersStatusRepo();

  getOrdersStatus() async {
    try {
      emit(OrdersStatusLoading());
      final mList = await ordersStatus.getStatus();
      emit(OrdersStatusLoaded(mList));
    } catch (e) {
      emit(OrdersStatusError());
    }
  }
}
