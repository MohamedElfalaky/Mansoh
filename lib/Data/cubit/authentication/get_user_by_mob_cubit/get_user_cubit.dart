import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Presentation/screens/Home/Home.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../repositories/authentication/get_user_by_mobile.dart';
import 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial());
  GetUserByMobile getUserByMobile = GetUserByMobile();

  getMobMethod({
    String? mobile,
    BuildContext? context,
  }) {
    try {
      emit(GetUserLoading());
      getUserByMobile
          .getUser(
        mobile: mobile,
      )
          .then((value) {
        if (value != null) {
          emit(GetUserLoaded(value));
          MyApplication.navigateToReplaceAllPrevious(context!,  Home(currentIndex: 0,));
        } else {
          emit(GetUserError());
        }
      });
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      emit(GetUserError());
    }
  }
}
