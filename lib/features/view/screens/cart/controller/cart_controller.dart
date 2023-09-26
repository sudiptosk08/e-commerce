// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/constant/shared_preference_constant.dart';
import 'package:ecommerce_app/features/view/screens/cart/cart_page.dart';
import 'package:ecommerce_app/features/view/screens/cart/model/cart_list_model.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final cartProvider = StateNotifierProvider<CartController, BaseState>(
  (ref) => CartController(ref: ref),
);

/// Controllers
class CartController extends StateNotifier<BaseState> {
  final Ref? ref;

  CartController({this.ref}) : super(const InitialState());
  // CategoryListModel? categoryModel;

  var items;

  var subTotal = 0;

  late bool addQuantity;
  late bool minusQuantity;

  Future<void> addToCart(
    String id,
    int quantity,
    String name,
    String categoryName,
    String subCategoryName,
    String size,
    String color,
    String price,
    String brand,
    String thumbnail,
    String colorId,
    String sizeId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the current cart items (if any) from SharedPreferences
    List<Map<String, dynamic>> cartItems =
        prefs.getStringList('cartItems')?.map((itemString) {
              return Map<String, dynamic>.from(json.decode(itemString));
            }).toList() ??
            [];
    List<Map<String, dynamic>> orderItems =
        prefs.getStringList('orderItems')?.map((itemString) {
              return Map<String, dynamic>.from(json.decode(itemString));
            }).toList() ??
            [];
    // Check if the item is already in the cart
    int existingIndex = cartItems.indexWhere((item) => item['id'] == id);

    if (existingIndex != -1 && addQuantity == true) {
      // If the item is already in the cart, update the quantity
      cartItems[existingIndex]['quantity'] = quantity + 1;
    } else if (minusQuantity == true && addQuantity == false) {
      cartItems[existingIndex]['quantity'] = quantity - 1;
    } else {
      // If the item is not in the cart, add it
      cartItems.add({
        'id': id,
        'quantity': quantity,
        'name': name,
        'category_name': categoryName,
        'sub_categroy_name': subCategoryName,
        'size': size,
        'color': color,
        'price': price,
        'brand': brand,
        'thumbnail': thumbnail,
        'colorId': colorId,
        'sizeId': sizeId
      });

      print(cartItems);
    }
    if (existingIndex != -1 && addQuantity == true) {
      // If the item is already in the cart, update the quantity
      orderItems[existingIndex]['quantity'] = quantity + 1;
    } else if (minusQuantity == true && addQuantity == false) {
      orderItems[existingIndex]['quantity'] = quantity - 1;
    } else {
      orderItems.add({
        "product_id": id,
        "price": price,
        "quantity": quantity,
        "variants": [sizeId, colorId]
      });
    }

    prefs.setStringList(
        'orderItems',
        orderItems.map((item) {
          return json.encode(item);
        }).toList());
    print("Order");

    // Save the updated cart items back to SharedPreferences
    prefs.setStringList(
        'cartItems',
        cartItems.map((item) {
          return json.encode(item);
        }).toList());
    bool checkLogin = getBoolAsync(isLoggedIn, defaultValue: false);

    checkLogin
        ? NavigationService.navigateToReplacement(SizeRoute(page: const CartPage()))
        : toast("Product added to cart.Please login for confirm order.",
            bgColor: KColor.green);
  }

  Future<void> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cartItems');
    if (cartData != null) {
      final decodedData = json.decode(cartData) as List<dynamic>;
      items = decodedData
          .map((itemData) => CartItem(
                id: itemData['id'],
                quantity: itemData['quantity'],
                name: itemData['name'],
                categoryName: itemData['category_name'],
                subCategoryName: itemData['sub_categroy_name'],
                size: itemData['size'],
                color: itemData['color'],
                price: itemData['price'],
                brand: itemData['brand'],
                thumbnail: itemData['thumbnail'],
              ))
          .toList();
    }
  }

  Future<void> removeFromCart(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the current cart items from SharedPreferences
    List<Map<String, dynamic>> cartItems =
        prefs.getStringList('cartItems')?.map((itemString) {
              return Map<String, dynamic>.from(json.decode(itemString));
            }).toList() ??
            [];

    // Find the index of the item with the specified 'id'
    int itemIndex = cartItems.indexWhere((item) => item['id'] == id);

    if (itemIndex != -1) {
      // Remove the item from the list if found
      cartItems.removeAt(itemIndex);

      // Save the updated cart items back to SharedPreferences
      prefs.setStringList(
          'cartItems',
          cartItems.map((item) {
            return json.encode(item);
          }).toList());
    }

    // Update the 'items' variable in the controller (if necessary)
    // You may want to update 'items' here to reflect the current state of the cart
    items = cartItems
        .map((itemData) => CartItem(
              id: itemData['id'],
              quantity: itemData['quantity'],
              name: itemData['name'],
              categoryName: itemData['category_name'],
              subCategoryName: itemData['sub_categroy_name'],
              size: itemData['size'],
              color: itemData['color'],
              price: itemData['price'],
              brand: itemData['brand'],
              thumbnail: itemData['thumbnail'],
            ))
        .toList();
  }
}
