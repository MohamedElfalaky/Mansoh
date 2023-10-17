import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:password_text_field/password_text_field.dart';
import '../../../../app/Style/Icons.dart';
import '../../../../app/constants.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../widgets/shared.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Padding(
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
                      const  Back(
                          header: "create_new_account",
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: SvgPicture.asset(
                            logoo,
                            width: 24,
                            height: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                         "nickname".tr,
                          textAlign: TextAlign.right,
                          style: Constants.secondaryTitleRegularFont,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              decoration: Constants.setTextInputDecoration(
                                  hintText:"user_hint".tr,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                        width: 60,
                                        height: 60,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          shape: BoxShape.rectangle,
                                          color: Color(0xffEEEEEE),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/SVGs/user1.svg',
                                              ),
                                              SvgPicture.asset(
                                                'assets/images/SVGs/user2.svg',
                                              ),
                                            ],
                                          ),
                                        )),
                                  )),
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                         "email".tr,
                          textAlign: TextAlign.right,
                          style: Constants.secondaryTitleRegularFont,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: Constants.secondaryTitleRegularFont,
                              decoration: Constants.setTextInputDecoration(
                                hintText:"email_hint".tr,
                                prefixIcon: MyPrefixWidget(
                                  svgString: 'assets/images/SVGs/email.svg',
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return  "email_required".tr;
                                }
                                if (!EmailValidator.validate(value)) {
                                  return  "invalid_email".tr;
                                }
                                return null;
                              },
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                         "password".tr,
                          textAlign: TextAlign.right,
                          style: Constants.secondaryTitleRegularFont,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: PasswordTextFormField(
                            style: Constants.secondaryTitleRegularFont,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return  "password_required".tr;
                              }
                              if (value.length < 6) {
                                return  "password_length".tr;
                              }
                              return null;
                            },
                            decoration: Constants.setTextInputDecoration(
                              prefixIcon: MyPrefixWidget(
                                svgString: 'assets/images/SVGs/key.svg',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                             "register".tr,
                              style: Constants.secondaryTitleFont.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
