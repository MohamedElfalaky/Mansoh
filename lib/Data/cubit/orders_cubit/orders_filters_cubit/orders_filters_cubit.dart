import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/orders_repos/orders_filters_repo.dart';
import 'orders_filters_state.dart';

class OrdersFiltersCubit extends Cubit<OrdersFiltersState> {
  OrdersFiltersCubit() : super(OrdersFiltersInitial());
  OrdersFiltersRepo ordersStatus = OrdersFiltersRepo();

  getOrdersFilters(int id) async {
    try {
      emit(OrdersFiltersLoading());
      final mList = await ordersStatus.getStatus( id);
      emit(OrdersFiltersLoaded(mList));
    } catch (e) {
      emit(OrdersFiltersError());
    }
  }
}
