import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../app/Style/Icons.dart';
import '../../../app/constants.dart';
import '../../../app/global.dart';
import '../../../app/utils/Language/get_language.dart';
import '../UserProfileScreens/UserProfileEdit/widgets/shared.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: customAppBar(
              context: context, txt:  "settings".tr),
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
                       Text("change Language".tr,
                          style: Constants.mainTitleFont),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ChangeLangItem(),
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
                    title: Text("Notification".tr,
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
                    title: Text("Delete Account".tr,
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
    );
  }
}
