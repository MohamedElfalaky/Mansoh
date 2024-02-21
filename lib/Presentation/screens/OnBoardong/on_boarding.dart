import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/Home/home_screen.dart';
import 'package:nasooh/Presentation/widgets/my_button.dart';
import 'package:nasooh/app/Style/icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/my_application.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }, // hide keyboard on tap anywhere

      child: Stack(
        children: [
          Center(
            child: Image.asset(
              onBoardingPNGbk,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                  // height: MyApplication.hightClc(context, 700),  معدتش هتحتاجها الكونتينر بقى لعمل مارجن ف الاول بس لتخطيط الصفحة
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Center(
                        child: SvgPicture.asset(logoo),
                      ),
                      const SizedBox(
                        height: 34,
                      ),
                      SizedBox(height: 150, child: Image.asset(onBoardingPNG)),
                      SizedBox(
                        height: 30,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Align(
                                alignment: const Alignment(0, -5.5),
                                child: SvgPicture.asset(curve1)),
                            Align(
                                alignment: const Alignment(0, -3.3),
                                child: SvgPicture.asset(curve2)),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(

                              "تبغى نصيحة ممتازة من شخص فاهم بمجاله بسعر أنت تحدده ويرد عليك بسرعة؟".tr,
                          style: Constants.headerNavigationFont,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(

                              "تطبيق نصوح يساعدك في الحصول على إجابة وافية لكل سؤال".tr,
                          style: Constants.subtitleFont1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      MyButton(
                        txt: "ابدأ الآن",
                        isBold: true,
                        onPressedHandler: () {
                          MyApplication.navigateToReplace(
                              context, const HomeScreen());
                        },
                      )
                    ],
                  ))),
        ],
      ),
    );
  }
}
