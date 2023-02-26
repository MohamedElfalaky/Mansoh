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
      padding: EdgeInsets.only(top: 16, bottom: 6, right: 16, left: 16),
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Constants.whiteAppColor,
          borderRadius: BorderRadius.circular(5),
          border:
              Border.all(color: Constants.primaryAppColor.withOpacity(0.26)),
          boxShadow: [
            BoxShadow(
                offset: Offset(2, 6),
                blurRadius: 10,
                spreadRadius: -5,
                blurStyle: BlurStyle.normal,
                color: Color(0xFF5C5E6B1A).withOpacity(0)),
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
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "محمد عبدالعزيز الحميد كامل",
                    style: Constants.secondaryTitleFont,
                  ),
                  Text(
                    "استشاري متخصص بالمحماة",
                    style: Constants.subtitleFont,
                  ),
                  SizedBox(
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
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(left: 8),
                        height: 24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Color(0XFFEEEEEE)),
                        child: Text(
                          "استشاري",
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: Constants.mainFont,
                              color: Color(0XFF444444)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(left: 8),
                        height: 24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Color(0XFFEEEEEE)),
                        child: Text(
                          "هندسي",
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: Constants.mainFont,
                              color: Color(0XFF444444)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(left: 8),
                        height: 24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Color(0XFFEEEEEE)),
                        child: Text(
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
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(left: 8),
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Color(0XFFD9D9D9)),
                        child: Text(
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
              Spacer(),
              Row(
                children: [
                  Text(
                    "4.8",
                    style: Constants.secondaryTitleFont,
                  ),
                  SizedBox(
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
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: Text(
              "ويُستخدم في صناعات المطابع ودور النشر كان لوريم إيبسوم ولايزالالمعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت....",
              style: Constants.subtitleFont,
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
    );
  }
}
