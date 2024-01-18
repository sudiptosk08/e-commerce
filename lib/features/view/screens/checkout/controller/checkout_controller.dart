// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/screens/auth/login/model/user_model.dart';
import 'package:ecommerce_app/features/view/screens/checkout/state/checkout_state.dart';
import 'package:ecommerce_app/navigation_bar.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final orderProvider = StateNotifierProvider<OrderPlaceController, BaseState>(
  (ref) => OrderPlaceController(ref: ref),
);

/// Controllers
class OrderPlaceController extends StateNotifier<BaseState> {
  final Ref? ref;

  OrderPlaceController({this.ref}) : super(const InitialState());
  UserModel? userModel;

  Future orderPlaced({
    required List<Map<String, dynamic>> cartItems,
    required dynamic totalAmount,
    required dynamic paymentMethoId,
    required dynamic deliveryMethodId,
    required String firstName,
    required String lastName,
    required dynamic discount,
    required String region,
    required String address,
    required String area,
    required String phone,
    required String city,
    required String email,
    required bool insideDhaka,
  }) async {
    state = const LoadingState();
    if (phone == "") {
      toast("Phone Field is Required !", bgColor: KColor.errorRedText);
    } else if (city.isEmptyOrNull) {
      toast("Add Shipping Address !", bgColor: KColor.errorRedText);
    } else if (region.isEmptyOrNull) {
      toast("Add Shipping Address !", bgColor: KColor.errorRedText);
    } else if (area.isEmptyOrNull) {
      toast("Add Shipping Address !", bgColor: KColor.errorRedText);
    } else if (address.isEmptyOrNull) {
      toast("Add Shipping Address !", bgColor: KColor.errorRedText);
    } else if (paymentMethoId == -1) {
      toast("Select a payment method !", bgColor: KColor.errorRedText);
    } else {
      dynamic responseBody;
      var requestBody = {
        'products': jsonEncode(cartItems).toString(),
        'payment_method_id': 2,
        'delivery_method_id': deliveryMethodId,
        'first_name': firstName,
        'last_name': lastName,
        'region': region,
        'delivery_place': insideDhaka,
        'address': address,
        'area': area,
        'phone': phone,
        'city': city,
        'email': email,
      };
      try {
        responseBody = await Network.handleResponse(
          await Network.postRequest(API.order, requestBody),
        );
        print(requestBody);
        if (responseBody != null) {
          toast("Order placed SuccesFully !", bgColor: KColor.seenGreen);
          NavigationService.navigateToReplacement(SlideLeftRoute(
              page: const NavigationBarScreen(
            page: '0',
          )));
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setStringList('cartItems', []);
          prefs.setStringList('orderItems', []);
          state = OrderPlacedSuccessState();
        } else {
          state = const ErrorState();
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        state = const ErrorState();
        print("Error ResponseBody = $responseBody");
      }
    }
  }
}
