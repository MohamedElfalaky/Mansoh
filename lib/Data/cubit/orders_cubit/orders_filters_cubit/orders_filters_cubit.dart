import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/orders_repos/orders_filters_repo.dart';
import 'orders_filters_state.dart';

class OrdersFiltersCubit extends Cubit<OrdersFiltersState> {
  OrdersFiltersCubit() : super(OrdersFiltersInitial());
  OrdersFiltersRepo ordersStatus = OrdersFiltersRepo();

  getOrdersFilters({required String id}) async {
    try {
      emit(OrdersFiltersLoading());
      final mList = await ordersStatus.getStatus( id: id);
      mList?.data?.map((e) {
        print('mmmm ${e.adviser?.category?.length}');
        return e.adviser?.category?.map((e) => print('category name ${e.name}')).toList();
      }).toList();
      emit(OrdersFiltersLoaded(mList));
    } catch (e) {
      emit(OrdersFiltersError());
    }
  }
}
