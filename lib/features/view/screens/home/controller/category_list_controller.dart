
// ignore_for_file: avoid_print

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/home/model/category_list_model.dart';
import 'package:ecommerce_app/features/view/screens/home/state/categories_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../network_utils/network_utils.dart';

/// Providers
final categoryProvider = StateNotifierProvider<CategoryController, BaseState>(
  (ref) => CategoryController(ref: ref),
);

/// Controllers
class CategoryController extends StateNotifier<BaseState> {
  final Ref? ref;

  CategoryController({this.ref}) : super(const InitialState());
  CategoryListModel? categoryModel;

  Future fetchCategoryDetails() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody =
          await Network.handleResponse(await Network.getRequest(API.categories));
      if (responseBody != null) {
        categoryModel = CategoryListModel.fromJson(responseBody);
        state = CategorySuccessState(categoryModel);
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
