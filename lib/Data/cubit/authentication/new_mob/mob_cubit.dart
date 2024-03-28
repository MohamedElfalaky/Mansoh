import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Presentation/screens/AuthenticationScreens/RegisterationPinCodeConfirm/check_code.dart';
import '../../../../app/utils/my_application.dart';
import '../../../repositories/authentication/mob_repo.dart';
import 'mob_state.dart';

class MobCubit extends Cubit<MobState> {
  MobCubit() : super(MobInitial());
  MobRepo mobRepo = MobRepo();

  checkMobMethod({
    String? phone,
    BuildContext? context,
  }) {
    try {
      emit(MobLoading());
      mobRepo
          .checkMob(
        phone: phone,
      )
          .then((value) {
        if (value != null) {
          emit(MobLoaded(value));
          MyApplication.navigateTo(context!, const CheckCodeScreen());
        } else {
          emit(MobError());
        }
      });
    } catch (e) {
      emit(MobError());
    }
  }
}
