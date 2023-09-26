import 'package:ecommerce_app/features/view/screens/notification/controller/notification_controller.dart';
import 'package:ecommerce_app/features/view/screens/notification/model/notification_model.dart';
import 'package:ecommerce_app/features/view/screens/notification/state/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../global_component/appBar/app_bar.dart';
import 'component/notification_card.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final notificationState = ref.watch(notificationListProvider);
      final List<Datum> notificationData =
          notificationState is NotificationSuccessState
              ? notificationState.notificationModel!.data
              : [];

      return Scaffold(
        backgroundColor: KColor.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: KAppBar(
            checkTitle: true,
            title: 'Notification',
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: notificationData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {},
                              child: NotificationCard(
                                title: notificationData[index].title,
                                msg: notificationData[index].body,
                                seen: notificationData[index].read,
                                date: notificationData[index].time,
                                // seen:
                                cancel: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },

                                delete: () {
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  String createDate(String? date, int? index) {
    List dates = date!.split(" ");
    return dates[index!];
  }
}
