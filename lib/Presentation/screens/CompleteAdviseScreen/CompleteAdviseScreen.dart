import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/Presentation/screens/CompleteAdviseScreen/Components/CompleteAdvisorCard.dart';
import 'package:nasooh/Presentation/screens/CompleteAdviseScreen/Components/PaymentCard.dart';
import 'package:nasooh/Presentation/screens/Home/Home.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/Presentation/widgets/MyButton.dart';
import 'package:nasooh/Presentation/widgets/noInternet.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';
import '../../../Data/cubit/authentication/get_by_token_cubit/get_by_token_cubit.dart';
import '../../../Data/cubit/authentication/get_by_token_cubit/get_by_token_state.dart';
import '../../../Data/cubit/show_advice_cubit/pay_advice_cubit/pay_advice_cubit.dart';
import '../../../Data/cubit/show_advice_cubit/pay_advice_cubit/pay_advice_state.dart';
import '../../../Data/cubit/show_advice_cubit/payment_list_cubit/payment_list_cubit.dart';
import '../../../Data/cubit/show_advice_cubit/payment_list_cubit/payment_list_state.dart';
import '../../../Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_cubit.dart';
import '../../../Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_state.dart';
import '../../../app/utils/lang/language_constants.dart';

class CompleteAdviseScreen extends StatefulWidget {
  const CompleteAdviseScreen({
    super.key,
    required this.adviceId,
  });

  final int adviceId;

  @override
  State<CompleteAdviseScreen> createState() => _CompleteAdviseScreenState();
}

class _CompleteAdviseScreenState extends State<CompleteAdviseScreen> {
  // AdvisorController AdvisorController = AdvisorController();
  late StreamSubscription<ConnectivityResult> _subscription;
  bool? isConnected;

  @override
  void initState() {
    super.initState();

    MyApplication.checkConnection().then((value) {
      if (value) {
        //////
        // todo recall data
        ///
        ///
        ///
        ///
      } else {
        MyApplication.showToastView(
            message: '${getTranslated(context, 'noInternet')}');
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

      /// if internet comes back
      if (result != ConnectivityResult.none) {
        /// call your apis
        // todo recall data
        ///
        ///
        ///
        ///
      }
    });
    context.read<ShowAdviceCubit>().getPay(adviceId: widget.adviceId);
    print("widget.adviceId is ${widget.adviceId}");
    context.read<PaymentListCubit>().getPay();
    context.read<GetByTokenCubit>().getDataGetByToken();
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
      MyApplication.showToastView(
          message: '${getTranslated(context, 'noInternet')}');
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      }, // hide keyboard on tap anywhere

      child: Scaffold(
          floatingActionButton: BlocConsumer<PayAdviceCubit, PayAdviceState>(
              listener: (context, state) {
                if (state is PayAdviceLoaded) {
                  // MyApplication.navigateTo(
                  //     context,
                  //     CompleteAdviseScreen(
                  //       adviceId: state.response!.data!.id.toString(),
                  //       // imagePhoto: widget.imagePhoto,
                  //       // name: widget.name,
                  //       // id: widget.id,
                  //     ));
                  // MyApplication.showToastView(
                  //     message: state.response?.data?.status?.name??""
                  //     );
                }
              },


              builder: (context, state) => state is PayAdviceLoading
                  ? const CircularProgressIndicator()
                  :
              Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              child: MyButton(
                onPressedHandler: () {
                  context.read<PayAdviceCubit>().getPay(
                     paymentId: 1,adviceId: widget.adviceId
                      );
                },
                txt: "إتمام الطلب",
                isBold: true,
              ))),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          resizeToAvoidBottomInset: false,
          backgroundColor: Constants.whiteAppColor,
          appBar: customAppBar(txt: "تأكيد الطلب", context: context),
          body: BlocBuilder<PaymentListCubit, PaymentListState>(
              builder: (context, state) {
            if (state is PaymentListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PaymentListLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        color: Constants.whiteAppColor,
                        height: MediaQuery.of(context).size.height,
                        margin: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<ShowAdviceCubit, ShowAdviceState>(
                                builder: (context, showAdviceState) {
                              if (showAdviceState is ShowAdviceLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (showAdviceState is ShowAdviceLoaded) {
                                return CompleteAdvisorCard(
                                  imagePhoto: showAdviceState
                                          .response?.data?.adviser?.avatar ??
                                      "",
                                  name: showAdviceState
                                          .response?.data?.adviser?.fullName ??
                                      "",
                                  moneyPut:
                                      showAdviceState.response?.data?.price ??
                                          "",
                                  taxVal: showAdviceState.response?.data?.tax
                                          ?.toStringAsFixed(2) ??
                                      "",
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8, top: 4),
                              child: Text(
                                "اختر وسيلة الدفع",
                                style: Constants.headerNavigationFont,
                              ),
                            ),
                            BlocBuilder<GetByTokenCubit, GetByTokenState>(
                                builder: (context, getByTokenState) {
                              // if (showAdviceState is ShowAdviceLoading) {
                              //   return const Center(
                              //     child: CircularProgressIndicator(),
                              //   );
                              // } else
                                if (getByTokenState is GetByTokenLoaded) {
                                print(
                                    ".response?.data? is ${getByTokenState.response?.data?.wallet}");
                                return PaymentCard(
                                  payMethod:
                                      state.response?.data?[0].name ?? "",
                                  walletVal: getByTokenState.response?.data?.wallet??"",
                                );
                              } else {
                                return const SizedBox();
                              }
                            })
                            // state.response!.data!.map((e) => PaymentCard(payMethod: e.name??"",)).toList()
                          ],
                        )),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          })),
    );
  }
}
