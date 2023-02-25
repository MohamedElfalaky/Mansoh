import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/Style/Icons.dart';
import '../../../../app/constants.dart';
import '../../../../app/utils/lang/language_constants.dart';
import '../../../../app/utils/myApplication.dart';
import '../shared.dart';

class RegistrationInfoScreen extends StatefulWidget {
  const RegistrationInfoScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationInfoScreen> createState() => _RegistrationInfoScreenState();
}

class _RegistrationInfoScreenState extends State<RegistrationInfoScreen> {
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
                            const goBack(),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: SvgPicture.asset(
                            logoo,
                            width: 100,
                            height: 100,
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
                                      width: 6,
                                      height: 6,
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
                          mainAxisAlignment: MainAxisAlignment.end,
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
                          height: 32,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              getTranslated(context, "register")!,
                              style: Constants.mainTitleFont.copyWith(
                                color: Colors.white,
                              ),
                            ),
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
