// ignore_for_file: avoid_print, file_names

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/screens/auth/login/model/user_model.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/controller/get_shipping_address_controller.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/shipping_address_page.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/state/add_new_shippingAddress_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final addShippingAddressProvider =
    StateNotifierProvider<AddNewAddressController, BaseState>(
  (ref) => AddNewAddressController(ref: ref),
);

/// Controllers
class AddNewAddressController extends StateNotifier<BaseState> {
  final Ref? ref;

  AddNewAddressController({this.ref}) : super(const InitialState());
  UserModel? userModel;

  Future addShippingAddress({
    required String phone,
    required String deliveryAddressType,
    required String city,
    required String region,
    required String area,
    required String house,
  }) async {
    state = const LoadingState();
    if (phone == "") {
      toast("Phone Field is Required !", bgColor: KColor.errorRedText);
    } else if (city == "") {
      toast("City Field is Required !", bgColor: KColor.errorRedText);
    } else if (region == "") {
      toast("Region Field is Required !", bgColor: KColor.errorRedText);
    } else if (area == "") {
      toast("Area Field is Required !", bgColor: KColor.errorRedText);
    } else if (house == "") {
      toast("House / Street Field is Required !", bgColor: KColor.errorRedText);
    } else {
      dynamic responseBody;
      var requestBody = {
        'phone': phone,
        'address_type': deliveryAddressType,
        'city': city,
        'region': region,
        'area': area,
        'address': house
      };
      try {
        responseBody = await Network.handleResponse(
          await Network.postRequest(API.addShippingAddress, requestBody),
        );
        print(requestBody);
        if (responseBody != null) {
          ref!.read(addressListProvider.notifier).fetchShppingAddressList();
          NavigationService.navigateToReplacement(
              SlideLeftRoute(page:  ShippingAddressPage(page: '',)));
          state = AddShippingAddressSuccessState();
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
