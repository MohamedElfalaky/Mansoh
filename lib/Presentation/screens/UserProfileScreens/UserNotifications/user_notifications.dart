import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../app/constants.dart';
import '../../../../../app/utils/my_application.dart';
import '../../../../Data/cubit/notification_cubit/notification_cubit.dart';
import '../../../../Data/cubit/notification_cubit/notification_state.dart';
import '../../../widgets/no_internet.dart';
import '../../../widgets/shared.dart';

class UserNotifications extends StatefulWidget {
  const UserNotifications({Key? key}) : super(key: key);

  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool? isConnected;
  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    MyApplication.checkConnection().then((value) {
      if (value) {
        context.read<NotificationCubit>().getDataNotification();
      } else {
        MyApplication.showToastView(message: "noInternet".tr);
      }
    });

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (mounted) {
        setState(() {
          result == ConnectivityResult.none
              ? isConnected = false
              : isConnected = true;
        });
      }
      if (result != ConnectivityResult.none) {
        context.read<NotificationCubit>().getDataNotification();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final sizee = MediaQuery.of(context).size;
    if (isConnected == null) {
      MyApplication.checkConnection().then((value) {
        setState(() {
          isConnected = value;
        });
      });
    } else if (!isConnected!) {
      MyApplication.showToastView(message: "noInternet".tr);
      return NoInternetWidget(size: sizee);
    }

    return GestureDetector(
      onTap: () {
        MyApplication.dismissKeyboard(context);
      },
      child: SafeArea(
        child: Scaffold(
            appBar: const PreferredSize(
                preferredSize: Size(double.infinity, 118),
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 16),
                  child: Back(header: "notifications"),
                )),
            resizeToAvoidBottomInset: false,
            body: BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
              if (state is NotificationLoading) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (state is NotificationLoaded) {
                // print("state.response!.transaction.toString()  is ${state.response.toString()}");
                return Padding(
                  padding:
                      const EdgeInsets.only(right: 16, left: 16, bottom: 16),
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
                            ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  OneNotificationItem(
                                date: state.response?[index].date ?? "",
                                description:
                                    state.response?[index].description ?? "",
                                id: state.response?[index].id.toString() ?? "",
                              ),
                              itemCount: state.response?.length ?? 0,
                            )
                          ],
                        )),
                  ),
                );
              } else if (state is NotificationError) {
                return const Center(child: Text('error'));
              } else {
                return const Center(child: Text('....'));
              }
            })),
      ),
    );
  }
}

class OneNotificationItem extends StatelessWidget {
  const OneNotificationItem(
      {super.key,
      required this.id,
      required this.description,
      required this.date});

  final String id;
  final String description;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: Constants.secondaryTitleFont,
                    ),
                    Text(
                      date,
                      style: Constants.subtitleRegularFontHint,
                    ),
                    Row(
                      children: [
                        const Text(
                          "رقم الطلب :  ",
                          style: Constants.subtitleRegularFont,
                        ),
                        Text(
                          id,
                          style: Constants.secondaryTitleFont,
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
            const Row(children: [
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
                  style: Constants.subtitleRegularFont.copyWith(
                    height: 0.1,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 0,
                    )),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {},
                  child: Text(
                    "ابحث عن مستشار آخر",
                    style: Constants.subtitleRegularFont.copyWith(
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
    );
  }
}
