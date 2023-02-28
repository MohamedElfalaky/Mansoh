import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../app/constants.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    Key? key,
  }) : super(key: key);

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
                      const Text(
                        "استرجاع",
                        style: Constants.secondaryTitleFont,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    "1000 ريال سعودي",
                    style: Constants.secondaryTitleFont,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "عملية استرجاع النقود من طلب رقم #6782867",
                  style: Constants.subtitleRegularFont,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
