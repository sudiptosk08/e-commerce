
import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/shop/model/product_list_model.dart';

class ProductListSuccessState extends SuccessState {
  final ProductListModel? productListModel;

  const ProductListSuccessState(this.productListModel);
}
