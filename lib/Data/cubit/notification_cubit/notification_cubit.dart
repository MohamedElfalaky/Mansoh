import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/notification_repo/notification_repo.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  NotificationRepo notificationRepo = NotificationRepo();

  getDataNotification() async {
    try {
      emit(NotificationLoading());
      final mList = await (notificationRepo.getData());
      emit(NotificationLoaded(mList));
    } catch (e) {
      emit(NotificationError());
    }
  }
}
