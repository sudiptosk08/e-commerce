import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/model/shipping_address_list_model.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/state/get_shipping_address_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Providers
final addressListProvider =
    StateNotifierProvider<AddressListController, BaseState>(
  (ref) => AddressListController(ref: ref),
);

class AddressListController extends StateNotifier<BaseState> {
  final Ref? ref;

  AddressListController({this.ref}) : super(const InitialState());
  ShippingAddressList? shippingAddressList;
  String? selectedIndex;

  Future fetchShppingAddressList() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.shippingAddressList),
      );
      if (responseBody != null) {
        shippingAddressList = ShippingAddressList.fromJson(responseBody);
        print("ProductDetailsBody ========= $responseBody");
        state = ShippingAddressListSuccessState(shippingAddressList);
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
