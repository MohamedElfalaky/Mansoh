import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/Style/sizes.dart';
import 'package:nasooh/app/constants.dart';

import '../../../widgets/MyButton.dart';

class OutlinedAdvisorCard extends StatelessWidget {
  const OutlinedAdvisorCard(
      {super.key,
      required this.name,
      required this.imagePhoto,
      required this.isClickable});

  final String name;
  final String imagePhoto;
  final bool isClickable;

  @override
  Widget build(BuildContext context) {
    return isClickable
        ? SizedBox(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  // height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Constants.whiteAppColor,
                      borderRadius: BorderRadius.circular(6),
                      // border: Border.all(
                      //   color: Constants.primaryAppColor.withOpacity(0.26),
                      //   width: 2,
                      // ),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 18),
                            // blurRadius: 10,
                            spreadRadius: -8,
                            blurStyle: BlurStyle.normal,
                            color: Constants.primaryAppColor.withOpacity(0.1)),
                      ]),
                  child: DottedBorder(
                    color: Constants.primaryAppColor,
                    strokeWidth: 1,
                    dashPattern: [10, 6],
                    borderType: BorderType.RRect,
                    radius: Radius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 6, right: 16, left: 16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(
                                  imagePhoto,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width(context) * 0.5,
                                    child: Text(
                                      name,
                                      style: Constants.secondaryTitleFont,
                                    ),
                                  ),
                                  const Text(
                                    "استشاري متخصص بالمحماة",
                                    style: Constants.subtitleFont,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  ////////////// tags
                                  ///
                                  ///
                                  ///
                                  ///
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        margin: const EdgeInsets.only(left: 8),
                                        height: 24,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: const Color(0XFFEEEEEE)),
                                        child: const Text(
                                          "استشاري",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: Constants.mainFont,
                                              color: Color(0XFF444444)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        margin: const EdgeInsets.only(left: 8),
                                        height: 24,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: const Color(0XFFEEEEEE)),
                                        child: const Text(
                                          "هندسي",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: Constants.mainFont,
                                              color: Color(0XFF444444)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        margin: const EdgeInsets.only(left: 8),
                                        height: 24,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: const Color(0XFFEEEEEE)),
                                        child: const Text(
                                          "تسويق رقمي",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: Constants.mainFont,
                                              color: Color(0XFF444444)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      ///////// remaining tags
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        margin: const EdgeInsets.only(left: 8),
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: const Color(0XFFD9D9D9)),
                                        child: const Text(
                                          "+3",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: Constants.mainFont,
                                              color: Color(0XFF444444)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  const Text(
                                    "4.8",
                                    style: Constants.secondaryTitleFont,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  SvgPicture.asset(
                                    rateIcon,
                                    height: 20,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: 10.0),
                                  child: MyButton(
                                    isBold: true,
                                    txt: "استلام",
                                    onPressedHandler: () {
                                      // MyApplication.navigateTo(
                                      //     context, RegistrationStage7());
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: MyButtonOutlined(
                                  isBold: true,
                                  txt: "اعتراض",
                                  onPressedHandler: () {
                                    // MyApplication.navigateTo(context, RegectOrder());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: const EdgeInsets.only(bottom: 16),
            // height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Constants.whiteAppColor,
                borderRadius: BorderRadius.circular(6),
                // border: Border.all(
                //   color: Constants.primaryAppColor.withOpacity(0.26),
                //   width: 2,
                // ),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 18),
                      // blurRadius: 10,
                      spreadRadius: -8,
                      blurStyle: BlurStyle.normal,
                      color: Constants.primaryAppColor.withOpacity(0.1)),
                ]),
            child: DottedBorder(
              color: Constants.primaryAppColor,
              strokeWidth: 1,
              dashPattern: [10, 6],
              borderType: BorderType.RRect,
              radius: Radius.circular(8),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 6, right: 16, left: 16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                            imagePhoto,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width(context) * 0.5,
                              child: Text(
                                name,
                                style: Constants.secondaryTitleFont,
                              ),
                            ),
                            const Text(
                              "استشاري متخصص بالمحماة",
                              style: Constants.subtitleFont,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ////////////// tags
                            ///
                            ///
                            ///
                            ///
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  margin: const EdgeInsets.only(left: 8),
                                  height: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: const Color(0XFFEEEEEE)),
                                  child: const Text(
                                    "استشاري",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: Constants.mainFont,
                                        color: Color(0XFF444444)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  margin: const EdgeInsets.only(left: 8),
                                  height: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: const Color(0XFFEEEEEE)),
                                  child: const Text(
                                    "هندسي",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: Constants.mainFont,
                                        color: Color(0XFF444444)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  margin: const EdgeInsets.only(left: 8),
                                  height: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: const Color(0XFFEEEEEE)),
                                  child: const Text(
                                    "تسويق رقمي",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: Constants.mainFont,
                                        color: Color(0XFF444444)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                ///////// remaining tags
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  margin: const EdgeInsets.only(left: 8),
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: const Color(0XFFD9D9D9)),
                                  child: const Text(
                                    "+3",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: Constants.mainFont,
                                        color: Color(0XFF444444)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Text(
                              "4.8",
                              style: Constants.secondaryTitleFont,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            SvgPicture.asset(
                              rateIcon,
                              height: 20,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
