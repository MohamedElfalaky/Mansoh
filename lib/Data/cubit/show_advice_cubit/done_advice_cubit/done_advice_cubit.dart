import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Presentation/screens/rate_screen/rate_screen.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../repositories/show_advice_repos/done_advice_repo.dart';
import 'done_advice_state.dart';

class DoneAdviceCubit extends Cubit<DoneAdviceState> {
  DoneAdviceCubit() : super(DoneAdviceInitial());
  DoneAdviceRepo doneAdviceRepo = DoneAdviceRepo();

  done({required BuildContext context, required int adviceId}) async {
    try {
      emit(DoneAdviceLoading());
      doneAdviceRepo.doneAdvice(adviceId: adviceId).then((value) {
        if (value != null) {
          emit(DoneAdviceLoaded(value));
        } else {
          emit(DoneAdviceError());
        }
      });
    } catch (e) {
      emit(DoneAdviceError());
    }
  }
}
