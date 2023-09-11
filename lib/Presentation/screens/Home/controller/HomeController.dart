import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';
import 'package:path/path.dart';

class HomeController {
  ///vars
  List<Map> categories = [
    {"name": "جميع المجالات", "isSelected": true},
    {"name": "المحماة", "isSelected": false},
    {"name": "التكنولوجيا والبيئة السطحية", "isSelected": false},
    {"name": "الهندسة", "isSelected": false},
    {"name": "المحماة", "isSelected": false},
    {"name": "الطب", "isSelected": false},
    {"name": "المحماة", "isSelected": false},
    {"name": "التجارة", "isSelected": false},
    {"name": "المحماة", "isSelected": false},
  ];

  ///methods
  // void HomeAPIs(BuildContext context, String token) async {
  //   final bool result = await MyApplication.checkInternet();
  //   if (!result) {
  //     MyApplication.showToast(
  //         text: "No Internet connection | لا يوجد اتصال",
  //         color: ToastColors.error);
  //   } else {
  //     // HomeItemsCubit.get(context).getHomeItems(token);
  //     // TotalFeeCubit.get(context).getTotalFee(token);
  //   }
  // }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget pageViewItem(String imageNeeded) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "ابحث عن ناصح",
                  style: TextStyle(
                      color: Constants.primaryAppColor,
                      fontSize: 16,
                      fontFamily: Constants.mainFont,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    textAlign: TextAlign.right,
                    "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحةما سيلهي القارئ عن التركيز على الشكل.",
                    style:
                        TextStyle(fontSize: 10, fontFamily: Constants.mainFont),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(width: 50,),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Image.network(
              imageNeeded,
              // "https://www.vhv.rs/dpng/d/18-187042_futbol-messi-png-2019-transparent-png.png",
              width :  130, height: 100,fit: BoxFit.cover,
            ),
          )),
        ],
      ),
    );
  }
}
