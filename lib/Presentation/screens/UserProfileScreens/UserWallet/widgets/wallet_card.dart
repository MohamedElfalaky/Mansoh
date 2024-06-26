import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../app/constants.dart';

class WalletCard extends StatelessWidget {
  final String description;
  final String oneTraBalance;
  final String title;

  const WalletCard({
    super.key,
    required this.description,
    required this.title,
    required this.oneTraBalance,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey, width: 0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/SVGs/wallet.svg",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                       Text(
                       title,
                       style: Constants.secondaryTitleFont,
                     )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "$oneTraBalance  ريال سعودي ",
                    style: Constants.secondaryTitleFont.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14
                    ),
                  ),

                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: Constants.subtitleRegularFont,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
