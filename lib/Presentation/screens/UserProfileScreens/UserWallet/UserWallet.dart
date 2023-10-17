import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/wallet_cubit/wallet_cubit.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import '../../../../Data/cubit/wallet_cubit/wallet_state.dart';
import '../../../../app/constants.dart';
import '../../../../app/utils/myApplication.dart';
import '../../../widgets/noInternet.dart';
import '../UserProfileEdit/widgets/shared.dart';
import 'widgets/WalletCard.dart';

class UserWallet extends StatefulWidget {
  const UserWallet({super.key});

  @override
  State<UserWallet> createState() => _UserWalletState();
}

class _UserWalletState extends State<UserWallet> {
  late StreamSubscription<ConnectivityResult> _subscription;
  bool? isConnected;

  @override
  void initState() {
    super.initState();

    MyApplication.checkConnection().then((value) {
      if (value) {
        context.read<WalletCubit>().getDataWallet();
      } else {
        MyApplication.showToastView(message: 'noInternet'.tr);
      }
    });

    // todo subscribe to internet change
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (mounted) {
        setState(() {
          result == ConnectivityResult.none
              ? isConnected = false
              : isConnected = true;
        });
      }

      if (result != ConnectivityResult.none) {
        context.read<WalletCubit>().getDataWallet();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // todo if not connected display nointernet widget else continue to the rest build code
    final sizee = MediaQuery.of(context).size;
    if (isConnected == null) {
      MyApplication.checkConnection().then((value) {
        setState(() {
          isConnected = value;
        });
      });
    } else if (!isConnected!) {
      MyApplication.showToastView(message: 'noInternet'.tr);
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      }, // hide keyboard on tap anywhere
      child: Scaffold(
          appBar: customAppBar(context: context, txt: "My Wallet".tr),
          floatingActionButton: buildSaveButton(label: "recharge_wallet"),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          resizeToAvoidBottomInset: false,
          body:
              BlocBuilder<WalletCubit, WalletState>(builder: (context, state) {
            if (state is WalletLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WalletLoaded) {
              // print(state.response!.transaction.toString());
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
                      const SizedBox(
                        height: 40,
                      ),
                      Expanded(
                        // height: MediaQuery.of(context).size.height * 0.6,
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
            } else if (state is WalletError) {
              return const Center(child: Text('error'));
            } else {
              return const Center(child: Text('....'));
            }
          })),
    );
  }
}
