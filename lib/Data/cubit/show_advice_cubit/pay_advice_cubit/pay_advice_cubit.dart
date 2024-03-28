import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/pay_advice_cubit/pay_advice_state.dart';

import '../../../repositories/show_advice_repos/pay_advice_repo.dart';

class PayAdviceCubit extends Cubit<PayAdviceState> {
  PayAdviceCubit() : super(PayAdviceInitial());
  PayAdviceRepo showAdviceRepo = PayAdviceRepo();

  getPay({required int adviceId, required int paymentId}) async {
    try {
      emit(PayAdviceLoading());
      final mList = await showAdviceRepo.payAdvice(
          adviceId: adviceId, paymentId: paymentId);
      emit(PayAdviceLoaded(mList));
    } catch (e) {
      emit(PayAdviceError());
    }
  }
}
