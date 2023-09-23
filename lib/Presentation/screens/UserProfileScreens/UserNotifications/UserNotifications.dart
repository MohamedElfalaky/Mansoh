import 'package:flutter/material.dart';

import '../../../../../app/constants.dart';
import '../../../../../app/utils/myApplication.dart';
import '../../../widgets/shared.dart';

class UserNotifications extends StatefulWidget {
  const UserNotifications({Key? key}) : super(key: key);

  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Back(header: "notifications"),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.red[100],
                                      child: const Icon(
                                        Icons.notifications_active,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "طلب نصيحة حول اختيار الجامعة المناسبة",
                                        style: Constants.secondaryTitleFont,
                                      ),
                                      const Text(
                                        "12/2/2022 - 10:46 ص",
                                        style:
                                            Constants.subtitleRegularFontHint,
                                      ),
                                      Row(
                                        children: const [
                                          Text(
                                            "رقم الطلب :  ",
                                            style:
                                                Constants.subtitleRegularFont,
                                          ),
                                          Text(
                                            "#738477202",
                                            style:
                                                Constants.secondaryTitleFont,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(children: const [
                                Text(
                                  "تم رفض طلبك من ",
                                  style: Constants.subtitleRegularFont,
                                ),
                                Text(
                                  "محمد عبد الله",
                                  style: Constants.secondaryTitleFont,
                                ),
                                Text(
                                  " بسبب ",
                                  style: Constants.subtitleRegularFont,
                                ),
                              ]),
                              Row(
                                children: [
                                  Text(
                                    "رفضه للمبلغ المعروض عليه",
                                    style: Constants.subtitleRegularFont
                                        .copyWith(
                                      height: 0.1,
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      visualDensity: VisualDensity.compact,
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 0,
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "ابحث عن مستشار آخر",
                                      style: Constants.subtitleRegularFont
                                          .copyWith(
                                        color: Colors.blue,
                                        height: 0.1,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
