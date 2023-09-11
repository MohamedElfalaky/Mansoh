import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/Style/sizes.dart';

import '../../../../app/utils/myApplication.dart';
import '../../../app/Style/Icons.dart';
import '../../../app/constants.dart';
import '../../../app/global.dart';
import '../../../app/utils/lang/language_constants.dart';
import '../../../app/utils/sharedPreferenceClass.dart';
import '../../../main.dart';
import '../Home/Home.dart';
import '../UserProfileScreens/UserProfileEdit/widgets/shared.dart';
import '../UserProfileScreens/userProfileSettings/userProfileScreen.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  int groupValue = 1;

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
            appBar: customAppBar(
                context: context, txt: getTranslated(context, "settings")!),
            floatingActionButton: buildSaveButton(label: "save"),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          languageIcon,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("تغيير اللغة ",
                            style: Constants.mainTitleFont),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Radio(
                              activeColor: Constants.primaryAppColor,
                              value: 'ar',
                              onChanged: (val) async {
                                print("selected lang is ${selectedLang}");
                                Locale _locale = await setLocale("ar");
                                // oldLang = "en";
                                sharedPrefs.setLanguage("ar");
                                print(sharedPrefs.getLanguage());
                                setState(() {
                                  headers = {
                                    'Accept': 'application/json',
                                    'lang': "ar"
                                  };
                                  selectedLang = "ar";
                                  MyApp.setLocale(context, _locale);
                                });
                              },
                              groupValue: selectedLang,
                            ),
                            const Text("العربية",
                                style: Constants.mainTitleFont),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                activeColor: Constants.primaryAppColor,
                                value: 'en',
                                groupValue: selectedLang,
                                onChanged: (val) async {
                                  print("selected lang is ${selectedLang}");
                                  Locale _locale = await setLocale("en");
                                  sharedPrefs.setLanguage("en");
                                  print(sharedPrefs.getLanguage());
                                  setState(() {
                                    headers = {
                                      'Accept': 'application/json',
                                      'lang': "en"
                                    };
                                    selectedLang = "en";

                                    MyApp.setLocale(context, _locale);
                                  });
                                }),
                            const Text("English",
                                style: Constants.mainTitleFont),
                          ],
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      leading: SvgPicture.asset(
                        notificationIcon,
                        height: 20,
                        width: 20,
                      ),
                      title: Text("الأشعارات",
                          style: Constants.mainTitleFont.copyWith(
                            letterSpacing: 0,
                            wordSpacing: 0,
                          )),
                      trailing: Switch(
                        activeColor: Constants.primaryAppColor,
                        value: true,
                        onChanged: (value) {},
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      leading: SvgPicture.asset(deleteUser),
                      title: Text("حذف الحساب ",
                          style: Constants.mainTitleFont.copyWith(
                              letterSpacing: 0,
                              wordSpacing: 0,
                              color: Colors.red)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
