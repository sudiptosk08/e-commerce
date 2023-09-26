// ignore_for_file: file_names

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/my_order/model/my_order_list_model.dart';

class MyOrderListSuccessState extends SuccessState {
  MyOrderListModel? myOrderListModel;
  MyOrderListSuccessState(this.myOrderListModel);
}
