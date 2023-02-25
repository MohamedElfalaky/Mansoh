import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

import '../../../../app/constants.dart';
import '../../../../app/utils/lang/language_constants.dart';
import '../../../../app/utils/myApplication.dart';
import '../shared.dart';

class RegistrationPinCodeConfirm extends StatefulWidget {
  const RegistrationPinCodeConfirm({super.key});

  @override
  State<RegistrationPinCodeConfirm> createState() =>
      _RegistrationPinCodeConfirmState();
}

class _RegistrationPinCodeConfirmState
    extends State<RegistrationPinCodeConfirm> {
  final TextEditingController _pinEditingController = TextEditingController();
  final focusNode = FocusNode();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(234, 239, 243, 1),
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Constants.whiteAppColor,
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(getTranslated(context, "enter_pin")!,
                                    textAlign: TextAlign.right,
                                    style: Constants.headerNavigationFont),
                                const SizedBox(
                                  width: 16,
                                ),
                                const goBack()
                              ],
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            Center(
                              child: Text(
                                getTranslated(context, "pin_from_phone")!,
                                textAlign: TextAlign.center,
                                style: Constants.mainTitleRegularFont
                                    .copyWith(fontSize: 24),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                getTranslated(context, "pin_sent")!,
                                style: Constants.secondaryTitleRegularFont
                                    .copyWith(color: const Color(0xff5c5e6b)),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Center(
                              child: Pinput(
                                controller: _pinEditingController,
                                focusNode: focusNode,
                                length: 4,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                onChanged: (String value) {},
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme:
                                    defaultPinTheme.copyDecorationWith(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          114, 178, 238, 1)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                submittedPinTheme:
                                    defaultPinTheme.copyDecorationWith(
                                  color: const Color.fromRGBO(234, 239, 243, 1),
                                ),
                                validator: (s) {
                                  return s == '2222'
                                      ? null
                                      : 'Pin is incorrect';
                                },
                                pinputAutovalidateMode:
                                    PinputAutovalidateMode.onSubmit,
                                showCursor: true,
                                onCompleted: (pin) => print(pin),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants.primaryAppColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(getTranslated(context, "next")!,
                                    style: Constants.mainTitleRegularFont
                                        .copyWith(
                                            color: Constants.whiteAppColor,
                                            fontSize: 16)),
                              ),
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "1:30",
                                  textAlign: TextAlign.right,
                                  style: Constants.subtitleRegularFont,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  getTranslated(context, "will_be_resent")!,
                                  textAlign: TextAlign.right,
                                  style: Constants.subtitleRegularFont,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getTranslated(context, "didnt_receive")!,
                                    textAlign: TextAlign.right,
                                    style: Constants.subtitleRegularFontHint,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const LoginScreen()),
                                      // );
                                    },
                                    child: Text(
                                      getTranslated(context, "resend_code")!,
                                      textAlign: TextAlign.right,
                                      style: Constants.mainTitleRegularFont,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  SvgPicture.asset(
                    'assets/images/SVGs/screen layout.svg',
                    width: 100,
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
