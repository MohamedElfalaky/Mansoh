import 'dart:async';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/Presentation/widgets/my_button.dart';

import '../../../Data/cubit/review_cubit/review_cubit.dart';
import '../../../Data/cubit/review_cubit/review_state.dart';
import '../../../app/utils/exports.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key, required this.adviceId});

  final int adviceId;

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  final TextEditingController opinionController = TextEditingController();
  late StreamSubscription<ConnectivityResult> _subscription;
  bool? isConnected;
  final _formKey = GlobalKey<FormState>();
  double speedRate = 0.0;
  double qualityRate = 0.0;
  double flexibleRate = 0.0;
  int groupAdviserValue = 1;
  int groupApplicationValue = 1;

  @override
  void initState() {
    super.initState();

    MyApplication.checkConnection().then((value) {
      if (value) {
        //
      } else {
        MyApplication.showToastView(message: 'noInternet'.tr);
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
//
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
    // print(widget.adviceId);
    // todo if not connected display nointernet widget else continue to the rest build code
    final sizee = MediaQuery.of(context).size;
    if (isConnected == null) {
      MyApplication.checkConnection().then((value) {
        setState(() {
          isConnected = value;
        });
      });
    } else if (!isConnected!) {
      MyApplication.showToastView(message: 'noInternet'.tr);
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        }, // hide keyboard on tap anywhere

        child: Scaffold(
            floatingActionButton: BlocBuilder<ReviewCubit, ReviewState>(
                //   listener: (context, state) {
                //     if (state is PostRejectLoaded) {
                //       Alert.alert(
                //           context: context,
                //           action: () {
                //             MyApplication.navigateTo(context, Home());
                //           },
                //           content: "تم ارسال اعتراضك بنجاح",
                //           titleAction: "الرئيسية");
                //     }
                //   },
                builder: (context, state) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    child: state is ReviewLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : CustomElevatedButton(
                            txt: "ارسال التقييم",
                            isBold: true,
                            onPressedHandler: () {
                              if (kDebugMode) {
                                print(speedRate);
                                print(widget.adviceId);
                                print(groupAdviserValue);
                                print(groupApplicationValue);
                                print(flexibleRate.toString());
                                print(opinionController.text);
                                print(qualityRate.toString());
                              }

                              context.read<ReviewCubit>().reviewMethod(
                                    adviceId: widget.adviceId,
                                    speed: speedRate.toString(),
                                    context: context,
                                    adviser: groupAdviserValue,
                                    app: groupApplicationValue,
                                    flexibility: flexibleRate.toString(),
                                    other: opinionController.text,
                                    quality: qualityRate.toString(),
                                  );
                              // }
                            },
                          ))),
            // ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            resizeToAvoidBottomInset: false,
            backgroundColor: Constants.whiteAppColor,
            appBar: customAppBar(
              context: context,
              txt: "تقييم الناصح",
            ),
            body: Container(
                color: Constants.whiteAppColor,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    top: 15),
                child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _itemContain(
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(topRated),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      const Text(
                                        "تقييم الناصح",
                                        style: Constants.headerNavigationFont,
                                      ),
                                    ],
                                  ),

                                  _itemRate(
                                    txt: "سرعة التجاوب".tr,
                                    rateVal: speedRate,
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        speedRate = rating;
                                      });
                                    },
                                  ),
                                  _itemRate(
                                    txt: "جودة النصيحة".tr,
                                    rateVal: qualityRate,
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        qualityRate = rating;
                                      });
                                    },
                                  ),
                                  _itemRate(
                                    txt: "مرونة وتعامل الناصح".tr,
                                    rateVal: flexibleRate,
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        flexibleRate = rating;
                                      });
                                    },
                                  ),

                                  // _itemRate(
                                  //     txt: "سرعة التجاوب".tr,
                                  //     rateVal: speedRate),
                                  // _itemRate(
                                  //     txt: "جودة النصيحة".tr,
                                  //     rateVal: qualityRate),
                                  // _itemRate(
                                  //     txt: "مرونة وتعامل الناصح".tr,
                                  //     rateVal: flexibleRate),
                                ],
                              ),
                            ),
                            _itemContain(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "هل ستتعامل مع هذا الناصح مرة أخرى؟",
                                    style: Constants.secondaryTitleRegularFont,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                            activeColor:
                                                Constants.primaryAppColor,
                                            value: 1,
                                            onChanged: (val) {
                                              groupAdviserValue = 1;
                                              setState(() {});
                                            },
                                            groupValue: groupAdviserValue,
                                          ),
                                          const Text("نعم",
                                              style: Constants
                                                  .secondaryTitleRegularFont),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 35,
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            activeColor:
                                                Constants.primaryAppColor,
                                            value: 0,
                                            onChanged: (val) {
                                              groupAdviserValue = 0;
                                              setState(() {});
                                            },
                                            groupValue: groupAdviserValue,
                                          ),
                                          const Text("لا",
                                              style: Constants
                                                  .secondaryTitleRegularFont),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            _itemContain(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "هل ستتعامل مع تطبيق نصوح مرة أخرى؟",
                                    style: Constants.secondaryTitleRegularFont,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                            activeColor:
                                                Constants.primaryAppColor,
                                            value: 1,
                                            onChanged: (val) {
                                              groupApplicationValue = 1;
                                              setState(() {});
                                              // print(groupApplicationValue);
                                            },
                                            groupValue: groupApplicationValue,
                                          ),
                                          const Text("نعم",
                                              style: Constants
                                                  .secondaryTitleRegularFont),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 35,
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            activeColor:
                                                Constants.primaryAppColor,
                                            value: 0,
                                            onChanged: (val) {
                                              groupApplicationValue = 0;
                                              setState(() {});
                                              // print(groupApplicationValue);
                                            },
                                            groupValue: groupApplicationValue,
                                          ),
                                          const Text("لا",
                                              style: Constants
                                                  .secondaryTitleRegularFont),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              child: Text("أخبر الآخرين عن رأيك (اختياري)",
                                  style: Constants.secondaryTitleRegularFont),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: TextFormField(
                                controller: opinionController,
                                // maxLength: 700,
                                maxLines: 5,
                                decoration: Constants.setTextInputDecoration(
                                  isParagraphTextField: true,
                                  fillColor: const Color(0XFFF5F4F5),
                                  hintText: "اكتب ما تريد ....".tr,
                                  // isSuffix: false
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ))))));
  }

  Widget _itemRate(
      {String? txt, double? rateVal, void Function(double)? onRatingUpdate}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt ?? "",
            style: Constants.secondaryTitleRegularFont,
          ),
          RatingBar.builder(
            initialRating: rateVal ?? 0,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 30.0,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: onRatingUpdate!,
          ),
        ],
      ),
    );
  }

  Widget _itemContain(Widget child) {
    return Container(
        margin: const EdgeInsets.only(top: 25),
        padding: const EdgeInsets.only(bottom: 8, top: 4, right: 15, left: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(blurRadius: 3, color: Colors.grey, spreadRadius: -1.2)
            ]),
        child: child);
  }
}
