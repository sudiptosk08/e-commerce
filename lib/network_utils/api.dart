import 'package:ecommerce_app/constant/app_mode.dart';

class API {
  static const live =
      'http://ecom.slashproduct.xyz/api/v1'; // Live Production API URL
  static const test =
      'http://ecom.slashproduct.xyz/api/v1'; // Live Staging API URL
  static const base = AppMode.PRODUCTION_MODE ? live : test;

  // //
  static const updateUser = '/user/update';
  static const user = '/user';
  static const userBalance = '/user/balance';

  ///// Banner
  static const banner = '/banner';

  ///// auth
  static const signup = '/register'; //clear
  static const login = '/login'; //clear
  static const logout = '/logout';
  static const updatepassword = '/password/update';
  ///// Notification
  static const notification = '/notifications';

  /////Shipping Address
  static const addShippingAddress = '/user/address';
  static const shippingAddressList = '/user/address';
  ///// Order place
  static const order = '/order';
  ////My Order
  static const myOrderList = '/order';
  static myOrderDetails({
    id = "",
  }) =>
      '/order/$id';
  static orderCancel({
    id = "",
  }) =>
      '/order/$id/cancelled';

  ///// Add Reviews
  static const reviews = '/review/store';

  ///// brand
  static const brands = '/brand';

  ///// category
  static const categories = '/categories'; //clear

  ///// product list api
  static shopProductList(
          {categoryId = "",
          subCategoryId = "",
          brandId = "",
          orderByPrice = "",
          ratings = "",
          minPrice = "",
          maxPrice = "",
          str = "",
          page = ""}) =>
      '/products?category_id[]=$categoryId&subcategory_id[]=$subCategoryId&brand_id[]=$brandId&order_by_price=$orderByPrice&rating=$ratings&min_price=$minPrice&max_price=$maxPrice&name=$str&page=$page';

  ///// popular product

  static const popularProduct = '/products?popular=1';

  /////single Product Details

  static productDetails({
    slug = "",
  }) =>
      '/product/$slug';

  /////wishlist api

  static addWishList({
    productId = "",
  }) =>
      '/wishlist/store?product_id=$productId';
  static const getWishlist = '/wishlist';
  static deleteWishlist({id = ""}) => '/wishlist/delete/$id?_method=delete';
}
