import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/send_advice_cubit/send_advise_state.dart';
import '../../repositories/send_advise_repo.dart';

class SendAdviseCubit extends Cubit<SendAdviseState> {
  SendAdviseCubit() : super(SendAdviseInitial());
  SendAdvise sendAdvise = SendAdvise();

  sendAdviseMethod({
    String? name,
    String? description,
    String? price,
    String? documentsFile,
    String? type,
    dynamic adviserId,
    BuildContext? context,
  }) {
    try {
      emit(SendAdviseLoading());
      sendAdvise
          .sendAdvise(
              description: description,
              price: price,
              name: name,
              adviserId: adviserId,
              type: type,
              documentsFile: documentsFile)
          .then((value) {
        if (value != null) {
          emit(SendAdviseLoaded(value));
          // MyApplication.navigateToReplaceAllPrevious(
          //     context!, const CompleteAdviseScreen());
        } else {
          emit(SendAdviseError());
        }
      });
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      emit(SendAdviseError());
    }
  }
}
