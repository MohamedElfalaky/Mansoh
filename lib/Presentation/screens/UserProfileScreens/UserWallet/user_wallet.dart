import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/wallet_cubit/wallet_cubit.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import '../../../../Data/cubit/wallet_cubit/wallet_state.dart';
import '../../../../app/constants.dart';
import '../../../../app/utils/my_application.dart';
import '../../../widgets/my_button.dart';
import 'widgets/wallet_card.dart';

class UserWallet extends StatefulWidget {
  const UserWallet({super.key});

  @override
  State<UserWallet> createState() => _UserWalletState();
}

class _UserWalletState extends State<UserWallet> {
  @override
  void initState() {
    super.initState();

    context.read<WalletCubit>().getDataWallet();
  }

  TextEditingController couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
      child: Scaffold(
        appBar: customAppBar(context: context, txt: "My Wallet".tr),
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            if (state is WalletLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is WalletLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: TextField(
                        cursorWidth: 1,
                        cursorOpacityAnimates: false,
                        controller: couponController,
                        decoration: const InputDecoration(
                            hintText: 'برجاء كتابة كود الخصم',
                            hintStyle: TextStyle(
                              fontFamily: Constants.mainFont,
                              fontSize: 12,
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderSide:
                                  BorderSide(color: Constants.primaryAppColor),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderSide:
                                  BorderSide(color: Constants.primaryAppColor),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: CustomElevatedButton(
                          txt: 'تطبيق',
                          onPressedHandler: () {
                            context
                                .read<WalletCubit>()
                                .getPromoCode(promoCode: couponController.text);
                          }),
                    ),
                    Text(
                      "total_balance".tr,
                      style: Constants.secondaryTitleRegularFont,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${state.response!.balance}  ريال سعودي ",
                      style: Constants.headerNavigationFont.copyWith(
                        color: Constants.primaryAppColor,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 40),
                        itemCount: state.response!.transaction?.length ?? 0,
                        itemBuilder: (context, index) {
                          return WalletCard(
                            description: state.response?.transaction?[index]
                                    .description ??
                                "",
                            oneTraBalance: state
                                    .response?.transaction?[index].balance
                                    .toString() ??
                                "",
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
