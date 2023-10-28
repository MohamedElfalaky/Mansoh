import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key, required this.payMethod, required this.walletVal});
  final String payMethod;
  final String walletVal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 8),
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
           Text(
             payMethod,
            style: Constants.secondaryTitleRegularFont,
          ),
          const Spacer(),
          RichText(
            text:  TextSpan(
                style: Constants.secondaryTitleRegularFont,
                children: [
                  TextSpan(
                      text: walletVal,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: " ريال سعودي")
                ]),
          )
        ],
      ),
    );
  }
}