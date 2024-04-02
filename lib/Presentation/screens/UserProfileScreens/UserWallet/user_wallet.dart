import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/wallet_cubit/wallet_cubit.dart';
import 'package:nasooh/Presentation/screens/UserProfileScreens/UserWallet/coupons_screen.dart';
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
    return Scaffold(
      appBar: customAppBar(
          endIcon: true,
          context: context, txt: "My Wallet".tr, actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.primaryAppColor,
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
              onPressed: () {
                MyApplication.navigateTo(context, const CouponsScreen());
              },
              child: const Text(' كوبونات الخصم',style: TextStyle(
                color: Colors.white,
                fontFamily: Constants.mainFont,
                fontSize: 12,
                fontWeight: FontWeight.w700
              ),textAlign: TextAlign.center,)),
        )
      ]),
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
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
                      ),
                    ),
                  ),
                  if(state is GetCouponsLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: CustomLoadingButton(),
                    )
                    else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CustomElevatedButton(
                        txt: 'تطبيق',
                        onPressedHandler: () {
                          if (couponController.text != '') {
                            context.read<WalletCubit>().getPromoCode(
                                promoCode: couponController.text);
                          }
                          couponController.clear();
                        }),
                  ),
                  if(state is WalletLoaded)
                    ...
                    [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "total_balance".tr,
                              style: Constants.secondaryTitleRegularFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                           Text("${state.response?.balance ?? 0} ريال سعودي",
                              style: Constants.headerNavigationFont.copyWith(
                                color: Constants.primaryAppColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 40,top: 10),
                          itemCount: state.response?.transaction?.length ?? 0,
                          itemBuilder: (context, index) {
                            return WalletCard(
                              title: 'استرجاع رصيد المحفظة',
                              //todo
                              // title: '${state.response?.transaction?[index].balance}',
                                description:
                                '${state.response?.transaction?[index].description}',
                                oneTraBalance:
                                '${state.response?.transaction?[index].balance}');
                          },
                        ),
                      )
                    ]
                ],
              ),
            );

         },
      ),
    );
  }
}
