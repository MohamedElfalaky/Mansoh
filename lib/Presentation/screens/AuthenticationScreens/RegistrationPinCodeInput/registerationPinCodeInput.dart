import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../app/constants.dart';
import '../../../../app/utils/lang/language_constants.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../widgets/shared.dart';

class RegistrationPinCodeInput extends StatefulWidget {
  const RegistrationPinCodeInput({super.key});

  @override
  State<RegistrationPinCodeInput> createState() =>
      _RegistrationPinCodeInputState();
}

class _RegistrationPinCodeInputState extends State<RegistrationPinCodeInput> {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(getTranslated(context, "create_new_account")!,
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
                        Text(
                          "${getTranslated(context, "confirm_account_pin")!}\n${getTranslated(context, "verification_code")!}",
                          textAlign: TextAlign.right,
                          style: Constants.mainTitleRegularFont
                              .copyWith(height: 1.5),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: const Divider(
                              height: 32,
                              thickness: 1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          getTranslated(context, "phone_number")!,
                          textAlign: TextAlign.right,
                          style: Constants.mainTitleRegularFont,
                        ),
                        IntlPhoneField(
                          dropdownIcon: const Icon(Icons.arrow_drop_down,
                              color: Colors.transparent),
                          dropdownIconPosition: IconPosition.leading,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  color: Constants.prefixContainerColor,
                                  child: const Icon(Icons.phone_android)),
                            ),
                            // labelText: 'Phone Number',
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'SA',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                getTranslated(context, "terms_conditions")!,
                                textAlign: TextAlign.right,
                                style: Constants.mainTitleRegularFont
                                    .copyWith(color: Constants.primaryAppColor),
                              ),
                            ),
                            Text(
                              getTranslated(context, "agree_to")!,
                              textAlign: TextAlign.right,
                              style: Constants.mainTitleRegularFont,
                            ),
                            Checkbox(
                              value: true,
                              onChanged: (value) {},
                              activeColor: Constants.primaryAppColor,
                            ),
                          ],
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
                                style: Constants.mainTitleRegularFont.copyWith(
                                    color: Constants.whiteAppColor,
                                    fontSize: 16)),
                          ),
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                getTranslated(context, "have_account")!,
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
                                  getTranslated(context, "login")!,
                                  textAlign: TextAlign.right,
                                  style: Constants.mainTitleRegularFont
                                      .copyWith(
                                          color: Constants.primaryAppColor),
                                ),
                              ),
                            ],
                          ),
                        ),
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
