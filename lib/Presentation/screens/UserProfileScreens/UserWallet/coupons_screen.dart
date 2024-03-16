import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nasooh/Data/cubit/coupons_cubit/coupons_cubit.dart';
import 'package:nasooh/Data/cubit/coupons_cubit/coupons_state.dart';

import '../../../../app/constants.dart';
import '../../../widgets/shared.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  late CouponsCubit couponsCubit;

  @override
  void initState() {
    super.initState();
    couponsCubit = context.read<CouponsCubit>();
    couponsCubit.getPromoCodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, txt: "promo_codes".tr),
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: BlocBuilder<CouponsCubit, CouponsState>(
        builder: (context, state) {
          if (state is CouponsDone) {
            if (state.couponsModel.data?.isEmpty == true) {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 70),
                child: Text('لا يوجد كوبونات خصم', style: TextStyle(fontFamily: Constants.mainFont, fontWeight: FontWeight.w700, fontSize: 14)),
              ));
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(
                      Icons.monetization_on,
                      color: Constants.primaryAppColor,
                    ),
                    title: Text(
                      'كود الخصم ${state.couponsModel.data?[index].code}',
                      style: const TextStyle(
                          fontFamily: Constants.mainFont,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                    subtitle: Text(
                        'قيمة الخصم ${state.couponsModel.data?[index].balance} ريال سعودي ',
                        style: const TextStyle(
                            fontFamily: Constants.mainFont,
                            fontWeight: FontWeight.w500,
                            fontSize: 10)),
                  );
                },
                itemCount: state.couponsModel.data?.length,
              );
            }
          } else if (state is CouponsLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
