import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/Home/HomeScreen.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/lang/language_constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

import '../../../app/global.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding();

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
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Center(
                        child: SvgPicture.asset(logoo),
                      ),
                      SizedBox(
                        height: 34,
                      ),
                      SizedBox(height: 150, child: Image.asset(onBoardingPNG)),
                      SizedBox(
                        height: 30,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Align(
                                alignment: Alignment(0, -5.5),
                                child: SvgPicture.asset(curve1)),
                            Align(
                                alignment: Alignment(0, -3.3),
                                child: SvgPicture.asset(curve2)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          getTranslated(context,
                              "تبغى نصيحة ممتازة من شخص فاهم بمجاله بسعر أنت تحدده ويرد عليك بسرعة؟")!,
                          style: Constants.headerNavigationFont,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          getTranslated(context,
                              "تطبيق نصوح يساعدك في الحصول على إجابة وافية لكل سؤال")!,
                          style: Constants.subtitleFont1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      MyButton(
                        txt: "ابدأ الآن",
                        isBold: true,
                        onPressedHandler: () {
                          MyApplication.navigateToReplace(
                              context, HomeScreen());
                        },
                      )
                    ],
                  ))),
        ],
      ),
    );
  }
}
