// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/all_product_pagination_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/model/product_list_model.dart';
import 'package:ecommerce_app/features/view/screens/shop/state/product_list_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Providers
final productListProvider =
    StateNotifierProvider<ProductListController, BaseState>(
  (ref) => ProductListController(ref: ref),
);

/// Controllers
class ProductListController extends StateNotifier<BaseState> {
  final Ref? ref;

  ProductListController({this.ref}) : super(const InitialState());
  ProductListModel? productListModel;
  int? lastpage;

  int page = 1;
  int limit = 0;
  Future fetchShopProductList({
    categoryID = '',
    subCategoryID = '',
    brandID = '',
    orderByPrice = '',
    maxPrice = '',
    minPrice = '',
    ratings = '',
    str = '',
  }) async {
    state = const LoadingState();

    dynamic responseBody;
    //for filter page value

    categoryID = categoryID == null ? '' : categoryID.toString();
    subCategoryID = subCategoryID == null ? '' : subCategoryID.toString();
    brandID = brandID == null ? '' : brandID.toString();
    orderByPrice = orderByPrice == null ? '' : orderByPrice.toString();
    maxPrice = maxPrice == null ? '' : maxPrice.toString();
    minPrice = minPrice == null ? '' : minPrice.toString();
    ratings = ratings == null ? '' : ratings.toString();
    str = str == null ? '' : str.toString();
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.shopProductList(
            categoryId: categoryID,
            subCategoryId: subCategoryID,
            brandId: brandID,
            orderByPrice: orderByPrice,
            maxPrice: maxPrice,
            minPrice: minPrice,
            ratings: ratings,
            
            str: str)),
      );

      if (responseBody != null) {
        productListModel = ProductListModel.fromJson(responseBody);
        page = productListModel!.meta.currentPage;
        lastpage = productListModel!.meta.lastPage;
        state = ProductListSuccessState(productListModel);
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }

  Future fetchMoreProductList({
    categoryID = '',
    subCategoryID = '',
    brandID = '',
    orderByPrice = '',
    maxPrice = '',
    minPrice = '',
    ratings = '',
    str = '',
  }) async {
    if (productListModel == null) state = const LoadingState();

    var responseBody;
    if (lastpage == page) {
      return null;
    } else {
      try {
        responseBody = await Network.handleResponse(
          await Network.getRequest(API.shopProductList(
            page: page + 1,
          )),
        );

        if (responseBody != null) {
          var productListNewModel = ProductListModel.fromJson(responseBody);
          productListModel!.data.addAll(productListNewModel.data);
          productListModel!.meta.currentPage =
              productListNewModel.meta.currentPage;
          productListModel!.meta.lastPage = productListNewModel.meta.lastPage;
          state = ProductListSuccessState(productListModel);
          ref!.read(allProductScrollProvider.notifier).resetState();
        } else {
          state = const ErrorState();
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        state = const ErrorState();
      }
    }
  }
}
