import 'dart:math';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/Style/icons.dart';
import 'package:nasooh/app/constants.dart';
import '../../../../Data/models/advisor_profile_model/advisor_profile.dart';
import '../../../../app/Style/sizes.dart';

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
                backgroundImage: NetworkImage(
                  adviser.avatar!='' && adviser.avatar!=null ?adviser.avatar! :
                      "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAM1BMVEXk5ueutLfn6eqrsbTp6+zg4uOwtrnJzc/j5earsbW0uby4vcDQ09XGyszU19jd3+G/xMamCvwDAAAFLklEQVR4nO2d2bLbIAxAbYE3sDH//7WFbPfexG4MiCAcnWmnrzkjIRaD2jQMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMw5wQkHJczewxZh2lhNK/CBOQo1n0JIT74/H/qMV0Z7GU3aCcVPuEE1XDCtVLAhgtpme7H0s1N1U7QjO0L8F7llzGeh1hEG/8Lo7TUmmuSrOfns9xnGXpXxsONPpA/B6OqqstjC6Ax/0ujkNdYQQbKNi2k64qiiEZ+ohi35X+2YcZw/WujmslYewiAliVYrxgJYrdwUmwXsU+RdApUi83oNIE27YvrfB/ZPg8+BJETXnqh9CVzBbTQHgojgiCvtqU9thFJg/CKz3VIMKMEkIXxIWqIpIg2SkjYj+xC816mrJae2aiWGykxRNsW0UwiJghJDljYI5CD8GRiCtIsJxizYUPQ2pzItZy5pcisTRdk/a9m4amtNNfBuQkdVhSaYqfpNTSFGfb9GRIakrE2Pm+GFLaCQPqiu0OpWP+HMPQQcgQMiQprWXNmsVwIjQjYi/ZrhAqNTCgr2gu0Jnz85RSSjso0HkMFZ0YZjKkc26a/jlmh9JiDyDxi9oeorTYAzZkwwoMz19pzj9bnH/GP/+qbchjSGflneWYhtTuKdMOmNKZcJ5TjInQKcYXnESd/jQxy0ENpULTNGOGgxpap/oyw9pbUAqhfx2Dbkhovvfgz4iUzoM9+GlK6/Mh4q29hyC1mwro30hpVVLPF9wYQr71RazOeM5/cw81iBRD+A03aM9/C/obbrKjbYSpCmIVG3qT/Q8oeUo3Rz0IL7vI1tEbCB9pSiu8I/aV8x3Kg/BGWrWp4ZVs0nZfmAoEG4h/61yHYIJiFSl6Q0Vk6tTW1N8kYp8hdOkfHYYMXd2Qft+8CYwqYDSKvqIh+MCF8Wgca2u/cwdgeW3TtuVn6+1oBs3yLo5C2JpK6CvQzGpfUkz9UG/87gCsi5o2LIXolxN0FbwAsjOLEr+YJmXn7iR6N0BCt5p5cMxm7eAsfS+/CACQf4CTpKjzgkvr2cVarVTf96372yut7XLJ1sa7lv6VcfgYrWaxqr3Wlo1S6pvStr22sxOtTNPLzdY3nj20bPP+ejFdJYkLsjGLdtPBEbe/mr2bQKiXWJDroA+vtzc0p9aahuwqHMDYrQEXHEw9jwQl3drMpts9JBU1SdktPe5FBRdJQ6bwXBpa57ib2A8kukQDzMjh++Uo7Fo6Wd02Pkf4fknqoo4HtvAIjsqUcjx6DIPgWCaOML9rKI/oqD9/lgNrn+eF+p7j8tnzHBiR7+kdUGw/+V1Kzkc75mMy6U+FMaxjPibiM1U1uGM+puInHpmALZCgP4pt7i840MV8+0R1zPsRB6UTcqpizncYwZ89syDydfyWCwXB1l8/zRNGWbTG/GHKUm9AkxHMc/EGSk3z2+ArEhPEV5TUBLEvUGFcjEUH80J/jveTGOAJEljJbILWGQT3zRYiwuKsUXN1EEJAzBhRJFll7mBUG7KD8EqPkKekBREaL8hMDZLQSG6AQjtHPYmvTQnX0TtpC1SYCe2YdkkyLP3jj5BSbKiuR585eQhTgoje6yIb0Yb0C+mV6EYvebqw5SDy2WmubogZiF2AVxPC2FpDf8H2Q9QWo6IkjUxTWVEI3WY/wrCeSuqJ+eRWzXR/JXwgVjUMozbCOfoEZiSiKVGepqv5CJ8RyR4D7xBeamqa7z3BJ/z17JxuBPdv93d/a2Ki878MMAzDMAzDMAzDMAzDMF/KP09VUmxBAiI3AAAAAElFTkSuQmCC",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adviser.fullName ?? "",
                    style: Constants.secondaryTitleFont,
                  ),
                  Text(
                    adviser.description ?? "لا يوجد وصف لهذا الناصح",
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
                              adviser.category?[index].name ?? "",
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
                              (adviser.category?.length ?? 0) - 3;
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
                          adviser.category?.length ??
                              0), // Ensure only 4 items are displayed
                    ),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    adviser.rate ?? "",
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
            height: 24,
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
                    text: TextSpan(children: [
                  TextSpan(text: moneyPut, style: Constants.subtitleFontBold),
                  const TextSpan(
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
                    text: TextSpan(children: [
                  TextSpan(text: taxVal, style: Constants.subtitleFontBold),
                  const TextSpan(
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
                  "الاجمالي",
                  style: Constants.subtitleRegularFont,
                ),
                RichText(
                    text: TextSpan(
                        style: Constants.subtitleRegularFont,
                        children: [
                      TextSpan(
                          text: '${double.parse(moneyPut)+double.parse(taxVal)}',
                          style: const TextStyle(
                              color: Constants.primaryAppColor,
                              fontWeight: FontWeight.bold)),
                      const TextSpan(
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
