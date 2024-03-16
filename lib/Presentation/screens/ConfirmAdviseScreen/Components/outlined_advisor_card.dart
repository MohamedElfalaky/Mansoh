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
    print(adviserProfileData.avatar);
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
                                  adviserProfileData.avatar != '' &&
                                          adviserProfileData.avatar != null
                                      ? adviserProfileData.avatar!
                                      : "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAM1BMVEXk5ueutLfn6eqrsbTp6+zg4uOwtrnJzc/j5earsbW0uby4vcDQ09XGyszU19jd3+G/xMamCvwDAAAFLklEQVR4nO2d2bLbIAxAbYE3sDH//7WFbPfexG4MiCAcnWmnrzkjIRaD2jQMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMw5wQkHJczewxZh2lhNK/CBOQo1n0JIT74/H/qMV0Z7GU3aCcVPuEE1XDCtVLAhgtpme7H0s1N1U7QjO0L8F7llzGeh1hEG/8Lo7TUmmuSrOfns9xnGXpXxsONPpA/B6OqqstjC6Ax/0ujkNdYQQbKNi2k64qiiEZ+ohi35X+2YcZw/WujmslYewiAliVYrxgJYrdwUmwXsU+RdApUi83oNIE27YvrfB/ZPg8+BJETXnqh9CVzBbTQHgojgiCvtqU9thFJg/CKz3VIMKMEkIXxIWqIpIg2SkjYj+xC816mrJae2aiWGykxRNsW0UwiJghJDljYI5CD8GRiCtIsJxizYUPQ2pzItZy5pcisTRdk/a9m4amtNNfBuQkdVhSaYqfpNTSFGfb9GRIakrE2Pm+GFLaCQPqiu0OpWP+HMPQQcgQMiQprWXNmsVwIjQjYi/ZrhAqNTCgr2gu0Jnz85RSSjso0HkMFZ0YZjKkc26a/jlmh9JiDyDxi9oeorTYAzZkwwoMz19pzj9bnH/GP/+qbchjSGflneWYhtTuKdMOmNKZcJ5TjInQKcYXnESd/jQxy0ENpULTNGOGgxpap/oyw9pbUAqhfx2Dbkhovvfgz4iUzoM9+GlK6/Mh4q29hyC1mwro30hpVVLPF9wYQr71RazOeM5/cw81iBRD+A03aM9/C/obbrKjbYSpCmIVG3qT/Q8oeUo3Rz0IL7vI1tEbCB9pSiu8I/aV8x3Kg/BGWrWp4ZVs0nZfmAoEG4h/61yHYIJiFSl6Q0Vk6tTW1N8kYp8hdOkfHYYMXd2Qft+8CYwqYDSKvqIh+MCF8Wgca2u/cwdgeW3TtuVn6+1oBs3yLo5C2JpK6CvQzGpfUkz9UG/87gCsi5o2LIXolxN0FbwAsjOLEr+YJmXn7iR6N0BCt5p5cMxm7eAsfS+/CACQf4CTpKjzgkvr2cVarVTf96372yut7XLJ1sa7lv6VcfgYrWaxqr3Wlo1S6pvStr22sxOtTNPLzdY3nj20bPP+ejFdJYkLsjGLdtPBEbe/mr2bQKiXWJDroA+vtzc0p9aahuwqHMDYrQEXHEw9jwQl3drMpts9JBU1SdktPe5FBRdJQ6bwXBpa57ib2A8kukQDzMjh++Uo7Fo6Wd02Pkf4fknqoo4HtvAIjsqUcjx6DIPgWCaOML9rKI/oqD9/lgNrn+eF+p7j8tnzHBiR7+kdUGw/+V1Kzkc75mMy6U+FMaxjPibiM1U1uGM+puInHpmALZCgP4pt7i840MV8+0R1zPsRB6UTcqpizncYwZ89syDydfyWCwXB1l8/zRNGWbTG/GHKUm9AkxHMc/EGSk3z2+ArEhPEV5TUBLEvUGFcjEUH80J/jveTGOAJEljJbILWGQT3zRYiwuKsUXN1EEJAzBhRJFll7mBUG7KD8EqPkKekBREaL8hMDZLQSG6AQjtHPYmvTQnX0TtpC1SYCe2YdkkyLP3jj5BSbKiuR585eQhTgoje6yIb0Yb0C+mV6EYvebqw5SDy2WmubogZiF2AVxPC2FpDf8H2Q9QWo6IkjUxTWVEI3WY/wrCeSuqJ+eRWzXR/JXwgVjUMozbCOfoEZiSiKVGepqv5CJ8RyR4D7xBeamqa7z3BJ/z17JxuBPdv93d/a2Ki878MMAzDMAzDMAzDMAzDMF/KP09VUmxBAiI3AAAAAElFTkSuQmCC",
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
                                    adviserProfileData.description ?? "لا يوجد وصف لهذا الناصح",
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
                                  ),
                                  Row(
                                    children: [
                                      adviserProfileData.category!.isNotEmpty
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 4),
                                              margin: const EdgeInsets.only(
                                                  left: 8),
                                              height: 24,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color:
                                                      const Color(0XFFEEEEEE)),
                                              child: Text(
                                                adviserProfileData
                                                        .category?[0].name ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontFamily:
                                                        Constants.mainFont,
                                                    color: Color(0XFF444444)),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : const SizedBox(),
                                      adviserProfileData.category!.length > 0
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 4),
                                              margin: const EdgeInsets.only(
                                                  left: 8),
                                              height: 24,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color:
                                                      const Color(0XFFEEEEEE)),
                                              child: Text(
                                                adviserProfileData
                                                        .category?[1].name ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontFamily:
                                                        Constants.mainFont,
                                                    color: Color(0XFF444444)),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : const SizedBox(),
                                      adviserProfileData.category!.length > 1
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 4),
                                              margin: const EdgeInsets.only(
                                                  left: 8),
                                              height: 24,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color:
                                                      const Color(0XFFEEEEEE)),
                                              child: Text(
                                                adviserProfileData
                                                        .category?[2].name ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontFamily:
                                                        Constants.mainFont,
                                                    color: Color(0XFF444444)),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : const SizedBox(),
                                      ///////// remaining tags
                                      adviserProfileData.category!.length > 2
                                          ? Container(
                                              padding: const EdgeInsets.all(2),
                                              margin: const EdgeInsets.only(
                                                  left: 8),
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color:
                                                      const Color(0XFFD9D9D9)),
                                              child: Text(
                                                "${adviserProfileData.category!.length - 3} + ",
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontFamily:
                                                        Constants.mainFont,
                                                    color: Color(0XFF444444)),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : const SizedBox(),
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
                                        builder: (context, doneState) =>
                                            doneState is DoneAdviceLoading
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator
                                                            .adaptive())
                                                : CustomElevatedButton(
                                                    isBold: true,
                                                    txt: "استلام",
                                                    onPressedHandler: () {
                                                      context
                                                          .read<
                                                              DoneAdviceCubit>()
                                                          .done(
                                                              context: context,
                                                              adviceId:
                                                                  adviceId);
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
                            adviserProfileData.avatar != '' &&
                                adviserProfileData.avatar != null
                                ? adviserProfileData.avatar!
                                : "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAM1BMVEXk5ueutLfn6eqrsbTp6+zg4uOwtrnJzc/j5earsbW0uby4vcDQ09XGyszU19jd3+G/xMamCvwDAAAFLklEQVR4nO2d2bLbIAxAbYE3sDH//7WFbPfexG4MiCAcnWmnrzkjIRaD2jQMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMw5wQkHJczewxZh2lhNK/CBOQo1n0JIT74/H/qMV0Z7GU3aCcVPuEE1XDCtVLAhgtpme7H0s1N1U7QjO0L8F7llzGeh1hEG/8Lo7TUmmuSrOfns9xnGXpXxsONPpA/B6OqqstjC6Ax/0ujkNdYQQbKNi2k64qiiEZ+ohi35X+2YcZw/WujmslYewiAliVYrxgJYrdwUmwXsU+RdApUi83oNIE27YvrfB/ZPg8+BJETXnqh9CVzBbTQHgojgiCvtqU9thFJg/CKz3VIMKMEkIXxIWqIpIg2SkjYj+xC816mrJae2aiWGykxRNsW0UwiJghJDljYI5CD8GRiCtIsJxizYUPQ2pzItZy5pcisTRdk/a9m4amtNNfBuQkdVhSaYqfpNTSFGfb9GRIakrE2Pm+GFLaCQPqiu0OpWP+HMPQQcgQMiQprWXNmsVwIjQjYi/ZrhAqNTCgr2gu0Jnz85RSSjso0HkMFZ0YZjKkc26a/jlmh9JiDyDxi9oeorTYAzZkwwoMz19pzj9bnH/GP/+qbchjSGflneWYhtTuKdMOmNKZcJ5TjInQKcYXnESd/jQxy0ENpULTNGOGgxpap/oyw9pbUAqhfx2Dbkhovvfgz4iUzoM9+GlK6/Mh4q29hyC1mwro30hpVVLPF9wYQr71RazOeM5/cw81iBRD+A03aM9/C/obbrKjbYSpCmIVG3qT/Q8oeUo3Rz0IL7vI1tEbCB9pSiu8I/aV8x3Kg/BGWrWp4ZVs0nZfmAoEG4h/61yHYIJiFSl6Q0Vk6tTW1N8kYp8hdOkfHYYMXd2Qft+8CYwqYDSKvqIh+MCF8Wgca2u/cwdgeW3TtuVn6+1oBs3yLo5C2JpK6CvQzGpfUkz9UG/87gCsi5o2LIXolxN0FbwAsjOLEr+YJmXn7iR6N0BCt5p5cMxm7eAsfS+/CACQf4CTpKjzgkvr2cVarVTf96372yut7XLJ1sa7lv6VcfgYrWaxqr3Wlo1S6pvStr22sxOtTNPLzdY3nj20bPP+ejFdJYkLsjGLdtPBEbe/mr2bQKiXWJDroA+vtzc0p9aahuwqHMDYrQEXHEw9jwQl3drMpts9JBU1SdktPe5FBRdJQ6bwXBpa57ib2A8kukQDzMjh++Uo7Fo6Wd02Pkf4fknqoo4HtvAIjsqUcjx6DIPgWCaOML9rKI/oqD9/lgNrn+eF+p7j8tnzHBiR7+kdUGw/+V1Kzkc75mMy6U+FMaxjPibiM1U1uGM+puInHpmALZCgP4pt7i840MV8+0R1zPsRB6UTcqpizncYwZ89syDydfyWCwXB1l8/zRNGWbTG/GHKUm9AkxHMc/EGSk3z2+ArEhPEV5TUBLEvUGFcjEUH80J/jveTGOAJEljJbILWGQT3zRYiwuKsUXN1EEJAzBhRJFll7mBUG7KD8EqPkKekBREaL8hMDZLQSG6AQjtHPYmvTQnX0TtpC1SYCe2YdkkyLP3jj5BSbKiuR585eQhTgoje6yIb0Yb0C+mV6EYvebqw5SDy2WmubogZiF2AVxPC2FpDf8H2Q9QWo6IkjUxTWVEI3WY/wrCeSuqJ+eRWzXR/JXwgVjUMozbCOfoEZiSiKVGepqv5CJ8RyR4D7xBeamqa7z3BJ/z17JxuBPdv93d/a2Ki878MMAzDMAzDMAzDMAzDMF/KP09VUmxBAiI3AAAAAElFTkSuQmCC",
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
                              adviserProfileData.description !="" && adviserProfileData.description!=null?adviserProfileData.description!:
                              "لا يوجد وصف لهذا الناصح",
                              style: Constants.subtitleFont,
                            ),
                            const SizedBox(
                              height: 8),
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
                                itemCount:adviserProfileData.category?.length, // Ensure only 4 items are displayed
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
