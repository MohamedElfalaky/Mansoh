import 'package:flutter/material.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';

import '../../../../app/constants.dart';
import '../../../../app/utils/lang/language_constants.dart';
import '../../../../app/utils/myApplication.dart';
import '../UserProfileEdit/widgets/shared.dart';
import 'widgets/WalletCard.dart';

class UserWallet extends StatefulWidget {
  const UserWallet({super.key});

  @override
  State<UserWallet> createState() => _UserWalletState();
}

class _UserWalletState extends State<UserWallet> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          MyApplication.dismissKeyboard(context);
        },
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: buildSaveButton("recharge_wallet"),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Back(header: "wallet"),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      getTranslated(context, "total_balance")!,
                      style: Constants.secondaryTitleRegularFont,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "2000 ريال سعودي",
                      style: Constants.headerNavigationFont.copyWith(
                        color: Constants.primaryAppColor,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      // height: MediaQuery.of(context).size.height * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const WalletCard();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
