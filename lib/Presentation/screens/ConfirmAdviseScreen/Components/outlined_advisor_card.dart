import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/rate_screen/rate_screen.dart';
import 'package:nasooh/app/Style/icons.dart';
import 'package:nasooh/app/Style/sizes.dart';
import 'package:nasooh/app/constants.dart';
import '../../../../Data/cubit/show_advice_cubit/done_advice_cubit/done_advice_cubit.dart';
import '../../../../Data/cubit/show_advice_cubit/done_advice_cubit/done_advice_state.dart';
import '../../../../Data/models/advisor_profile_model/advisor_profile.dart';
import '../../../../app/utils/my_application.dart';
import '../../../widgets/my_button.dart';
import '../../rejections/reject_screen.dart';

class OutlinedAdvisorCard extends StatelessWidget {
  const OutlinedAdvisorCard(
      {super.key,
      required this.adviserProfileData,
      required this.isClickable,
      this.labelToShow,
      required this.adviceId});

  final AdviserProfileData adviserProfileData;
  final int adviceId;
  final bool? labelToShow;
  final bool isClickable;

  @override
  Widget build(BuildContext context) {
    return isClickable
        ? SizedBox(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),

                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Constants.whiteAppColor,
                      borderRadius: BorderRadius.circular(6),

                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 18),

                            spreadRadius: -8,
                            blurStyle: BlurStyle.normal,
                            color: Constants.primaryAppColor.withOpacity(0.1)),
                      ]),
                  child: DottedBorder(
                    color: Constants.primaryAppColor,
                    strokeWidth: 1,
                    dashPattern: const [10, 6],
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
                                  SizedBox(
                                    height: 26,
                                    width: width(context) * 0.5,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, int index) {
                                        if (index < 3) {
                                          // Display the first three items from adviser.category
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 4),
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            height: 24,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              color: const Color(0XFFEEEEEE),
                                            ),
                                            child: Text(
                                              adviserProfileData
                                                      .category?[index].name ??
                                                  "",
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
                                              (adviserProfileData
                                                          .category?.length ??
                                                      0) -
                                                  3;
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 4),
                                            margin:
                                                const EdgeInsets.only(left: 8),
                                            height: 24,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
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
                                          adviserProfileData.category?.length ??
                                              0), // Ensure only 4 items are displayed
                                    ),
                                  )
                                  // Row(
                                  //   children: [
                                  //     adviserProfileData.category!.isNotEmpty
                                  //         ? Container(
                                  //             padding:
                                  //                 const EdgeInsets.symmetric(
                                  //                     vertical: 2,
                                  //                     horizontal: 4),
                                  //             margin: const EdgeInsets.only(
                                  //                 left: 8),
                                  //             height: 24,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(2),
                                  //                 color:
                                  //                     const Color(0XFFEEEEEE)),
                                  //             child: Text(
                                  //               adviserProfileData
                                  //                       .category?[0].name ??
                                  //                   "",
                                  //               style: const TextStyle(
                                  //                   fontSize: 10,
                                  //                   fontFamily:
                                  //                       Constants.mainFont,
                                  //                   color: Color(0XFF444444)),
                                  //               textAlign: TextAlign.center,
                                  //             ),
                                  //           )
                                  //         : const SizedBox(),
                                  //     adviserProfileData.category!.length > 0
                                  //         ? Container(
                                  //             padding:
                                  //                 const EdgeInsets.symmetric(
                                  //                     vertical: 2,
                                  //                     horizontal: 4),
                                  //             margin: const EdgeInsets.only(
                                  //                 left: 8),
                                  //             height: 24,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(2),
                                  //                 color:
                                  //                     const Color(0XFFEEEEEE)),
                                  //             child: Text(
                                  //               adviserProfileData
                                  //                       .category?[1].name ??
                                  //                   "",
                                  //               style: const TextStyle(
                                  //                   fontSize: 10,
                                  //                   fontFamily:
                                  //                       Constants.mainFont,
                                  //                   color: Color(0XFF444444)),
                                  //               textAlign: TextAlign.center,
                                  //             ),
                                  //           )
                                  //         : const SizedBox(),
                                  //     adviserProfileData.category!.length > 1
                                  //         ? Container(
                                  //             padding:
                                  //                 const EdgeInsets.symmetric(
                                  //                     vertical: 2,
                                  //                     horizontal: 4),
                                  //             margin: const EdgeInsets.only(
                                  //                 left: 8),
                                  //             height: 24,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(2),
                                  //                 color:
                                  //                     const Color(0XFFEEEEEE)),
                                  //             child: Text(
                                  //               adviserProfileData
                                  //                       .category?[2].name ??
                                  //                   "",
                                  //               style: const TextStyle(
                                  //                   fontSize: 10,
                                  //                   fontFamily:
                                  //                       Constants.mainFont,
                                  //                   color: Color(0XFF444444)),
                                  //               textAlign: TextAlign.center,
                                  //             ),
                                  //           )
                                  //         : const SizedBox(),
                                  //     ///////// remaining tags
                                  //     adviserProfileData.category!.length > 2
                                  //         ? Container(
                                  //             padding: const EdgeInsets.all(2),
                                  //             margin: const EdgeInsets.only(
                                  //                 left: 8),
                                  //             height: 24,
                                  //             width: 24,
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(2),
                                  //                 color:
                                  //                     const Color(0XFFD9D9D9)),
                                  //             child: Text(
                                  //               "${adviserProfileData.category!.length - 3} + ",
                                  //               style: const TextStyle(
                                  //                   fontSize: 10,
                                  //                   fontFamily:
                                  //                       Constants.mainFont,
                                  //                   color: Color(0XFF444444)),
                                  //               textAlign: TextAlign.center,
                                  //             ),
                                  //           )
                                  //         : const SizedBox(),
                                  //   ],
                                  // )
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
                                    child: BlocConsumer<DoneAdviceCubit,
                                            DoneAdviceState>(
                                        listener: (context, doneState) {
                                          if (doneState is DoneAdviceLoaded) {
                                            MyApplication.navigateTo(
                                                context,
                                                RateScreen(
                                                  adviceId: adviceId,
                                                ));
                                          }
                                        },
                                        builder: (context, doneState) => doneState
                                                is DoneAdviceLoading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator.adaptive())
                                            : CustomElevatedButton(
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
                                  onPressedHandler: labelToShow == true
                                      ? () {}
                                      : () {
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
            width: double.infinity,
            decoration: BoxDecoration(
                color: Constants.whiteAppColor,
                borderRadius: BorderRadius.circular(6),

                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 18),
                      spreadRadius: -8,
                      blurStyle: BlurStyle.normal,
                      color: Constants.primaryAppColor.withOpacity(0.1)),
                ]),
            child: DottedBorder(
              color: Constants.primaryAppColor,
              strokeWidth: 1,
              dashPattern: const [10, 6],
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 6, right: 10, left: 10),
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
                        const SizedBox(width: 8),
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

                            SizedBox(
                              height: 26,
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
                                        adviserProfileData
                                                .category?[index].name ??
                                            "",
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
                                        (adviserProfileData.category?.length ??
                                                0) -
                                            3;
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
                                    adviserProfileData.category?.length ??
                                        0), // Ensure only 4 items are displayed
                              ),
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
                    const SizedBox(height: 8)
                  ],
                ),
              ),
            ),
          );
  }
}
