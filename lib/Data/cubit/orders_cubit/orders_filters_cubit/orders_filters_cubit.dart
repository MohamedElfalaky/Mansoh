import '../../../../app/utils/exports.dart';
import '../../../repositories/orders_repos/orders_filters_repo.dart';
import 'orders_filters_state.dart';

class OrdersFiltersCubit extends Cubit<OrdersFiltersState> {
  OrdersFiltersCubit() : super(OrdersFiltersInitial());
  OrdersFiltersRepo ordersStatus = OrdersFiltersRepo();

  getOrdersFilters({required String id}) async {
    try {
      emit(OrdersFiltersLoading());
      final ordersList = await ordersStatus.getStatus(id: id);
      ordersList?.data?.map((e) {
        debugPrint('ORDERS FILTER ');
        debugPrint(e.adviser?.fullName);
        debugPrint(e.description);
      }).toList();

      if (ordersList?.data?.isEmpty == true) {
        emit(OrdersFiltersEmpty());
      } else {
        emit(OrdersFiltersLoaded(ordersList));
      }
    } catch (e) {
      emit(OrdersFiltersError());
    }
  }
}
