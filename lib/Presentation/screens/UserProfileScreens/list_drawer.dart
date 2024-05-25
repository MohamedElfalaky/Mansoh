import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/get_utils.dart';
import 'package:nasooh/Presentation/screens/about_us/about_us_screen.dart';
import 'package:url_launcher/url_launcher.dart';

// import '../../../app/Style/icons.dart';
import '../../../app/constants.dart';
import '../../../app/style/icons.dart';
import '../TermsConditionsScreen/terms_conditions_screen.dart';
import '../user_settings_screen/user_settings.dart';
import 'UserWallet/user_wallet.dart';

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
      // DrawerModel(
      //     title: "my_orders".tr,
      //     svg: SvgPicture.asset(ordersIcon, width: 24),
      //     onTap: () {
      //       Get.to(() =>  Home(currentIndex: 1));
      //     }),
      DrawerModel(
          title: "my_wallet".tr,
          svg: SvgPicture.asset(
            walletIcData,
          ),
          onTap: () {
            Get.to(() => const UserWallet());
          }),
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
              "whatsapp://send?phone=00966502374223",
            ));
          }),
      DrawerModel(
          title: "know_nasouh".tr,
          svg: SvgPicture.asset(
            knowAboutIcon,
          ),
          onTap: () {
            Get.to(() => const AboutUsScreen());
          })
    ];

class DrawerModel {
  final String title;
  final SvgPicture svg;
  final void Function()? onTap;

  DrawerModel({required this.title, required this.svg, this.onTap});
}
