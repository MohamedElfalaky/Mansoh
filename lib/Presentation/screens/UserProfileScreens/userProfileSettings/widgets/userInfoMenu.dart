import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../app/constants.dart';
import '../../../../../app/keys.dart';
import '../../../../../app/utils/lang/language_constants.dart';

class SettingsMenuItem {
  final String title;
  final SvgPicture svg;
  final SvgPicture? trailingSvg = SvgPicture.asset(
    'assets/images/SVGs/arrow.svg',
    // width: 24,
  );
  bool? hasTrailingSvg = true;

  SettingsMenuItem({
    required this.title,
    required this.svg,
  });
}

class SettingsMenuItems {
  static SettingsMenuItem myOrders = SettingsMenuItem(
    title: getTranslated(Keys.navigatorKey.currentState!.context, "my_orders")!,
    svg: SvgPicture.asset('assets/images/SVGs/order.svg', width: 24),
  );
  static SettingsMenuItem wallet = SettingsMenuItem(
    title: getTranslated(Keys.navigatorKey.currentState!.context, "my_wallet")!,
    svg: SvgPicture.asset(
      'assets/images/SVGs/wallet.svg',
    ),
  );
  static SettingsMenuItem settings = SettingsMenuItem(
    title: getTranslated(Keys.navigatorKey.currentState!.context, "settings")!,
    svg: SvgPicture.asset(
      'assets/images/SVGs/settings.svg',
    ),
  );

  static SettingsMenuItem terms = SettingsMenuItem(
    title: getTranslated(
        Keys.navigatorKey.currentState!.context, "terms_conditions")!,
    svg: SvgPicture.asset(
      'assets/images/SVGs/book.svg',
    ),
  );

  static SettingsMenuItem support = SettingsMenuItem(
    title: getTranslated(Keys.navigatorKey.currentState!.context, "support")!,
    svg: SvgPicture.asset(
      'assets/images/SVGs/help.svg',
    ),
  );
  static SettingsMenuItem nasouh = SettingsMenuItem(
    title:
        getTranslated(Keys.navigatorKey.currentState!.context, "know_nasouh")!,
    svg: SvgPicture.asset(
      'assets/images/SVGs/ask.svg',
    ),
  );
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
          // onSelectedItem(menuItem);
        },
      ),
    );
