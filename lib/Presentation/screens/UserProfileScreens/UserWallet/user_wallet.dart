import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/wallet_cubit/wallet_cubit.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import '../../../../Data/cubit/wallet_cubit/wallet_state.dart';
import '../../../../app/constants.dart';
import '../../../../app/utils/my_application.dart';
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
      child: Scaffold(
        appBar: customAppBar(context: context, txt: "My Wallet".tr),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            if (state is WalletLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is WalletLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
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
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: ListView.builder(

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
                        ),
                      )
                    ],
                  ),
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
