// ignore_for_file: avoid_print

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/home/state/popular_product_state.dart';
import 'package:ecommerce_app/features/view/screens/shop/model/product_list_model.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../network_utils/network_utils.dart';

/// Providers
final popularProductProvider = StateNotifierProvider<PopularProductController, BaseState>(
  (ref) => PopularProductController(ref: ref),
);

/// Controllers
class PopularProductController extends StateNotifier<BaseState> {
  final Ref? ref;

  PopularProductController({this.ref}) : super(const InitialState());
  ProductListModel? popularProductModel;

  Future fetchPopularList() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
          await Network.getRequest(API.popularProduct));
      if (responseBody != null) {
        popularProductModel = ProductListModel.fromJson(responseBody);
        state = PopularProductSuccessState(popularProductModel);
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
