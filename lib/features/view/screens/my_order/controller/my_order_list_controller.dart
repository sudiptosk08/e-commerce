
import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/my_order/model/my_order_list_model.dart';
import 'package:ecommerce_app/features/view/screens/my_order/state/my_orderList_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';


final myOrderProvider = StateNotifierProvider<MyOrderController, BaseState>(
  (ref) => MyOrderController(ref: ref),
);


class MyOrderController extends StateNotifier<BaseState> {
  final Ref? ref;

  MyOrderController({this.ref}) : super(const InitialState());

  MyOrderListModel? myOrderListModel;
  

  Future fetchMyOrders(
    String status
  ) async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.myOrderList(status: status)),
      );
      if (responseBody != null) {
        myOrderListModel = MyOrderListModel.fromJson(responseBody);
        state = MyOrderListSuccessState(myOrderListModel);
        print("fetch order state");
        print("$responseBody");
        
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }

  // Future fetchOrders() async {
  //   state = const LoadingState();
  //   dynamic responseBody;
  //   try {
  //     responseBody = await Network.handleResponse(
  //       await Network.getRequest(API.getOrder),
  //     );
  //     if (responseBody != null) {
  //       reportModel = ReportModel.fromJson(responseBody);
  //       state = FetchReportSuccessState(reportModel);
  //     } else {
  //       state = const ErrorState();
  //     }
  //   } catch (error, stackTrace) {
  //     print("error = $error");
  //     print("error = $stackTrace");
  //     state = const ErrorState();
  //   }
  // }

  // Future cancelOrder({
  //   required int id,
  //   required int invoiceId,
  // }) async {
  //   state = const LoadingState();
  //   dynamic responseBody;
  //   var requestBody = {'id': id, 'invoice_id': invoiceId};
  //   try {
  //     responseBody = await Network.handleResponse(
  //       await Network.postRequest(API.deleteOrder, requestBody),
  //     );
  //     if (responseBody != null) {
  //       if (responseBody['token'] != null) {
  //         state = const OrderSuccessState();
  //         setValue(isLoggedIn, true);
  //         setValue(token, responseBody['token']);
  //         toast("Order Post Successfully", bgColor: KColor.selectColor);

  //         NavigationService.navigateToReplacement(
  //           CupertinoPageRoute(
  //             builder: (context) => const SignupPage(),
  //           ),
  //         );
  //       }
  //     } else {
  //       state = const ErrorState();
  //     }
  //   } catch (error, stackTrace) {
  //     print(error);
  //     print(stackTrace);
  //     state = const ErrorState();
  //   }
  // }
}
