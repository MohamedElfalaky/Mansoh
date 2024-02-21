import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/CompleteAdviseScreen/Components/complete_advisor_card.dart';
import 'package:nasooh/Presentation/screens/CompleteAdviseScreen/Components/payment_card.dart';
import 'package:nasooh/Presentation/screens/chat_screen/chat_screen.dart';
import 'package:nasooh/Presentation/widgets/my_button.dart';
import 'package:nasooh/Presentation/widgets/no_internet.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/my_application.dart';
import '../../../Data/cubit/authentication/get_by_token_cubit/get_by_token_cubit.dart';
import '../../../Data/cubit/authentication/get_by_token_cubit/get_by_token_state.dart';
import '../../../Data/cubit/show_advice_cubit/pay_advice_cubit/pay_advice_cubit.dart';
import '../../../Data/cubit/show_advice_cubit/pay_advice_cubit/pay_advice_state.dart';
import '../../../Data/cubit/show_advice_cubit/payment_list_cubit/payment_list_cubit.dart';
import '../../../Data/cubit/show_advice_cubit/payment_list_cubit/payment_list_state.dart';
import '../../../Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_cubit.dart';
import '../../../Data/cubit/show_advice_cubit/show_advice_cubit/show_advice_state.dart';
import '../../../app/Style/icons.dart';
import '../Home/home.dart';

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

      if (result != ConnectivityResult.none) {}
    });
    context
        .read<ShowAdviceCubit>()
        .getAdviceFunction(adviceId: widget.adviceId);
    // print("widget.adviceId is ${widget.adviceId}");
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
      MyApplication.showToastView(message: 'noInternet'.tr);
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => HomeLayout(
                      currentIndex: 1,
                    )),
          );

          return shouldPop;
        },
        child: Scaffold(
            floatingActionButton: BlocConsumer<PayAdviceCubit, PayAdviceState>(
                listener: (context, state) {
                  if (state is PayAdviceLoaded) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    MyApplication.navigateTo(
                        context,
                        ChatScreen(
                          statusClickable: false,
                          openedStatus:
                              // state.response!.data!.label!.id == 1 ||
                              state.response!.data!.label!.id == 2,
                          labelToShow: true,
                          adviceId: state.response!.data!.id!,
                          adviserProfileData: state.response!.data!.adviser,
                        ));
                    MyApplication.showToastView(
                        message: state.response?.data?.status?.name ?? "");
                  }
                },
                builder: (context, state) => state is PayAdviceLoading
                    ? const CircularProgressIndicator.adaptive()
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        child: MyButton(
                          onPressedHandler: () {
                            context.read<PayAdviceCubit>().getPay(
                                paymentId: 2, adviceId: widget.adviceId);
                          },
                          txt: "Complete Order".tr,
                          isBold: true,
                        ))),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            resizeToAvoidBottomInset: false,
            backgroundColor: Constants.whiteAppColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: AppBar(
                leading: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Container(
                          // margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                offset: Offset(0, 4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              MyApplication.navigateToReplaceAllPrevious(
                                  context,
                                  HomeLayout(
                                    currentIndex: 1,
                                  ));
                            },
                            icon: Get.locale!.languageCode == "ar"
                                ? SvgPicture.asset(
                                    backArIcon,
                                    width: 14,
                                    height: 14,
                                  )
                                : const Icon(
                                    Icons.arrow_back,
                                    color: Colors.black54,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                title: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text("Confirm Order".tr),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: BlocBuilder<PaymentListCubit, PaymentListState>(
                builder: (context, state) {
              if (state is PaymentListLoading) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
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
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                } else if (showAdviceState
                                    is ShowAdviceLoaded) {
                                  return CompleteAdvisorCard(
                                    adviser: showAdviceState
                                        .response!.data!.adviser!,
                                    moneyPut: showAdviceState
                                        .response!.data!.price
                                        .toString(),
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
                                if (getByTokenState is GetByTokenLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                } else if (getByTokenState
                                    is GetByTokenLoaded) {
                                  // print(
                                  //     ".response?.data? is ${getByTokenState.response?.data.toString()}");
                                  return Expanded(
                                    child: ListView.builder(
                                        itemCount:
                                            state.response?.data?.length ?? 0,
                                        itemBuilder: (context, int index) =>
                                            PaymentCard(
                                              payMethod: state.response
                                                      ?.data?[index].name ??
                                                  "",
                                              walletVal: getByTokenState
                                                      .response?.data?.wallet ??
                                                  "",
                                            )),
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
      ),
    );
  }
}
