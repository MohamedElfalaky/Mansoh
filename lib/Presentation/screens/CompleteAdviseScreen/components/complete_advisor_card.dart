import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/constants.dart';

import '../../../../Data/models/advisor_profile_model/advisor_profile.dart';
import '../../../../app/style/icons.dart';

class CompleteAdvisorCard extends StatelessWidget {
  const CompleteAdvisorCard({
    super.key,
    required this.adviser,
    required this.moneyPut,
    required this.taxVal,
  });

  final AdviserProfileData adviser;
  final String moneyPut;
  final String taxVal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, top: 4),
      padding: const EdgeInsets.only(top: 16, bottom: 6, right: 16, left: 16),
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
                backgroundImage: NetworkImage(
                  adviser.avatar != '' && adviser.avatar != null
                      ? adviser.avatar!
                      : Constants.imagePlaceHolder,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${adviser.fullName}',
                    style: Constants.secondaryTitleFont,
                  ),
                  Text(
                    adviser.description ?? "لا يوجد وصف لهذا الناصح",
                    style: Constants.subtitleFont,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    adviser.rate ?? "",
                    style: Constants.secondaryTitleFont,
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    rateIcon,
                    height: 20,
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 26,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, int index) {
                if (index < 5) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    margin: const EdgeInsets.only(left: 8),
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: const Color(0XFFEEEEEE),
                    ),
                    child: Text(
                      adviser.category?[index].name ?? "",
                      style: const TextStyle(
                        fontSize: 10,
                        fontFamily: Constants.mainFont,
                        color: Color(0XFF444444),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (index == 5) {
                  int remainingCount = (adviser.category?.length ?? 0) - 5;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin: const EdgeInsets.only(left: 8),
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: const Color(0XFFEEEEEE),
                    ),
                    child: Center(
                      child: Text(
                        '+ $remainingCount',
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: Constants.mainFont,
                          color: Color(0XFF444444),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return null;
              },
              itemCount: min(
                  6,
                  adviser.category?.length ??
                      0), // Ensure only 4 items are displayed
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "المبلغ",
                  style: Constants.subtitleRegularFont,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: moneyPut, style: Constants.subtitleFontBold),
                  TextSpan(
                    text: " ريال سعودي",
                    style: Constants.subtitleRegularFont.copyWith(fontSize: 10),
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
