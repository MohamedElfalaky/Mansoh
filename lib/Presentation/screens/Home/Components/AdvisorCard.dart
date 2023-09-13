import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/Style/sizes.dart';
import 'package:nasooh/app/constants.dart';

class AdvisorCard extends StatelessWidget {
  const AdvisorCard(
      {super.key,
      required this.image,
      // required this.thirdCategory,
      required this.secondCategory,
      required this.firstCategory,
      required this.info,
      required this.name,
      required this.rate,
      required this.description});

  final String image;
  final String info;
  final String name;
  final String rate;
  final String description;
  // final String thirdCategory;
  final String firstCategory;
  final String secondCategory;

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
                backgroundImage: NetworkImage(image, scale: 0.2),
                // child: Image.network(
                //
                //   fit: BoxFit.cover,
                //   // height: ,
                // ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width(context) * 0.6,
                    child: Text(
                      name,
                      style: Constants.secondaryTitleFont,
                    ),
                  ),
                  Text(
                    description,
                    style: Constants.subtitleFont,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
                        child: Text(
                          firstCategory,
                          style: const TextStyle(
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
                        child: Text(
                          secondCategory,
                          style: const TextStyle(
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
                        child: const Text("متخصص",
                          // thirdCategory,
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
                  Text(
                    rate,
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
          const SizedBox(
            height: 16,
          ),


          SizedBox(
            // width: width(context) * 0.6,
            child: Text(
              info,
              style: Constants.subtitleFont,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

        ],
      ),
    );
  }
}
