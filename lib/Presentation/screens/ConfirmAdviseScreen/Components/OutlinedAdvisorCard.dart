import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/Style/sizes.dart';
import 'package:nasooh/app/constants.dart';

import '../../../../Data/cubit/show_advice_cubit/done_advice_cubit/done_advice_cubit.dart';
import '../../../../Data/cubit/show_advice_cubit/done_advice_cubit/done_advice_state.dart';
import '../../../../Data/models/advisor_profile_model/advisor_profile.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../widgets/MyButton.dart';
import '../../rejections/reject_screen.dart';

class OutlinedAdvisorCard extends StatelessWidget {
  const OutlinedAdvisorCard(
      {super.key,
      required this.adviserProfileData,
      required this.isClickable,
      required this.adviceId});

  final AdviserProfileData adviserProfileData;
  final int adviceId;

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
                    radius: const Radius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 6, right: 16, left: 16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // adviserProfileData.avatar == ""
                              //     ? const CircleAvatar(
                              //         radius: 22,
                              //         backgroundImage: AssetImage(
                              //           logo,
                              //         ),
                              //       )
                              //     :
                              CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(
                                  adviserProfileData.avatar ?? "",
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width(context) * 0.5,
                                    child: Text(
                                      adviserProfileData.fullName ?? "",
                                      style: Constants.secondaryTitleFont,
                                    ),
                                  ),
                                  Text(
                                    adviserProfileData.description ?? "",
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
                                  Text(
                                    adviserProfileData.rate ?? "",
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
                            height: 8,
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 10.0),
                                    child: BlocBuilder<DoneAdviceCubit,
                                            DoneAdviceState>(
                                        builder: (context, doneState) => doneState
                                                is DoneAdviceLoading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : MyButton(
                                                isBold: true,
                                                txt: "استلام",
                                                onPressedHandler: () {
                                                  context
                                                      .read<DoneAdviceCubit>()
                                                      .done(
                                                          context: context,
                                                          adviceId: adviceId);
                                                },
                                              ))),
                              ),
                              Flexible(
                                flex: 2,
                                child: MyButtonOutlined(
                                  isBold: true,
                                  txt: "اعتراض",
                                  onPressedHandler: () {
                                    MyApplication.navigateTo(
                                        context,
                                        RejectScreen(
                                          adviceId: adviceId,
                                        ));
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
              radius: const Radius.circular(8),
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
                            adviserProfileData.avatar ?? "",
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width(context) * 0.5,
                              child: Text(
                                adviserProfileData.fullName ?? "",
                                style: Constants.secondaryTitleFont,
                              ),
                            ),
                            Text(
                              adviserProfileData.description ?? "",
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
                            Text(
                              adviserProfileData.rate ?? "",
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
                      height: 8,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
