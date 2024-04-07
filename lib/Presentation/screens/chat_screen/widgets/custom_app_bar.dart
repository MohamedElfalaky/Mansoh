import 'package:get/get.dart';

import '../../../../app/style/icons.dart';
import '../../../../app/utils/exports.dart';

customChatAppBar(BuildContext context) => PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        leading: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
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
          ],
        ),
        title: const Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 20),
                Text('محادثة الناصح'),
              ],
            ),
          ],
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/images/SVGs/home_icon.svg',
                      width: 22,
                      height: 22,
                    ),
                  ),
                  const SizedBox(width: 10)
                ],
              ),
            ],
          )
        ],
      ),
    );
