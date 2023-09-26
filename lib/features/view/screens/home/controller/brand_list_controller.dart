// ignore_for_file: avoid_print

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/home/model/brand_list_model.dart';
import 'package:ecommerce_app/features/view/screens/home/state/brands_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../network_utils/network_utils.dart';

/// Providers
final brandProvider = StateNotifierProvider<BrandListController, BaseState>(
  (ref) => BrandListController(ref: ref),
);

/// Controllers
class BrandListController extends StateNotifier<BaseState> {
  final Ref? ref;

  BrandListController({this.ref}) : super(const InitialState());
  BrandListModel? brandListModel;

  Future fetchBrand() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody =
          await Network.handleResponse(await Network.getRequest(API.brands));
      if (responseBody != null) {
        brandListModel = BrandListModel.fromJson(responseBody);
        state = BrandSuccessState(brandListModel);
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
