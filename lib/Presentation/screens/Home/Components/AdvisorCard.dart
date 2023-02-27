import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';

class AdvisorCard extends StatelessWidget {
  const AdvisorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.only(top: 16, bottom: 6, right: 16, left: 16),
      // height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Constants.whiteAppColor,
          borderRadius: BorderRadius.circular(5),
          border:
              Border.all(color: Constants.primaryAppColor.withOpacity(0.26)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(2, 6),
                blurRadius: 10,
                spreadRadius: -5,
                blurStyle: BlurStyle.normal,
                color: const Color(0xFF5C5E6B1A).withOpacity(.2)),
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
            height: 16,
          ),
          const Text(
            "ويُستخدم في صناعات المطابع ودور النشر كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت قامت قامت....",
            style: Constants.subtitleFont,
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
