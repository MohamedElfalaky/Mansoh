import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Presentation/screens/Home/home.dart';
import '../../../../app/utils/my_application.dart';
import '../../../repositories/authentication/register_repo.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Register register = Register();

  registerMethod({
    String? email,
    String? fullName,
    String? mobile,
    String? promoCode,
    String? countryId,
    String? cityId,
    dynamic gender,
    String? nationalityId,
    String? avatar,
    BuildContext? context,
  }) {
    try {
      emit(RegisterLoading());
      register
          .register(
        avatar: avatar,
        promoCode:promoCode,
        email: email,
        fullName: fullName,
        gender: gender,
        mobile: mobile,
        nationalityId: nationalityId,
        cityId: cityId,
        countryId: countryId,
      )
          .then((value) {
        if (value != null) {
          emit(RegisterLoaded(value));
          MyApplication.navigateToReplaceAllPrevious(
              context!, const HomeLayout(currentIndex: 0));
        } else {
          emit(RegisterError());
        }
      });
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      emit(RegisterError());
    }
  }
}
