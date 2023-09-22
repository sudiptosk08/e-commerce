import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/model/shipping_address_list_model.dart';

class ShippingAddressListSuccessState extends SuccessState {
  final ShippingAddressList? shippingAddressList;

  const ShippingAddressListSuccessState(
    this.shippingAddressList,
  );
}
