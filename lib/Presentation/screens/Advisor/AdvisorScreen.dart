import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import 'package:readmore/readmore.dart';

import '../../../app/utils/lang/language_constants.dart';

class AdvisorScreen extends StatefulWidget {
  const AdvisorScreen({super.key});

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
              // width: double.infinity,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 40),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Card(child: BackButton()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "???????????? ??????????????",
                          style: Constants.headerNavigationFont,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.share_outlined),
                    ],
                  ),
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        ListView(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: Container(
                                width: 138,
                                height: 138,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 2,
                                        color: const Color(0xFF0076FF))),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          "???????? ?????????????????? ???????????? ????????",
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
                                    "?????????????? ?????????? ????????????????",
                                    style: Constants.subtitleFont,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    height: 25,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        decoration: BoxDecoration(
                                            color: Constants.primaryAppColor,
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                        child: const Center(
                                            child: Text(
                                          "?????????? ??????",
                                          style: TextStyle(
                                              fontFamily: Constants.mainFont,
                                              color: Constants.whiteAppColor,
                                              fontSize: 10),
                                        )),
                                      ),
                                      itemCount: 30,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: ReadMoreText(
                                      "???????????????? ???? ???????????? ?????????????? ???????? ??????????. ?????? ?????????? ???????????? ?????????????? ???????? ???????????? ?????? ?????????? ???????????? ?????? ?????????? ???????? ?????????? ?????????????????? ???????????? ???? ???????????? ???????? ???????????? ???????????? ???? ???? ",
                                      style: Constants.subtitleFont1,
                                      trimLines: 2,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: '????????????',
                                      trimExpandedText: '??????',
                                      moreStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Constants.primaryAppColor),
                                      lessStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Constants.primaryAppColor),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Color(0XFFBCBCC4)))),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: SvgPicture.asset(
                                                    tempPic,
                                                    height: 20,
                                                  )),
                                              RichText(
                                                text: const TextSpan(children: [
                                                  TextSpan(
                                                    text: "338",
                                                    style: Constants
                                                        .subtitleFontBold,
                                                  ),
                                                  TextSpan(
                                                    text: " ??????????",
                                                    style:
                                                        Constants.subtitleFont,
                                                  )
                                                ]),
                                              )
                                            ],
                                          ),
                                          const VerticalDivider(
                                            color: Color(0XFFBCBCC4),
                                            width: 1,
                                            thickness: 1,
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: SvgPicture.asset(
                                                    tempPic,
                                                    height: 20,
                                                  )),
                                              RichText(
                                                text: const TextSpan(children: [
                                                  TextSpan(
                                                    text: "(4.8)",
                                                    style: Constants
                                                        .subtitleFontBold,
                                                  ),
                                                  TextSpan(
                                                    text: " ??????????",
                                                    style:
                                                        Constants.subtitleFont,
                                                  )
                                                ]),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Card(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  tempPic,
                                                  height: 30,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                const Text(
                                                  "?????????? ????????????",
                                                  style: Constants
                                                      .secondaryTitleFont,
                                                ),
                                                const Spacer(),
                                                const Text(
                                                  "7 ??????????",
                                                  style: Constants.subtitleFont,
                                                )
                                              ],
                                            ),
                                            const Center(
                                              child: SizedBox(
                                                width: 150,
                                                child: Divider(
                                                  thickness: 1,
                                                  color: Color(0XFFEDEDED),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  tempPic,
                                                  height: 30,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                const Text(
                                                  "???????????????? ????????????????????",
                                                  style: Constants
                                                      .secondaryTitleFont,
                                                ),
                                              ],
                                            ),
                                            Wrap(
                                              children: List.generate(
                                                  8,
                                                  (index) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8,
                                                        ),
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 4),
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0XFFEEEEEE),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2)),
                                                        child: const Text(
                                                          "?????????? ??????",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  Constants
                                                                      .mainFont,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10),
                                                        ),
                                                      ))),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            )
                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            height: 50,
                            child: const MyButton(
                              txt: "???????? ??????????",
                              isBold: true,
                            ))
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
