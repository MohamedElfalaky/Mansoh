import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../../Data/cubit/authentication/check_code/check_code_cubit.dart';
import '../../../../Data/cubit/authentication/check_code/check_code_state.dart';
import '../../../../app/Style/sizes.dart';
import '../../../../app/constants.dart';
import '../../../../app/utils/my_application.dart';
import '../../../widgets/my_button.dart';
import '../../../widgets/shared.dart';
import '../LoginScreen/check_mob_screen.dart';

class CheckCodeScreen extends StatefulWidget {
  const CheckCodeScreen({Key? key}) : super(key: key);

  @override
  State<CheckCodeScreen> createState() => _CheckCodeScreenState();
}

class _CheckCodeScreenState extends State<CheckCodeScreen> {
  final String phoneNumber = sendPhone;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();

  late CountdownTimerController timerController;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
  late FocusNode myFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode = FocusNode();

    timerController = CountdownTimerController(endTime: endTime, onEnd: () {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // appBar: AppBar(
          //     // leadingWidth: 70,
          //     title: Text(getTranslated(context, "enter_pin".tr),
          //     leading: const GoBack()),
          body: SingleChildScrollView(
            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const GoBack(),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                       "enter_pin".tr,
                        textAlign: TextAlign.right,
                        style:
                        Constants.headerNavigationFont),
                  ],
                ),
                const SizedBox(height: 16,),
                Form(
                  key: _formKey,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(
                      top: 16,
                      right: 16,
                      left: 16,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: BlocBuilder<CheckCodeCubit, CheckCodeState>(
                        builder: (context, state) => Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height(context) * 0.035,
                                ),
                                // Lottie.asset("assets/images/Jsons/4.json", height: 160),
                                Text(
                                  "pin_from_phone".tr,
                                  style: const TextStyle(
                                      fontFamily: Constants.mainFont, fontSize: 24),
                                ),
                                Text(
                                  "pin_sent".tr,
                                  style: Constants.subtitleFont1,
                                ),
                                Text(
                                  phoneNumber,
                                  style: Constants.secondaryTitleRegularFont,
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: MyApplication.hightClc(context, 30),
                                        bottom: MyApplication.hightClc(context, 32)),
                                    child: Pinput(
                                      errorTextStyle: Constants.subtitleFont
                                          .copyWith(color: Colors.red),
                                      pinputAutovalidateMode:
                                          PinputAutovalidateMode.onSubmit,
                                      showCursor: true,
                                      controller: _pinController,
                                      focusNode: myFocusNode,
                                      defaultPinTheme: Constants.defaultPinTheme,
                                      focusedPinTheme: Constants.focusedPinTheme,
                                      errorPinTheme: Constants.errorPinTheme,
                                        autofocus:true,
                                      // errorBuilder: (errorText, pin) {},
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length != 4 ||
                                            !RegExp(r'^[0-9]+$').hasMatch(value)) {
                                          return "يرجى ادخال رمز تحقق صحيح";
                                        }
                                        return null;
                                      },
                                      onCompleted: (pin) {
                                        // print(pin);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height(context) * 0.03,
                                ),
                                // Column(
                                //          children: [
                                state is CheckCodeLoading
                                    ? const Center(
                                        child: CircularProgressIndicator.adaptive())
                                    : SizedBox(
                                        width: double.infinity,
                                        height: 48,
                                        child: MyButton(
                                          isBold: true,
                                          txt: "login".tr,
                                          onPressedHandler: () {
                                            if (_formKey.currentState!.validate()) {
                                              context
                                                  .read<CheckCodeCubit>()
                                                  .checkCodeMethod(
                                                    context: context,
                                                    code: _pinController.text,
                                                    mobile: sendPhone,
                                                    // widgetScreen:
                                                    //     const HomeScreen()
                                                  );
                                            }
                                          },
                                        )),
                                // SizedBox(
                                //   height: height(context) * 0.05,
                                // ),
                                // SizedBox(
                                //   width: double.infinity,
                                //   height: 48,
                                //   child: MyButton(
                                //     isBold: true,
                                //     txt: getTranslated(
                                //         context, "register first time"),
                                //     onPressedHandler: () {
                                //       if (_formKey.currentState!
                                //           .validate()) {
                                //         context
                                //             .read<CheckCodeCubit>()
                                //             .checkCodeMethod(
                                //                 context: context,
                                //                 code: _pinController.text,
                                //                 mobile: "+9665252589",
                                //                 widgetScreen:
                                //                     const RegistrationInfoScreen());
                                //       }
                                //     },
                                //   ),
                                // ),
                                //   ],
                                // ),

                                SizedBox(
                                  height: height(context) * 0.06,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "will_be_resent".tr,
                                      style: Constants.subtitleRegularFont,
                                    ),
                                    CountdownTimer(
                                      controller: timerController,
                                      widgetBuilder: (_, time) {
                                        if (time == null) {
                                          return Text(
                                            '00:00',
                                            style: Constants.subtitleRegularFont
                                                .copyWith(
                                                    color:
                                                        Constants.primaryAppColor),
                                          );
                                        }
                                        return Text(
                                          '${time.min ?? "00"}:${time.sec}',
                                          style: Constants.subtitleRegularFont
                                              .copyWith(
                                                  color: Constants.primaryAppColor),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: height(context) * 0.12),
                                  child: Text(
                                      "didnt_receive".tr,
                                      style: Constants.subtitleFont1),
                                ),
                                Text(
                                  "resend_code".tr,
                                  style: Constants.mainTitleFont,
                                ),
                              ],
                            )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
