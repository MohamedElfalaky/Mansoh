import 'package:flutter/material.dart';

import '../AuthenticationScreens/shared.dart';
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
                  height: 20,
                ),
                const UserInfoCard(),
                const SizedBox(
                  height: 20,
                ),
                ...SettingsMenuItems.all.map(buildMenuItem).toList(),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
