// ignore_for_file: avoid_print

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/all_categories/model/category_list_model.dart';
import 'package:ecommerce_app/features/view/screens/all_categories/state/categories_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Providers
final categorylistProvider = StateNotifierProvider<CategorylistController, BaseState>(
  (ref) => CategorylistController(ref: ref),
);

/// Controllers
class CategorylistController extends StateNotifier<BaseState> {
  final Ref? ref;

  CategorylistController({this.ref}) : super(const InitialState());
  CategoryListModel? categoryListModel;

  
  Future fetchAllCategorylist() async {
    state = const LoadingState();

    dynamic responseBody;

    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.categories),
      );
      if (responseBody != null) {
        categoryListModel = CategoryListModel.fromJson(responseBody);
        state =CategoryListSuccessState(categoryListModel);
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
