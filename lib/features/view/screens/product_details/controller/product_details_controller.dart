import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/product_details/model/product_details_model.dart';
import 'package:ecommerce_app/features/view/screens/product_details/state/product_details_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Providers
final productDetailsProvider =
    StateNotifierProvider<ProductDetailsController, BaseState>(
  (ref) => ProductDetailsController(ref: ref),
);

class ProductDetailsController extends StateNotifier<BaseState> {
  final Ref? ref;

  ProductDetailsController({this.ref}) : super(const InitialState());
  ProductDetailsModel? productDetailsModel;

 
  Future fetchProductsDetails(slug) async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.productDetails(slug:slug)),
      );
      if (responseBody != null) {
        productDetailsModel = ProductDetailsModel.fromJson(responseBody);
        state = ProductDetailsSuccessState(productDetailsModel);
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
