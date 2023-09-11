import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegisterationInfoScreen/registeration-info-screen.dart';
import 'package:nasooh/Presentation/screens/Home/HomeScreen.dart';
import 'package:nasooh/app/utils/lang/language_constants.dart';
import '../../../../Presentation/screens/AuthenticationScreens/LoginScreen/check_mob_screen.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../repositories/authentication/check_code_repo.dart';
import '../get_user_by_mob_cubit/get_user_cubit.dart';
import '../get_user_by_mob_cubit/get_user_state.dart';
import 'check_code_state.dart';

class CheckCodeCubit extends Cubit<CheckCodeState> {
  CheckCodeCubit() : super(CheckCodeInitial());
  CheckCodeRepo checkCodeRepo = CheckCodeRepo();

  checkCodeMethod({
    String? mobile,
    String? code,
    BuildContext? context,
  }) {
    try {
      emit(CheckCodeLoading());
      checkCodeRepo.checkCode(mobile: mobile, code: code).then((value) {
        if (value != null) {
          emit(CheckCodeLoaded(value));
          if (value.data!.login == 0) {
            MyApplication.navigateTo(context!, const RegistrationInfoScreen());
          } else if (value.data!.login == 1) {
            _showAlertDialog(context!);
          }
        } else {
          emit(CheckCodeError());
        }
      });
    } catch (e) {
      emit(CheckCodeError());
    }
  }
}

Future<void> _showAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return BlocBuilder<GetUserCubit, GetUserState>(
          builder: (context, state) => AlertDialog(
                // <-- SEE HERE
                // title: const Text('Cancel booking'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(getTranslated(context, "dialog tile")!),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(getTranslated(context, "No")!),
                    onPressed: () {
                      MyApplication.navigateTo(context, const CheckMobScreen());
                    },
                  ),
                  state is GetUserLoading
                      ? const Center(child: CircularProgressIndicator())
                      : TextButton(
                          child: Text(getTranslated(context, "Yes")!),
                          onPressed: () {
                            context.read<GetUserCubit>().getMobMethod(
                                  context: context,
                                  mobile: sendPhone,
                                );
                            // Navigator.pop(context);
                          },
                        ),
                ],
              ));
    },
  );
}