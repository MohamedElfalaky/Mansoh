import 'dart:async';

import 'package:badges/badges.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/LoginScreen/loginscreen.dart';
import 'package:nasooh/Presentation/screens/Home/Components/AdvisorCard.dart';
import 'package:nasooh/Presentation/screens/Home/controller/HomeController.dart';
import 'package:nasooh/Presentation/screens/OnBoardong/OnBoarding.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/global.dart';
import '../../../app/utils/lang/language_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = HomeController();
  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;
  final controller = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
///////////////////////////
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
    subscription = Connectivity()
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
    subscription.cancel();
    _timer!.cancel();
    homeController.categories.forEach((element) {
      element["isSelected"] = false;
    });
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
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Badge(
                        badgeColor: Constants.primaryAppColor,
                        // borderSide: const BorderSide(color: Colors.white),
                        position: BadgePosition.topStart(top: -7, start: 0),
                        badgeContent: const Text(
                          "9+",
                          style: TextStyle(
                              fontSize: 8, color: Constants.whiteAppColor),
                          // context.watch<CartItemsCubit>().cartLength ?? "",
                          // style: const TextStyle(color: Colors.white),
                        ),
                        child: Card(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Center(
                              child: SvgPicture.asset(
                                tempPic,
                                height: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        tempPic,
                        height: 50,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    decoration: Constants.setTextInputDecoration(
                        prefixIcon: SvgPicture.asset(
                          tempPic,
                          height: 20,
                        ),
                        hintText: "ابحث باسم الناصح أو التخصص ...."),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  ///
                  ///
                  ///
                  //////////////////// Slider
                  ///
                  ///
                  ///
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Constants.primaryAppColor,
                          Constants.whiteAppColor,
                        ], stops: [
                          0,
                          0.6
                        ]),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 6),
                              blurRadius: 10,
                              spreadRadius: -5,
                              blurStyle: BlurStyle.normal,
                              color: Color(0XFF5C5E6B1A).withOpacity(0.1)),
                        ],
                        borderRadius: BorderRadius.circular(5)),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView(
                          controller: controller,
                          children: [
                            homeController.pageViewItem(),
                            homeController.pageViewItem(),
                            homeController.pageViewItem()
                          ],
                        ),
                        Container(
                          height: 20,
                          width: 70,
                          child: Center(
                            child: SmoothPageIndicator(
                              onDotClicked: (index) {
                                if (_currentPage < 2) {
                                  _currentPage++;
                                } else {
                                  _currentPage = 0;
                                }

                                controller.animateToPage(
                                  _currentPage,
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeIn,
                                );
                              },
                              controller: controller,
                              count: 3,
                              effect: ExpandingDotsEffect(
                                  activeDotColor: Constants.primaryAppColor,
                                  dotColor: Constants.primaryAppColor
                                      .withOpacity(0.2),
                                  spacing: 5,
                                  dotWidth: 8,
                                  dotHeight: 4),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  ///
                  ///
                  ///
                  ///
                  ///////////////////// Filter bar
                  ///
                  ///
                  ///
                  ///
                  Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            // scrollDirection: Axis.horizontal,
                            children: homeController.categories
                                .map(
                                  (e) => InkWell(
                                    onTap: () {
                                      setState(() {
                                        homeController.categories
                                            .forEach((element) {
                                          element["isSelected"] = false;
                                        });
                                        e["isSelected"] = true;
                                      });
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 16),
                                        child: Text(
                                          e["name"],
                                          style: e["isSelected"] == true
                                              ? const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      Constants.mainFont,
                                                  fontSize: 16)
                                              : const TextStyle(
                                                  fontFamily:
                                                      Constants.mainFont),
                                        )),
                                  ),
                                )
                                .toList()),
                      )),

                  ///
                  ///
                  ///
                  /////////////////////////////// Advisor Card
                  ///
                  ///
                  ///

                  // SizedBox(
                  //   height: 8,
                  // ),
                  Expanded(
                    child: ListView.builder(
                      // shrinkWrap: true,
                      // physics: BouncingScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) => AdvisorCard(),
                    ),
                  ),
                ],
              ))),
    );
  }
}
