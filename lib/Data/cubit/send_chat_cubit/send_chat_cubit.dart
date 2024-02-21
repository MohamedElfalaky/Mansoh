import 'package:nasooh/Data/cubit/send_chat_cubit/send_chat_state.dart';
import 'package:nasooh/Data/repositories/send_chat_repo.dart';

import '../../../app/utils/exports.dart';

class SendChatCubit extends Cubit<SendChatState> {
  SendChatCubit() : super(SendChatInitial());
  SendChatRepo sendChatRepo = SendChatRepo();

  sendChatFunction({
    required String msg,
    required String adviceId,
    String? filee,
    String? typee,
  }) async {
    try {
      emit(SendChatLoading());
      sendChatRepo
          .sendChat(msg: msg, adviceId: adviceId, file: filee, type: typee)
          .then((value) {
        if (value == true) {
          debugPrint('send chat done');
          emit(SendChatLoaded());
        } else {
          emit(SendChatError());
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(SendChatError());
    }
  }
}
