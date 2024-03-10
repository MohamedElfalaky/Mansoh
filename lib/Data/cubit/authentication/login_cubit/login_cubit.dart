import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Presentation/screens/Home/home_screen.dart';
import '../../../../app/utils/my_application.dart';
import '../../../repositories/authentication/authentication.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Auth auth = Auth();

  login({
    String? phone,
    String? pass,
    BuildContext? context,
  }) {
    try {
      emit(LoginLoading());
      auth
          .login(
        phone: phone,
        pass: pass,
      )
          .then((value) {
        if (value != null) {
          emit(LoginLoaded(value));
          MyApplication.navigateToReplaceAllPrevious(
              context!, const HomeScreen());
        } else {
          emit(LoginError());
        }
      });
    } catch (e) {
      emit(LoginError());
    }
  }
}
