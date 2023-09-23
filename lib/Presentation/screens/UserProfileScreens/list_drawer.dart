import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/get_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/Style/Icons.dart';
import '../../../app/constants.dart';
import '../TermsConditionsScreen/TermsConditionsScreen.dart';
import '../UserSettingsScreen/UserSettings.dart';

class BuildItem extends StatelessWidget {
  const BuildItem({super.key, required this.drawerModel});

  final DrawerModel drawerModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 20,
      title: Text(
        drawerModel.title,
        style: Constants.mainTitleFont,
      ),
      leading: drawerModel.svg,
      trailing: Get.locale!.languageCode == "ar"
          ? SvgPicture.asset('assets/images/SVGs/arrow.svg')
          : const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
      onTap: drawerModel.onTap,
    );
  }
}

List<DrawerModel> getDrawer(BuildContext context) => [
      DrawerModel(
          title: "my_orders".tr,
          svg: SvgPicture.asset(ordersIcon, width: 24),
          onTap: () {}),
      DrawerModel(
          title: "my_wallet".tr,
          svg: SvgPicture.asset(
            walletIcData,
          ),
          onTap: () {}),
      DrawerModel(
          title: "settings".tr,
          svg: SvgPicture.asset(
            settingIcon,
          ),
          onTap: () {
            Get.to(() => const UserSettings());
          }),
      DrawerModel(
          title: "terms_conditions".tr,
          svg: SvgPicture.asset(
            termsIcon,
          ),
          onTap: () {
            Get.to(() => const TermsConditionsScreen());
          }),
      DrawerModel(
          title: "support".tr,
          svg: SvgPicture.asset(
            techIcon,
          ),
          onTap: () async {
            await launchUrl(Uri.parse(
              "whatsapp://send?phone=0201000869066",
            ));
          }),
      DrawerModel(
          title: "know_nasouh".tr,
          svg: SvgPicture.asset(
            knowAboutIcon,
          ),
          onTap: () {})
    ];

class DrawerModel {
  final String title;
  final SvgPicture svg;
  final void Function()? onTap;

  DrawerModel({required this.title, required this.svg, this.onTap});
}