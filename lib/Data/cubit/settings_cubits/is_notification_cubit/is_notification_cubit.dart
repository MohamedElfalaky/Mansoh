import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/repositories/settings/change_notification_repo.dart';
import 'is_notification_state.dart';

class IsNotificationCubit extends Cubit<IsNotificationState> {
  IsNotificationCubit() : super(IsNotificationInitial());
  final IsNotificationRepo _isNotificationRepo = IsNotificationRepo();

  isNotify() {
    try {
      emit(IsNotificationLoading());
      _isNotificationRepo.isNotify().then((value) {
        if (value != null) {
          emit(IsNotificationLoaded(value));
        } else {
          emit(IsNotificationError());
        }
      });
    } catch (e) {
      emit(IsNotificationError());
    }
  }
}
