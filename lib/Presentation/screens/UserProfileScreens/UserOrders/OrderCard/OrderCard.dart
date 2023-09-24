import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Data/models/orders_models/orders_filter_model.dart';
import '../../../../../app/constants.dart';
import '../../UserProfileEdit/widgets/shared.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
        required this.orderFilterData,
      });

  final OrderFilterData orderFilterData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: Constants.primaryAppColor, width: 0.2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderFilterData.name ??"",
                                style: Constants.secondaryTitleFont,
                              ),
                              Text(
                                orderFilterData.date??"",
                                style: Constants.subtitleRegularFont,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 55,
                          ),
                          Text(
                            orderFilterData.id.toString(),
                            style: Constants.subtitleRegularFont
                                .copyWith(letterSpacing: 0, wordSpacing: 0),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    const Icon(
                      Icons.attach_money,
                      color: Constants.primaryAppColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      orderFilterData. price.toString(),
                      style: Constants.secondaryTitleFont.copyWith(
                        color: Constants.primaryAppColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "ريال سعودي",
                      style: Constants.secondaryTitleFont.copyWith(
                        color: Constants.primaryAppColor,
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  const MySeparator(
                    color: Constants.primaryAppColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    visualDensity:
                    const VisualDensity(horizontal: -4, vertical: 0),
                    dense: true,
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.black87,
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage:   orderFilterData.adviser!.avatar == ""
                            ? const NetworkImage(
                            "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png")
                            : NetworkImage(  orderFilterData.adviser!.avatar!),
                      ),
                    ),
                    title: Text(
                      orderFilterData.adviser?.fullName??"",
                      style: Constants.secondaryTitleFont,
                    ),
                    subtitle:  Text(
                      orderFilterData.adviser?.info??"",
                      style: Constants.subtitleRegularFont,
                    ),
                    trailing: FittedBox(
                      child: Row(
                        children: [
                          Text(
                            orderFilterData.adviser?.rate??"",
                            style: Constants.secondaryTitleFont,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
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
            left:  Get.locale!.languageCode =="ar" ?5 : null,
            right:  Get.locale!.languageCode =="ar" ?null: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              // width: 60,
              height: 25,
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5),
                  )),
              child:  Center(
                child: Text(  orderFilterData.status?.name??"",
                    textAlign: TextAlign.center,
                    style: Constants.subtitleRegularFont),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
