import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/wishlist/model/wishlist_model.dart';

class AddWishlistSuccessState extends SuccessState {
  const AddWishlistSuccessState();
}

class WishlistSuccessState extends SuccessState {
  final WishListModel? wishlistModel;

  const WishlistSuccessState(this.wishlistModel);
}

class DeleteWishlistSuccessState extends SuccessState {
  const DeleteWishlistSuccessState();
}
