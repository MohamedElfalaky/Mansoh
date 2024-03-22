import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../Data/models/orders_models/orders_filter_model.dart';
import '../../../../../app/constants.dart';
import '../../UserProfileEdit/widgets/shared.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.orderFilterData});

  final OrderFilterData orderFilterData;

  @override
  Widget build(BuildContext context) {
    // print('order card ${orderFilterData.adviser?.fullName}');
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            side:
                const BorderSide(color: Constants.primaryAppColor, width: 0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 280,
                          child: Text(
                            orderFilterData.name ?? "",
                            style: Constants.secondaryTitleFont.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          orderFilterData.date ?? "لا يوجد تاريخ",
                          style: Constants.subtitleRegularFont
                              .copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 55),
                      child: Text(
                        '# ${orderFilterData.id}',
                        style: Constants.subtitleRegularFont.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(children: [
                  SvgPicture.asset('assets/images/SVGs/dollar.svg'),
                  const SizedBox(width: 5),
                  Text(
                    orderFilterData.price,
                    style: Constants.secondaryTitleFont.copyWith(
                      color: Constants.primaryAppColor,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    "ريال سعودي",
                    style: Constants.secondaryTitleFont.copyWith(
                        color: Constants.primaryAppColor, fontSize: 10),
                  ),
                ]),
                const SizedBox(height: 10),
                const SeparatorWidget(color: Constants.primaryAppColor),
                ListTile(
                  dense: true,
                  leading: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                          orderFilterData.adviser!.avatar == ""
                              ? Constants.imagePlaceHolder
                              : orderFilterData.adviser!.avatar!)),
                  title: Text(orderFilterData.adviser?.fullName ?? "",
                      style: Constants.secondaryTitleFont),
                  subtitle: Text(
                    orderFilterData.adviser?.info ?? "لا يوجد وصف لهذا الناصح",
                    style: Constants.subtitleRegularFont,
                  ),
                  contentPadding: EdgeInsets.zero,
                  trailing: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${orderFilterData.adviser?.rate}',
                          style: Constants.secondaryTitleFont,
                        ),
                        const SizedBox(width: 5),
                        SvgPicture.asset('assets/images/SVGs/star.svg')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: Get.locale!.languageCode == "ar" ? 4.5 : null,
          right: Get.locale!.languageCode == "ar" ? null : 4.5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            height: 25,
            width: 80,
            decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                border: Border.all(color: Colors.red)),
            child: Center(
              child: Text(orderFilterData.label?.name ?? "",
                  textAlign: TextAlign.center,
                  style: Constants.subtitleRegularFont.copyWith(fontSize: 10)),
            ),
          ),
        ),
      ],
    );
  }
}
