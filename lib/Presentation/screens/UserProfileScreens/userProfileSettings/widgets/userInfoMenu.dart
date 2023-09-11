import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/UserSettingsScreen/UserSettings.dart';
import 'package:nasooh/app/Style/Icons.dart';

import '../../../../../app/constants.dart';
import '../../../../../app/keys.dart';
import '../../../../../app/utils/lang/language_constants.dart';
import '../../../TermsConditionsScreen/TermsConditionsScreen.dart';

class SettingsMenuItem {
  final String title;
  final SvgPicture svg;
  final void Function() onTap;
  final SvgPicture? trailingSvg = SvgPicture.asset(
    'assets/images/SVGs/arrow.svg',
    // width: 24,
  );
  bool? hasTrailingSvg = true;

  SettingsMenuItem(
      {required this.title, required this.svg, required this.onTap});
}

class SettingsMenuItems {
  static SettingsMenuItem myOrders = SettingsMenuItem(
      title:
          getTranslated(Keys.navigatorKey.currentState!.context, "my_orders")!,
      svg: SvgPicture.asset(ordersIcon, width: 24),
      onTap: () {});
  static SettingsMenuItem wallet = SettingsMenuItem(
      title:
          getTranslated(Keys.navigatorKey.currentState!.context, "my_wallet")!,
      svg: SvgPicture.asset(
        walletIcData,
      ),
      onTap: () {});
  static SettingsMenuItem settings = SettingsMenuItem(
      title:
          getTranslated(Keys.navigatorKey.currentState!.context, "settings")!,
      svg: SvgPicture.asset(
        settingIcon,
      ),
      onTap: () {
        Get.to(() => const UserSettings());
      });

  static SettingsMenuItem terms = SettingsMenuItem(
      title: getTranslated(
          Keys.navigatorKey.currentState!.context, "terms_conditions")!,
      svg: SvgPicture.asset(
        termsIcon,
      ),
      onTap: () {
        Get.to(() => const TermsConditionsScreen());
      });

  static SettingsMenuItem support = SettingsMenuItem(
      title: getTranslated(Keys.navigatorKey.currentState!.context, "support")!,
      svg: SvgPicture.asset(
        techIcon,
      ),
      onTap: () {});
  static SettingsMenuItem nasouh = SettingsMenuItem(
      title: getTranslated(
          Keys.navigatorKey.currentState!.context, "know_nasouh")!,
      svg: SvgPicture.asset(
        knowAboutIcon,
      ),
      onTap: () {});
  static final all = <SettingsMenuItem>[
    SettingsMenuItems.myOrders,
    SettingsMenuItems.wallet,
    SettingsMenuItems.settings,
    SettingsMenuItems.terms,
    SettingsMenuItems.support,
    SettingsMenuItems.nasouh,
  ];
}

Widget buildMenuItem(SettingsMenuItem menuItem) => ListTileTheme(
      selectedColor: Colors.white70,
      child: ListTile(
        // selectedTileColor: Colors.red,
        // selected: currentItem == menuItem,
        minLeadingWidth: 20,
        title: Text(
          menuItem.title,
          style: Constants.mainTitleFont,
        ),
        leading: menuItem.svg,
        trailing: menuItem.trailingSvg,
        onTap: () {
          menuItem.onTap();
        },
      ),
    );
