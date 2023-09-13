import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/screens/shop/model/product_list_model.dart';
import 'package:ecommerce_app/features/view/screens/shop/state/product_list_state.dart';
import 'package:ecommerce_app/features/view/screens/shop/view/shop_page.dart';
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

  // List<ShopDataModel>? searchModel = [];
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

//   Future fetchMoreShopProductList(
//       {str, groupId, categoryId, brandId, price, color, size}) async {
//     if (shopDataModel == null) state = const LoadingState();

//     var responseBody;
//     //for filter page value
//     str = str == null ? '' : str.toString();

//     groupId = groupId == null ? '' : groupId.toString();
//     categoryId = categoryId == null ? '' : categoryId.toString();
//     price = price == null ? '' : price.toString();
//     brandId = brandId == null ? '' : brandId.toString();
//     color = color == null ? '' : color.toString();
//     size = size == null ? '' : size.toString();

//     try {
//       responseBody = await Network.handleResponse(
//         await Network.getRequest(API.shop(
//             limit: limit += 20,
//             str: str,
//             groupId: groupId,
//             categoryId: categoryId,
//             price: price,
//             brandId: brandId,
//             colour: color,
//             size: size)),
//       );

//       if (responseBody != null) {
//         shopDataModel = ShopDataModel.fromJson(responseBody);

//         state = ShopSuccessState(shopDataModel);
//         ref!.read(shopListScrollProvider.notifier).resetState();
//       } else {
//         state = const ErrorState();
//       }
//     } catch (error, stackTrace) {
//       print(error);
//       print(stackTrace);
//       state = const ErrorState();
//     }
//   }
// }
}
