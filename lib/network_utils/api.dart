import 'package:ecommerce_app/constant/app_mode.dart';

class API {
  static const live =
      'https://ecom.spinnertech.online/api/v1'; // Live Production API URL
  static const test =
      'https://ecom.spinnertech.online/api/v1'; // Live Staging API URL
  static const base = AppMode.PRODUCTION_MODE ? live : test;

  // //
  static const updateUser = '/user/update';
  static const user = '/user';
  static const userBalance = '/user/balance';

  // //
  static const signup = '/register'; //clear
  static const login = '/login'; //clear
  static const logout = '/logout';
  static const updatepassword = '/password/update';

  // //brand
  static const brands = '/brand';

  // // category
  static const categories = '/categories'; //clear

  /////product list api
  static shopProductList(
          {categoryId = "",
          subCategoryId = "",
          brandId = "",
          orderByPrice = "",
          ratings = "",
          minPrice = "",
          maxPrice = "",
          str = ""}) =>
      '/products?category_id=$categoryId&subcategory_id=$subCategoryId&brand_id=$brandId&order_by_price=$orderByPrice&rating=$ratings&min_price=$minPrice&max_price=$maxPrice&name=$str';

  /////single Product Details
  static productDetails({
    slug = "",
  }) =>
      '/product/$slug';

  //wishlist api
  static addWishList({
    productId = "",
  }) =>
      '/wishlist/store?product_id=$productId';
  static const getWishlist = '/wishlist';
  static const deleteWishlist = '//wishlist/delete/8';
}
