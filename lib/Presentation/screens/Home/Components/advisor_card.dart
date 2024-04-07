import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/constants.dart';
import '../../../../Data/models/home_models/advisor_list_model.dart';
import '../../../../app/style/icons.dart';
import '../../../../app/style/sizes.dart';

class AdvisorCard extends StatelessWidget {
  const AdvisorCard({super.key, required this.adviserData});

  final AdviserData adviserData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.only(top: 16, bottom: 6, right: 13, left: 13),
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
                color: Colors.black38.withOpacity(.2)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage(
                                adviserData.avatar != null &&
                                        adviserData.avatar != ''
                                    ? adviserData.avatar!
                                    : Constants.imagePlaceHolder,
                                scale: 0.2),
                          ))),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width(context) * 0.6,
                      child: Text(
                        adviserData.fullName ?? "",
                        style: Constants.secondaryTitleFont,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      adviserData.description != "" &&
                              adviserData.description != null
                          ? adviserData.description!
                          : "لا يوجد وصف لهذا الناصح",
                      style: Constants.subtitleFont,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 22,
                      width: width(context) * 0.59,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                          if (index < 3) {
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
                          } // You can return an empty container for indexes greater than 3
                          return const SizedBox.shrink();
                        },
                        itemCount: min(4, adviserData.category?.length ?? 0),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    adviserData.rate ?? "",
                    style: Constants.secondaryTitleFont,
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(rateIcon, width: 12, height: 12)
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            adviserData.info ?? "",
            style: Constants.subtitleFont,
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
