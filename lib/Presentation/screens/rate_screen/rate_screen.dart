import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import '../../../Data/cubit/rejections_cubit/reject_cubit/post_reject_cubit.dart';
import '../../../Data/cubit/rejections_cubit/reject_cubit/post_reject_state.dart';
import '../../../Data/cubit/rejections_cubit/rejection_list_cubit/rejection_list_cubit.dart';
import '../../../Data/cubit/rejections_cubit/rejection_list_cubit/rejection_list_state.dart';
import '../../widgets/alerts.dart';
import '../Home/Home.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key
      // , required this.adviceId
      });

  // final int adviceId;

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

  @override
  void initState() {
    super.initState();

    MyApplication.checkConnection().then((value) {
      if (value) {
        context.read<ListRejectionCubit>().getDataListRejection();
      } else {
        MyApplication.showToastView(message: '${'noInternet'.tr}');
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
        context.read<ListRejectionCubit>().getDataListRejection();
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
      MyApplication.showToastView(message: '${'noInternet'.tr}');
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        }, // hide keyboard on tap anywhere

        child: Scaffold(
            floatingActionButton:
                // BlocConsumer<PostRejectCubit, PostRejectState>(
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
                //   builder: (context, state) =>
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    child:
                        //       state is PostRejectLoading
                        //           ? const Center(child: CircularProgressIndicator())
                        //           :
                        MyButton(
                      txt: "ارسال التقييم",
                      isBold: true,
                      onPressedHandler: () {
                        if (_formKey.currentState!.validate()) {
                          // print(widget.adviceId);

                          // context.read<PostRejectCubit>().postRejectMethod(
                          //       adviceId: widget.adviceId.toString(),
                          //       // adviceId: 1,
                          //       commentId: idSelected,
                          //       commentOther: "",
                          //     );
                        }
                      },
                    )),
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
                                      rateVal: speedRate),
                                  _itemRate(
                                      txt: "جودة النصيحة".tr,
                                      rateVal: qualityRate),
                                  _itemRate(
                                      txt: "مرونة وتعامل الناصح".tr,
                                      rateVal: flexibleRate),
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
                                              // arabSelection(val as SingingCharacter);
                                            },
                                            groupValue: 1,
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
                                            value: 2,
                                            onChanged: (val) {},
                                            groupValue: 1,
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
                                              // arabSelection(val as SingingCharacter);
                                            },
                                            groupValue: 1,
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
                                            value: 2,
                                            onChanged: (val) {},
                                            groupValue: 1,
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: const Text(
                                  "أخبر الآخرين عن رأيك (اختياري)",
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

  Widget _itemRate({String? txt, double? rateVal}) {
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
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 30.0,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              rateVal = rating;
              // print(initialRate);
            },
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
