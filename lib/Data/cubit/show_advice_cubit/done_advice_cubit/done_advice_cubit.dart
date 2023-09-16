import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/show_advice_repos/done_advice_repo.dart';
import 'done_advice_state.dart';

class DoneAdviceCubit extends Cubit<DoneAdviceState> {
  DoneAdviceCubit() : super(DoneAdviceInitial());
  DoneAdviceRepo doneAdviceRepo = DoneAdviceRepo();

  done({required int adviceId}) async {
    try {
      emit(DoneAdviceLoading());
      final mList = await doneAdviceRepo.doneAdvice(adviceId: adviceId);
      emit(DoneAdviceLoaded(mList));
    } catch (e) {
      emit(DoneAdviceError());
    }
  }
}

