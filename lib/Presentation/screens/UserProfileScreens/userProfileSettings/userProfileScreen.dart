import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../app/utils/lang/language_constants.dart';
import '../../../../app/constants.dart';
import '../../../widgets/shared.dart';
import 'widgets/userInfoCard.dart';
import 'widgets/userInfoMenu.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
                // physics: const NeverScrollableScrollPhysics(),
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Back(
                  header: "personal_profile",
                ),
                const SizedBox(
                  height: 10,
                ),
                const UserInfoCard(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildMenuItem(
                      SettingsMenuItems.all[index],
                    ),
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey[300],
                      height: 1,
                      thickness: 1,
                    ),
                    itemCount: SettingsMenuItems.all.length,
                  ),
                ),
                ListTile(
                  minLeadingWidth: 0,
                  onTap: () {
                    // todo logout
                  },
                  title: Text(
                    getTranslated(context, "signout")!,
                    style: Constants.mainTitleFont,
                  ),
                  leading: const Icon(
                    Icons.logout,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        // todo logout
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/SVGs/share.svg",
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              getTranslated(context, "share_app")!,
                              style: Constants.subtitleFont1.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(getTranslated(context, "profile_message")!,
                      style: Constants.subtitleRegularFontHint.copyWith(
                        color: Colors.grey[700],
                      )),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
