import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F4F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            tempPic,
            height: 30,
          ),
          const SizedBox(
            width: 8,
          ),
          const Text(
            "المحفظة",
            style: Constants.secondaryTitleRegularFont,
          ),
          const Spacer(),
          RichText(
            text: const TextSpan(
                style: Constants.secondaryTitleRegularFont,
                children: [
                  TextSpan(
                      text: "120 ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: "ريال سعودي")
                ]),
          )
        ],
      ),
    );
  }
}
