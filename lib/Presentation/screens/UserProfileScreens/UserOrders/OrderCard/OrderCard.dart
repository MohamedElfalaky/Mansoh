import 'package:flutter/material.dart';

import '../../../../../app/constants.dart';
import '../../UserProfileEdit/widgets/shared.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
      required this.networkImage,
      required this.adviceName,
      required this.dateText,
      required this.price,
      required this.info,
      required this.adviserName,
      required this.id,
      required this.rateData});

  final String networkImage;
  final String adviceName;
  final String dateText;
  final String id;
  final String price;
  final String adviserName;
  final String info;
  final String rateData;

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
                                adviceName,
                                style: Constants.secondaryTitleFont,
                              ),
                              Text(
                                dateText,
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
                           id,
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
                      price,
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
                        backgroundImage: networkImage == ""
                            ? NetworkImage(
                                "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png")
                            : NetworkImage(networkImage),
                      ),
                    ),
                    title: Text(
                      adviserName,
                      style: Constants.secondaryTitleFont,
                    ),
                    subtitle:  Text(
                     info,
                      style: Constants.subtitleRegularFont,
                    ),
                    trailing: FittedBox(
                      child: Row(
                        children: [
                          Text(
                            rateData,
                            style: Constants.secondaryTitleFont,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
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
            left: 5,
            child: Container(
              width: 60,
              height: 25,
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5),
                  )),
              child: const Center(
                child: Text("مرفوضة",
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
