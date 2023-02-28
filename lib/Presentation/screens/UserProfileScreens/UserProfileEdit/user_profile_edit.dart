import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:password_text_field/password_text_field.dart';

import '../../../../app/constants.dart';
import '../../../../app/utils/lang/language_constants.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../widgets/shared.dart';
import 'widgets/shared.dart';

class UserProfileEdit extends StatefulWidget {
  const UserProfileEdit({Key? key}) : super(key: key);

  @override
  State<UserProfileEdit> createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileEdit> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        },
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: buildSaveButton("save"),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Back(header: "update_profile"),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            getTranslated(context, "personal_info")!,
                            textAlign: TextAlign.right,
                            style: Constants.mainTitleFont,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          getTranslated(context, "full_name")!,
                          textAlign: TextAlign.right,
                          style: Constants.mainTitleRegularFont,
                        ),
                        const SizedBox(height: 8),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              decoration: Constants.setTextInputDecoration(
                                  hintText:
                                      getTranslated(context, "full_name")!,
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
                          getTranslated(context, "email")!,
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
                                hintText: getTranslated(context, "email_hint"),
                                prefixIcon: MyPrefixWidget(
                                  svgString: 'assets/images/SVGs/email.svg',
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return getTranslated(
                                      context, "email_required");
                                }
                                if (!EmailValidator.validate(value)) {
                                  return getTranslated(
                                      context, "invalid_email");
                                }
                                return null;
                              },
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          getTranslated(context, "password")!,
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
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: MySeparator(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            getTranslated(context, "additional_info")!,
                            textAlign: TextAlign.right,
                            style: Constants.mainTitleFont,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          getTranslated(context, "nationality_optional")!,
                          textAlign: TextAlign.right,
                          style: Constants.secondaryTitleRegularFont,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: DropDownTextField(
                              textStyle: Constants.secondaryTitleRegularFont,
                              enableSearch: true,
                              initialValue: getTranslated(context, "saudi"),
                              dropDownList: [
                                DropDownValueModel(
                                    name: getTranslated(context, "saudi")!,
                                    value: "سعودي"),
                              ],
                              textFieldDecoration:
                                  Constants.setTextInputDecoration(
                                prefixIcon: MyPrefixWidget(),
                              ),
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          getTranslated(context, "resident_country")!,
                          textAlign: TextAlign.right,
                          style: Constants.secondaryTitleRegularFont,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: DropDownTextField(
                              textStyle: Constants.secondaryTitleRegularFont,
                              enableSearch: true,
                              initialValue: getTranslated(context, "alsaudia"),
                              dropDownList: [
                                DropDownValueModel(
                                    name: getTranslated(context, "alsaudia")!,
                                    value: "السعودية"),
                              ],
                              textFieldDecoration:
                                  Constants.setTextInputDecoration(
                                prefixIcon: MyPrefixWidget(
                                  svgString: "assets/images/SVGs/country.svg",
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(getTranslated(context, "resident_city")!,
                            textAlign: TextAlign.right,
                            style: Constants.secondaryTitleRegularFont),
                        const SizedBox(
                          height: 8,
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: DropDownTextField(
                              textStyle: Constants.secondaryTitleRegularFont,
                              enableSearch: true,
                              initialValue: getTranslated(context, "alryadh"),
                              dropDownList: [
                                DropDownValueModel(
                                    name: getTranslated(context, "alryadh")!,
                                    value: "الرياض"),
                              ],
                              textFieldDecoration:
                                  Constants.setTextInputDecoration(
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
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/SVGs/city1.svg',
                                                ),
                                                SvgPicture.asset(
                                                  'assets/images/SVGs/city2.svg',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: SvgPicture.asset(
                                              'assets/images/SVGs/city3.svg',
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(getTranslated(context, "gender")!,
                            textAlign: TextAlign.right,
                            style: Constants.secondaryTitleRegularFont),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(getTranslated(context, "female")!,
                                style: Constants.secondaryTitleRegularFont),
                            Radio(
                                value: "",
                                groupValue: const {},
                                onChanged: (value) {}),
                            const SizedBox(
                              width: 48,
                            ),
                            Text(
                              getTranslated(context, "male")!,
                              style: Constants.secondaryTitleRegularFont,
                            ),
                            Radio(
                                value: "",
                                groupValue: const {},
                                onChanged: (value) {}),
                          ],
                        ),
                        const SizedBox(
                          height: 64,
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
