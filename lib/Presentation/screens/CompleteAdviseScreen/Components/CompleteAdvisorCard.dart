import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';

class CompleteAdvisorCard extends StatelessWidget {
  const CompleteAdvisorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, top: 4),
      padding: const EdgeInsets.only(top: 16, bottom: 6, right: 16, left: 16),
      // height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Constants.whiteAppColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                offset: const Offset(2, 0),
                blurRadius: 10,
                spreadRadius: -2,
                blurStyle: BlurStyle.normal,
                color: const Color(0xFF5C5E6B).withOpacity(0.1)),
          ]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                child: SvgPicture.asset(
                  tempPic,
                  // height: ,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "محمد عبدالعزيز الحميد كامل",
                    style: Constants.secondaryTitleFont,
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
                    tempPic,
                    height: 20,
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "رقم الطلب",
                  style: Constants.subtitleRegularFont,
                ),
                Text(
                  "#738477202",
                  style: Constants.subtitleRegularFont,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "المبلغ",
                  style: Constants.subtitleRegularFont,
                ),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: "75", style: Constants.subtitleFontBold),
                  TextSpan(
                    text: " ريال سعودي",
                    style: Constants.subtitleRegularFont,
                  ),
                ]))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "مبلغ الضريبة (VAT)",
                  style: Constants.subtitleRegularFont,
                ),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: "9", style: Constants.subtitleFontBold),
                  TextSpan(
                    text: " ريال سعودي",
                    style: Constants.subtitleRegularFont,
                  ),
                ]))
              ],
            ),
          ),
          const DottedLine(dashColor: Color(0xFFDADADA), dashLength: 5),
          Padding(
            padding: const EdgeInsets.only(bottom: 12, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "المبلغ الإجمالي",
                  style: Constants.subtitleRegularFont,
                ),
                RichText(
                    text: const TextSpan(
                        style: Constants.subtitleRegularFont,
                        children: [
                      TextSpan(
                          text: "84",
                          style: TextStyle(
                              color: Constants.primaryAppColor,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: " ريال سعودي",
                        style: TextStyle(
                          color: Constants.primaryAppColor,
                        ),
                      ),
                    ]))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
