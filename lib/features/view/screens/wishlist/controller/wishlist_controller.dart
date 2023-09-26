// ignore_for_file: avoid_print

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/screens/wishlist/model/wishlist_model.dart';
import 'package:ecommerce_app/features/view/screens/wishlist/state/wishList_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final wishlistProvider = StateNotifierProvider<WishlistController, BaseState>(
  (ref) => WishlistController(ref: ref),
);

/// Controllers
class WishlistController extends StateNotifier<BaseState> {
  final Ref? ref;

  WishlistController({this.ref}) : super(const InitialState());
  WishListModel? wishlistModel;

  Future addWishlist({required String id}) async {
    state = const LoadingState();

    dynamic responseBody;
    var requestBody = {'id': id};

    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.addWishList(productId: id), requestBody),
      );
      if (responseBody != null) {
        toast("Product added to wishlist successfully!", bgColor: KColor.green);
        state = const AddWishlistSuccessState();
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ErrorState();
    }
  }

  Future fetchWishlistProducts() async {
    state = const LoadingState();

    dynamic responseBody;

    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getWishlist),
      );
      if (responseBody != null) {
        wishlistModel = WishListModel.fromJson(responseBody);
        state = WishlistSuccessState(wishlistModel);
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }

  Future deleteWishlist({required String id}) async {
    state = const LoadingState();

    dynamic responseBody;
    var requestBody = {'id': id};

    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.deleteWishlist(id: id), requestBody),
      );
      if (responseBody != null) {
        toast("Product removed from wishlist successfully",
            bgColor: KColor.green);
        state = const DeleteWishlistSuccessState();
        NavigationService.popNavigate();
        ref!.read(wishlistProvider.notifier).fetchWishlistProducts();
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
