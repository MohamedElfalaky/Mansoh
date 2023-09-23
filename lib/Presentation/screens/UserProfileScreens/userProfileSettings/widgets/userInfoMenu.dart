// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../../../app/Style/Icons.dart';
// import '../../../../../app/constants.dart';
// import '../../../TermsConditionsScreen/TermsConditionsScreen.dart';
// import '../../../UserSettingsScreen/UserSettings.dart';
//
// class SettingsMenuItem {
//   final String title;
//   final SvgPicture svg;
//   final void Function() onTap;
//   final SvgPicture? trailingSvg = SvgPicture.asset(
//     'assets/images/SVGs/arrow.svg',
//     // width: 24,
//   );
//   bool? hasTrailingSvg = true;
//
//   SettingsMenuItem(
//       {required this.title, required this.svg, required this.onTap});
// }
//
// class SettingsMenuItems {
//   static SettingsMenuItem myOrders = SettingsMenuItem(
//       title: "my_orders".tr,
//       svg: SvgPicture.asset(ordersIcon, width: 24),
//       onTap: () {});
//   static SettingsMenuItem wallet = SettingsMenuItem(
//       title: "my_wallet".tr,
//       svg: SvgPicture.asset(
//         walletIcData,
//       ),
//       onTap: () {});
//   static SettingsMenuItem settings = SettingsMenuItem(
//       title: "settings".tr,
//       svg: SvgPicture.asset(
//         settingIcon,
//       ),
//       onTap: () {
//         Get.to(() => const UserSettings());
//       });
//
//   static SettingsMenuItem terms = SettingsMenuItem(
//       title: "terms_conditions".tr,
//       svg: SvgPicture.asset(
//         termsIcon,
//       ),
//       onTap: () {
//         Get.to(() => const TermsConditionsScreen());
//       });
//
//   static SettingsMenuItem support = SettingsMenuItem(
//       title: "support".tr,
//       svg: SvgPicture.asset(
//         techIcon,
//       ),
//       onTap: () async {
//         await launchUrl(Uri.parse(
//           "whatsapp://send?phone=0201000869066",
//         ));
//       });
//   static SettingsMenuItem nasouh = SettingsMenuItem(
//       title: "know_nasouh".tr,
//       svg: SvgPicture.asset(
//         knowAboutIcon,
//       ),
//       onTap: () {});
//   static final all = <SettingsMenuItem>[
//     SettingsMenuItems.myOrders,
//     SettingsMenuItems.wallet,
//     SettingsMenuItems.settings,
//     SettingsMenuItems.terms,
//     SettingsMenuItems.support,
//     SettingsMenuItems.nasouh,
//   ];
// }
//
// Widget buildMenuItem(SettingsMenuItem menuItem) => ListTileTheme(
//       selectedColor: Colors.white70,
//       child: ListTile(
//         // selectedTileColor: Colors.red,
//         // selected: currentItem == menuItem,
//         minLeadingWidth: 20,
//         title: Text(
//           menuItem.title,
//           style: Constants.mainTitleFont,
//         ),
//         leading: menuItem.svg,
//         trailing: Get.locale!.languageCode == "ar"
//             ? menuItem.trailingSvg
//             : const Icon(
//                 Icons.arrow_forward_ios,
//                 size: 15,
//               ),
//         onTap: () {
//           menuItem.onTap();
//         },
//       ),
//     );
