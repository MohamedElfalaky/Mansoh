import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';

import '../../../../app/utils/myApplication.dart';
import '../../../app/constants.dart';
import '../UserProfileScreens/UserProfileEdit/widgets/shared.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
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
                    const SizedBox(height: 40),
                    Back(header: "wallet"),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/SVGs/translate.svg",
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
                                  value: 1,
                                  groupValue: 1,
                                  onChanged: (value) {},
                                ),
                                const Text("العربية",
                                    style: Constants.mainTitleFont),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  activeColor: Constants.primaryAppColor,
                                  value: 2,
                                  groupValue: 1,
                                  onChanged: (value) {},
                                ),
                                const Text("English",
                                    style: Constants.mainTitleFont),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      leading: SvgPicture.asset(
                        "assets/images/SVGs/bill.svg",
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
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      leading: const Icon(
                        Icons.supervised_user_circle,
                        color: Constants.primaryAppColor,
                      ),
                      title: Text("حذف الحساب ",
                          style: Constants.mainTitleFont.copyWith(
                            letterSpacing: 0,
                            wordSpacing: 0,
                          )),
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
