// ignore_for_file: avoid_print

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/model/my_order_details_model.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/state/my_order_details_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myOrderDetailsProvider = StateNotifierProvider<MyOrderDetailsController, BaseState>(
  (ref) => MyOrderDetailsController(ref: ref),
);

class MyOrderDetailsController extends StateNotifier<BaseState> {
  final Ref? ref;

  MyOrderDetailsController({this.ref}) : super(const InitialState());

  MyOrderDetailsModel? myOrderDetailsModel;

  Future fetchMyOrdersDetails(String id) async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.myOrderDetails(id: id)),
      );
      if (responseBody != null) {
        myOrderDetailsModel = MyOrderDetailsModel.fromJson(responseBody);
        state = MyOrderDetailsSuccessState(myOrderDetailsModel);
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
