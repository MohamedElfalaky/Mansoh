import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/payment_list_cubit/payment_list_state.dart';

import '../../../repositories/show_advice_repos/payment_list_repo.dart';

class PaymentListCubit extends Cubit<PaymentListState> {
  PaymentListCubit() : super(PaymentListInitial());
  PaymentListRepo paymentListRepo = PaymentListRepo();

  getPay() async {
    try {
      emit(PaymentListLoading());
      final mList = await paymentListRepo.getPay();
      emit(PaymentListLoaded(mList));
    } catch (e) {
      emit(PaymentListError());
    }
  }
}
