// ignore_for_file: avoid_print

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/notification/model/notification_model.dart';
import 'package:ecommerce_app/features/view/screens/notification/state/notification_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/// Providers
final notificationListProvider =
    StateNotifierProvider<NotificationListController, BaseState>(
  (ref) => NotificationListController(ref: ref),
);

/// Controllers
class NotificationListController extends StateNotifier<BaseState> {
  final Ref? ref;

  NotificationListController({this.ref}) : super(const InitialState());
  NotificationModel? notificationModel;

  Future fetchNotificationList() async {
    state = const LoadingState();

    dynamic responseBody;

    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.notification),
      );
      if (responseBody != null) {
        notificationModel = NotificationModel.fromJson(responseBody);
        state = NotificationSuccessState(notificationModel);
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }
}
