import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:password_text_field/password_text_field.dart';

import '../../../../app/constants.dart';
import '../../../../app/utils/lang/language_constants.dart';
import '../../../../app/utils/myApplication.dart';
import '../shared.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
                child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/images/SVGs/logo.svg',
                        width: 24,
                        height: 24,
                      ),
                      Text(
                        getTranslated(context, "phone_number")!,
                        textAlign: TextAlign.right,
                        style: Constants.mainTitleRegularFont,
                      ),
                      IntlPhoneField(
                        controller: _phoneController,
                        showDropdownIcon: true,
                        dropdownIcon: const Icon(Icons.arrow_drop_down,
                            color: Colors.transparent),
                        style: Constants.subtitleFont1,
                        dropdownIconPosition: IconPosition.leading,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          errorStyle: Constants.subtitleFont1.copyWith(
                            color: Colors.red,
                          ),
                          suffixIcon: MyPrefixWidget(
                              svgString: "assets/images/SVGs/phone.svg"),
                          // labelText: 'Phone Number',
                          border: const OutlineInputBorder(
                            gapPadding: 0,
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'SA',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                        invalidNumberMessage:
                            getTranslated(context, "invalid_number")!,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        getTranslated(context, "password")!,
                        textAlign: TextAlign.right,
                        style: Constants.mainTitleRegularFont,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: PasswordTextFormField(
                          style: Constants.subtitleFont1,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return getTranslated(
                                  context, "password_required")!;
                            }
                            if (value.length < 6) {
                              return getTranslated(context, "password_length")!;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            errorStyle: Constants.subtitleFont1.copyWith(
                              color: Colors.red,
                            ),
                            prefixIcon: MyPrefixWidget(
                                svgString: "assets/images/SVGs/key.svg"),
                            // labelText: 'Password',
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            getTranslated(context, "login")!,
                            style: Constants.secondaryTitleFont.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(getTranslated(context, "forgot_password")!,
                            textAlign: TextAlign.center,
                            style: Constants.subtitleFont),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: Text(getTranslated(context, "no_account")!,
                              textAlign: TextAlign.center,
                              style: Constants.subtitleRegularFontHint)),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: (() {}),
                            child: Text(
                              getTranslated(context, "create_new_account")!,
                              style: Constants.mainTitleFont,
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Center(
                              child: Text(
                                getTranslated(context, "login_guest")!,
                                style: Constants.secondaryTitleRegularFont
                                    .copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            )),
          ),
        ),
      ),
    );
  }
}
