import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:nasooh/Presentation/screens/AuthenticationScreens/shared.dart';
import 'package:nasooh/Presentation/screens/ConfirmAdviseScreen/Components/OutlinedAdvisorCard.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

import '../../../app/utils/lang/language_constants.dart';

class ConfirmAdviseScreen extends StatefulWidget {
  const ConfirmAdviseScreen({super.key});

  @override
  State<ConfirmAdviseScreen> createState() => _ConfirmAdviseScreenState();
}

class _ConfirmAdviseScreenState extends State<ConfirmAdviseScreen> {
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
                          "طلب نصيحة",
                          style: Constants.headerNavigationFont,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        ListView(
                          children: [
                            const OutlinedAdvisorCard(),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8, top: 8),
                              child: Text(
                                "عنوان الطلب",
                                style: Constants.secondaryTitleRegularFont,
                              ),
                            ),
                            TextFormField(
                              decoration: Constants.setTextInputDecoration(
                                  prefixIcon: MyPrefixWidget(),
                                  hintText: "ادخل عنوان الطلب..."),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "مثال: تشققات في الجدران .. أفضل وجهات في العلا",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: Constants.mainFont,
                                    color: Constants.primaryAppColor),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                bottom: 8,
                              ),
                              child: Text(
                                "كم مستعد تدفع مقابل النصيحة؟",
                                style: Constants.secondaryTitleRegularFont,
                              ),
                            ),
                            TextFormField(
                              decoration: Constants.setTextInputDecoration(
                                  prefixIcon: MyPrefixWidget(),
                                  hintText: "0.00",
                                  suffixIcon: const Text(
                                    "ريال سعودي",
                                    style: Constants.secondaryTitleRegularFont,
                                  )),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                  "يحق للناصح رفض الطلب في حال كان المبلغ لا يتناسب مع قيمةالنصيحة حسب تقديره",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: Constants.mainFont,
                                      color: Constants.primaryAppColor)),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                "تفاصيل الطلب",
                                style: Constants.secondaryTitleRegularFont,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                maxLength: 700,
                                maxLines: 6,
                                decoration: Constants.setTextInputDecoration(
                                  isParagraphTextField: true,
                                  fillColor: Color(0XFFF5F4F5),
                                  hintText:
                                      "اشرح طلبك بوضوح وإيجاز وزود الناصح بمعلومات كافيةللحصول على إجابة وافية ...",
                                ),
                              ),
                            ),
                            DottedBorder(
                              dashPattern: [10, 6],
                              borderType: BorderType.RRect,
                              radius: Radius.circular(8),
                              color: Color(0XFF80848866),
                              child: Container(
                                height: 56,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload,
                                      color: Color(0xFF0076FF),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "رفع الملفات الخاصة بالطلب",
                                      style: Constants.subtitleFont,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            )
                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            height: 50,
                            child: const MyButton(
                              txt: "تأكيد الطلب",
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
