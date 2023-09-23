import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_state.dart';
import '../../../repositories/show_advice_repos/show_advice_repo.dart';

class ShowAdviceCubit extends Cubit<ShowAdviceState> {
  ShowAdviceCubit() : super(ShowAdviceInitial());
  ShowAdviceRepo showAdviceRepo = ShowAdviceRepo();

  Future getAdviceFunction({required int adviceId}) async {
    try {
      // emit(ShowAdviceLoading());
      showAdviceRepo.getAdvice(adviceId: adviceId).then((value) {
        if (value != null) {
          emit(ShowAdviceLoaded(value));
        } else {
          emit(ShowAdviceError());
        }
      });
    } catch (e) {
      emit(ShowAdviceError());
    }
  }
}
