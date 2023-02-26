import 'dart:async';

import 'package:badges/badges.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/Advisor/Components/AdvisorCard.dart';
import 'package:nasooh/Presentation/screens/Advisor/controller/AdvisorController.dart';
import 'package:nasooh/Presentation/screens/UserProfileScreens/userProfileScreen.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/utils/lang/language_constants.dart';

class AdvisorScreen extends StatefulWidget {
  const AdvisorScreen();

  @override
  State<AdvisorScreen> createState() => _AdvisorScreenState();
}

class _AdvisorScreenState extends State<AdvisorScreen> {
  // AdvisorController AdvisorController = AdvisorController();
  late StreamSubscription<ConnectivityResult> _subscription;
  bool? isConnected;

  @override
  void initState() {
    super.initState();

    MyApplication.checkConnection().then((value) {
      if (value) {
        //////
        // todo recall data
        ///
        ///
        ///
        ///
      } else {
        MyApplication.showToastView(
            message: '${getTranslated(context, 'noInternet')}');
      }
    });

    // todo subscribe to internet change
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (mounted) {
        setState(() {
          result == ConnectivityResult.none
              ? isConnected = false
              : isConnected = true;
        });
      }

      /// if internet comes back
      if (result != ConnectivityResult.none) {
        /// call your apis
        // todo recall data
        ///
        ///
        ///
        ///
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // todo if not connected display nointernet widget else continue to the rest build code
    final sizee = MediaQuery.of(context).size;
    if (isConnected == null) {
      MyApplication.checkConnection().then((value) {
        setState(() {
          isConnected = value;
        });
      });
    } else if (!isConnected!) {
      MyApplication.showToastView(
          message: '${getTranslated(context, 'noInternet')}');
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      }, // hide keyboard on tap anywhere

      child: Scaffold(
          backgroundColor: Constants.whiteAppColor,
          body: Container(
              color: Constants.whiteAppColor,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 40),
              child: Column(
                children: [
                  ///  start frooooooom heeeeeereeeeeeeeeeeee    ///  start frooooooom heeeeeereeeeeeeeeeeee  ///  start frooooooom heeeeeereeeeeeeeeeeee

                  Row(
                    children: const [
                      Card(child: BackButton()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "الصفحة الشخصية",
                          style: Constants.headerNavigationFont,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.share_outlined),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  Container(
                    width: 138,
                    height: 138,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: 1, color: const Color(0xFF0076FF))),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SvgPicture.asset(
                          tempPic,
                          height: 130,
                          width: 130,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 18,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "محمد عبدالعزيز الحميد كامل",
                                style: Constants.secondaryTitleFont,
                              ),
                            ),
                            SvgPicture.asset(
                              tempPic,
                              width: 18,
                            )
                          ],
                        ),
                        const Text(
                          "استشاري متخصص بالمحماة",
                          style: Constants.subtitleFont,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          height: 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                  color: Constants.primaryAppColor,
                                  borderRadius: BorderRadius.circular(2)),
                              child: const Center(
                                  child: Text(
                                "محامي عام",
                                style: TextStyle(
                                    fontFamily: Constants.mainFont,
                                    color: Constants.whiteAppColor,
                                    fontSize: 10),
                              )),
                            ),
                            itemCount: 30,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      // shrinkWrap: true,
                      // physics: BouncingScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            MyApplication.navigateTo(
                                context, const UserProfileScreen());
                          },
                          child: const AdvisorCard()),
                    ),
                  ),
                ],
              ))),
    );
  }
}
