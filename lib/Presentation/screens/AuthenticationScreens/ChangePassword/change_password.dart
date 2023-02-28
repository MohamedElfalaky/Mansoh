import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:password_text_field/password_text_field.dart';

import '../../../../app/constants.dart';
import '../../../../app/utils/lang/language_constants.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../widgets/shared.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final focusNode = FocusNode();

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
                                Text(getTranslated(context, "change_password")!,
                                    textAlign: TextAlign.right,
                                    style: Constants.headerNavigationFont),
                                const SizedBox(
                                  width: 16,
                                ),
                                const goBack(),
                              ],
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            Text(
                              getTranslated(context, "enter_new_password")!,
                              textAlign: TextAlign.end,
                              style: Constants.mainTitleRegularFont
                                  .copyWith(fontSize: 24),
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            Text(
                              getTranslated(context, "password")!,
                              textAlign: TextAlign.end,
                              style: Constants.mainTitleRegularFont,
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: PasswordTextFormField(
                                  controller: _passwordController,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return getTranslated(
                                          context, "password_required");
                                    }
                                    if (value.length < 6) {
                                      return getTranslated(
                                          context, "password_length");
                                    }
                                    return null;
                                  },
                                  decoration: Constants.setTextInputDecoration(
                                    prefixIcon: MyPrefixWidget(
                                      svgString: 'assets/images/SVGs/key.svg',
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              getTranslated(context, 'password_confirm')!,
                              textAlign: TextAlign.end,
                              style: Constants.mainTitleRegularFont,
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: PasswordTextFormField(
                                  controller: _confirmPasswordController,
                                  style: Constants.mainTitleRegularFont,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return getTranslated(
                                          context, "password_required");
                                    }
                                    if (value.length < 6) {
                                      return getTranslated(
                                          context, "password_length");
                                    }
                                    if (value != _passwordController.text) {
                                      return getTranslated(
                                          context, "password_not_match");
                                    }
                                    return null;
                                  },
                                  decoration: Constants.setTextInputDecoration(
                                    prefixIcon: MyPrefixWidget(
                                      svgString: 'assets/images/SVGs/key.svg',
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => const Home()),
                                  // );
                                },
                                child: Text(
                                  getTranslated(context, "save")!,
                                  style: Constants.mainTitleFont.copyWith(
                                      fontSize: 14, color: Colors.white),
                                ),
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
