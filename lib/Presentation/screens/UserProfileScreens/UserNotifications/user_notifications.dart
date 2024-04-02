import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/constants.dart';
import '../../../../Data/cubit/notification_cubit/notification_cubit.dart';
import '../../../../Data/cubit/notification_cubit/notification_state.dart';
import '../../../widgets/shared.dart';

class UserNotifications extends StatefulWidget {
  const UserNotifications({super.key});

  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getDataNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size(double.infinity, 118),
            child: Padding(
              padding:
                  EdgeInsets.only(right: 16, left: 16, top: 70, bottom: 16),
              child: Back(header: "notifications"),
            )),
        body: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is NotificationLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
              shrinkWrap: true,
              itemBuilder: (context, index) => OneNotificationItem(
                date: state.response?[index].date ?? "",
                description: state.response?[index].description,
                id: state.response?[index].id.toString() ?? "",
              ),
              itemCount: state.response?.length ?? 0,
            );
          } else if (state is NotificationError) {
            return const Center(child: Text('Error occurred'));
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        }));
  }
}

class OneNotificationItem extends StatelessWidget {
  const OneNotificationItem(
      {super.key,
      required this.id,
      required this.description,
      required this.date});

  final String id;
final  String? description;
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
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red[100],
                  child: const Icon(
                    Icons.notifications_active,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          'الوصف : ',
                          style: Constants.mainTitleFont,
                        ),
                        Text(
                          '  ${description == null || description == '' ? "لا يوجد وصف" : description}',
                          style: Constants.mainTitleRegularFont
                              .copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
