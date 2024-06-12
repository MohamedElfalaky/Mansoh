import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/send_advice_cubit/send_advise_state.dart';
import 'package:nasooh/Data/models/advice_screen_models/show_advice_model.dart';

import '../../repositories/send_advise_repo.dart';

class SendAdviseCubit extends Cubit<SendAdviseState> {
  SendAdviseCubit() : super(SendAdviseInitial());
  SendAdvise sendAdvise = SendAdvise();

  void emitInitial() {
    emit(SendAdviseInitial());
  }

  sendAdviseMethod({
    String? name,
    String? description,
    String? price,
    File? file,
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
              type: file != null ? _getFileType(file.path) : null,
              file: file)
          .then((ShowAdviceModel? value) {
        if (value != null) {
          emit(SendAdviseLoaded(value));
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

  String? _getFileType(String filePath) {
    var extension = filePath.split(".").last;
    if (["jpg", "jpeg", "png"].contains(extension)) return "image";
    if (["mp3", "m4a"].contains(extension)) return "audio";
    if (extension == "mp4") return "video";
    return null;
  }
}
