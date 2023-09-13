import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/product_details/model/product_details_model.dart';

class ProductDetailsSuccessState extends SuccessState {
  final ProductDetailsModel? productDetailsModel;

  const ProductDetailsSuccessState(
    this.productDetailsModel,
  );
}
