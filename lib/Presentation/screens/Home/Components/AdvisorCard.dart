import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/Style/sizes.dart';
import 'package:nasooh/app/constants.dart';

import '../../../../Data/models/home_models/advisor_list_model.dart';

class AdvisorCard extends StatelessWidget {
  const AdvisorCard({super.key, required this.adviserData, n});

  final AdviserData adviserData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.only(top: 16, bottom: 6, right: 13, left: 13),
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
                backgroundImage:
                    NetworkImage(adviserData.avatar ?? "", scale: 0.2),
                // child: Image.network(
                //
                //   fit: BoxFit.cover,
                //   // height: ,
                // ),
              ),
              const SizedBox(
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width(context) * 0.6,
                    child: Text(
                      adviserData.fullName ?? "",
                      style: Constants.secondaryTitleFont,
                    ),
                  ),
                  Text(
                    adviserData.description ?? "",
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
                  SizedBox(
                    height: 26,
                    width: width(context) * 0.59,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        if (index < 3) {
                          // Display the first three items from adviser.category
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 4),
                            margin: const EdgeInsets.only(left: 8),
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: const Color(0XFFEEEEEE),
                            ),
                            child: Text(
                              adviserData.category?[index].name ?? "",
                              style: const TextStyle(
                                fontSize: 10,
                                fontFamily: Constants.mainFont,
                                color: Color(0XFF444444),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else if (index == 3) {
                          // Display a fourth item with the count of remaining items
                          int remainingCount =
                              (adviserData.category?.length ?? 0) - 3;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 4),
                            margin: const EdgeInsets.only(left: 8),
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: const Color(0XFFEEEEEE),
                            ),
                            child: Text(
                              '+ $remainingCount',
                              style: const TextStyle(
                                fontSize: 10,
                                fontFamily: Constants.mainFont,
                                color: Color(0XFF444444),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          // You can return an empty container for indexes greater than 3
                          return Container();
                        }
                      },
                      itemCount: min(
                          4,
                          adviserData.category?.length ??
                              0), // Ensure only 4 items are displayed
                    ),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    adviserData.rate ?? "",
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
              adviserData.info ?? "",
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
