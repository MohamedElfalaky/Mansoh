import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_state.dart';
import '../../../repositories/show_advice_repos/show_advice_repo.dart';

class ShowAdviceCubit extends Cubit<ShowAdviceState> {
  ShowAdviceCubit() : super(ShowAdviceInitial());
  ShowAdviceRepo showAdviceRepo = ShowAdviceRepo();

  getPay({required int adviceId}) async {
    try {
      emit(ShowAdviceLoading());
      final mList = await showAdviceRepo.getAdvice(adviceId: adviceId);
      emit(ShowAdviceLoaded(mList));
    } catch (e) {
      emit(ShowAdviceError());
    }
  }
}
