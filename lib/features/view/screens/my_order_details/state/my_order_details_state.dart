import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/model/my_order_details_model.dart';

class MyOrderDetailsSuccessState extends SuccessState {
  MyOrderDetailsModel? myOrderDetailsModel;
  MyOrderDetailsSuccessState(this.myOrderDetailsModel);
}
