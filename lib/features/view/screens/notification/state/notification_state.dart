import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/notification/model/notification_model.dart';

class NotificationSuccessState extends SuccessState {
  final NotificationModel? notificationModel;

  const NotificationSuccessState(this.notificationModel);
}
