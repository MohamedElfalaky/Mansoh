import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import '../../../Data/cubit/settings_cubits/privacy_cubit/privacy_cubit.dart';
import '../../../Data/cubit/settings_cubits/privacy_cubit/privacy_state.dart';
import '../../../app/Style/Icons.dart';
import '../../widgets/shared.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen();

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;
  bool _checked = false;
  bool _privacy = false;
  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

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
            message: 'noInternet'.tr);
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
    context.read<PrivacyCubit>().getPrivacy();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
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
          message: 'noInternet'.tr);
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      }, // hide keyboard on tap anywhere

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.whiteAppColor,
        appBar: customAppBar(
            context: context, txt:  "terms_conditions".tr),
        body: BlocBuilder<PrivacyCubit, PrivacyState>(
            builder: (context, privacyState) {
          if (privacyState is PrivacyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (privacyState is PrivacyLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          termsConditions,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "الشروط والأحكام",
                              style: Constants.mainTitleFont,
                            ),
                            // ignore: prefer_const_constructors
                            Text(
                              "آخر تحديث 12-10-2022",
                              style: Constants.subtitleRegularFont,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: ListView(
                      children: [
                        Text(
                          privacyState.response?.data?.description ?? "",
                          style: Constants.subtitleRegularFont,
                        )
                      ],
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      // !_checked
                      //     ? InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       _checked = !_checked;
                      //     });
                      //   },
                      //   child: Container(
                      //     width: 22,
                      //     height: 22,
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //             color: Colors.black, width: 1.4)),
                      //   ),
                      // )
                      //     :
                  InkWell(
                        onTap: () {
                          // setState(() {
                          //   _checked = !_checked;
                          // });
                        },
                        child: SvgPicture.asset(
                          checkIcon,
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("اوافق علي جميع الشروط والأحكام"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      // !_privacy
                      //     ? InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       _privacy = !_privacy;
                      //     });
                      //   },
                      //   child: Container(
                      //     width: 22,
                      //     height: 22,
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //             color: Colors.black, width: 1.4)),
                      //   ),
                      // )
                      //     :
                      InkWell(
                        onTap: () {
                          // setState(() {
                          //   _privacy = !_privacy;
                          // });
                        },
                        child: SvgPicture.asset(
                          checkIcon,
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("اوافق علي سياسة الخصوصية" , style: TextStyle(fontWeight: FontWeight.w700),),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  )
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
