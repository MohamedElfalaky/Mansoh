import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nasooh/Presentation/screens/CompleteAdviseScreen/Components/complete_advisor_card.dart';
import 'package:nasooh/Presentation/screens/CompleteAdviseScreen/Components/payment_card.dart';
import 'package:nasooh/Presentation/screens/chat_screen/chat_screen.dart';
import 'package:nasooh/Presentation/screens/fatorah/fatorah_screen.dart';
import 'package:nasooh/Presentation/widgets/my_button.dart';
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
// import '../../../app/Style/icons.dart';
import '../../../app/style/icons.dart';

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
  @override
  void initState() {
    super.initState();

    context
        .read<ShowAdviceCubit>()
        .getAdviceFunction(adviceId: widget.adviceId);
    context.read<PaymentListCubit>().getPay();
    context.read<GetByTokenCubit>().getDataGetByToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BlocConsumer<PayAdviceCubit, PayAdviceState>(
            listener: (context, state) {
              if (state is PayAdviceLoaded) {
                MyApplication.navigateToReplace(
                    context,
                    ChatScreen(
                      description:
                          state.response?.data?.adviser?.description ?? '',
                      statusClickable: false,
                      openedStatus: state.response?.data?.label?.id == 2,
                      labelToShow: true,
                      adviceId: state.response?.data?.id ?? 0,
                      adviserProfileData: state.response?.data?.adviser,
                    ));
              }
            },
            builder: (context, state) => state is PayAdviceLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    height: 50,
                    child: CustomElevatedButton(
                      onPressedHandler: () {
                        context
                            .read<PayAdviceCubit>()
                            .getPay(paymentId: 2, adviceId: widget.adviceId);
                      },
                      txt: "Complete Order".tr,
                      isBold: true,
                    ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.whiteAppColor,
        appBar: AppBar(
          leading: Row(
            children: [
              const SizedBox(width: 16),
              Container(
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
                    Navigator.pop(context);
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
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text("Confirm Order".tr),
          ),
        ),
        body: BlocBuilder<PaymentListCubit, PaymentListState>(
            builder: (context, state) {
          if (state is PaymentListLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is PaymentListLoaded) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
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
                    } else if (showAdviceState is ShowAdviceLoaded) {
                      return CompleteAdvisorCard(
                        adviser: showAdviceState.response!.data!.adviser!,
                        moneyPut:
                            showAdviceState.response!.data!.price.toString(),
                        taxVal: showAdviceState.response?.data?.tax ?? "",
                      );
                    }
                    return const SizedBox.shrink();
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
                    } else if (getByTokenState is GetByTokenLoaded) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.response?.data?.length ?? 0,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {
                                MyApplication.navigateTo(
                                    context, const FatooraScreen(amount: 10));
                              },
                              child: PaymentCard(
                                payMethod:
                                    state.response?.data?[index].name ?? "",
                                walletVal:
                                    getByTokenState.response?.data?.wallet ??
                                        "",
                              ),
                            );
                          });
                    }
                    return const SizedBox.shrink();
                  })
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }));
  }
}
