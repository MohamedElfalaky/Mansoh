import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/send_chat_cubit/send_chat_state.dart';
import 'package:nasooh/Data/repositories/send_chat_repo.dart';

class SendChatCubit extends Cubit<SendChatState> {
  SendChatCubit() : super(SendChatInitial());
  SendChatRepo sendChatRepo = SendChatRepo();

  void emitChatInitial() {
    emit(SendChatInitial());
  }

  sendChatFunction({
    required String msg,
    required String adviceId,
    File? file,
  }) async {
    try {
      emit(SendChatLoading());
      sendChatRepo
          .sendChat(
          msg: msg,
          adviceId: adviceId,
          file: file,
          typee: file != null ? _getFileType(file.path) : null
      )
          .then((value) {
        if (value == true) {
          emit(SendChatLoaded());
        } else {
          emit(SendChatError());
        }
      });
    } catch (e) {
      emit(SendChatError());
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
