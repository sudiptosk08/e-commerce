// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';
import 'package:ecommerce_app/constant/shared_preference_constant.dart';
import 'package:ecommerce_app/features/view/screens/auth/login/login_page.dart';
import 'package:ecommerce_app/features/view/screens/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/features/view/screens/checkout/component/cupon_card.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/controller/get_shipping_address_controller.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../utils/size/k_size.dart';
import '../../global_component/appBar/app_bar.dart';
import '../../global_component/buttons/Kdrop_down_field.dart';
import '../checkout/checkout_page.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});
  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  TextEditingController promoCode = TextEditingController();

  List<Map<String, dynamic>> cartItems = [];
  bool checkLogin = false;
  @override
  void initState() {
    super.initState();
    loadCartItems();
    checkLogin = getBoolAsync(isLoggedIn, defaultValue: false);
  }

  Future<void> loadCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemStrings = prefs.getStringList('cartItems') ?? [];
    setState(() {
      cartItems = cartItemStrings.map((itemString) {
        return Map<String, dynamic>.from(json.decode(itemString));
      }).toList();
      print("CartItems$cartItems");
      totalCart();
    });
  }

  void totalCart() {
    int total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      total += int.parse(cartItems[i]['price'].toString()) *
          int.parse(cartItems[i]['quantity'].toString());
    }

    var subtotal = total;
    ref.read(cartProvider.notifier).subTotal = subtotal;
    print('subtotal : $subtotal');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final cartState = ref.watch(cartProvider);

      return Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: KAppBar(
              checkTitle: true,
              title: "Cart",
            ),
          ),
          backgroundColor: KColor.background,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  width: double.infinity,
                  height: 48,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color(0xffE8E8E8)),
                  child: Center(
                    child: Text(
                      "Estimated Delivery Time : 02 - 04 days",
                      style: TextStyles.bodyText1.copyWith(color: KColor.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                cartItems.isEmpty
                    ? SizedBox(
                        height: KSize.getHeight(context, 400),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shop_outlined,
                              size: 35,
                              color: KColor.grey,
                            ),
                            Text(
                              "Empty Cart List ",
                              style: TextStyles.bodyText1
                                  .copyWith(color: KColor.grey),
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xffF9F9F9),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                width: KSize.getWidth(
                                                    context, 110),
                                                height: KSize.getHeight(
                                                    context, 75.3),
                                                decoration: BoxDecoration(
                                                  color: KColor.white,
                                                  image: const DecorationImage(
                                                    //     image: NetworkImage(
                                                    //   "${cartItems[index]['thumbnail']}",)
                                                    fit: BoxFit.contain,
                                                    image: AssetImage(
                                                      "assets/product/product10.png",
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(cartItems[index]['name'],
                                                    style:
                                                        TextStyles.bodyText1),
                                                Text(
                                                  "Color  : ${cartItems[index]['color']}   ||   Size : ${cartItems[index]['size']}",
                                                  style: TextStyles.bodyText1
                                                      .copyWith(
                                                          color:
                                                              KColor.textgrey),
                                                ),
                                                Text(
                                                  "Brand : ${cartItems[index]['brand']}",
                                                  style: TextStyles.bodyText1
                                                      .copyWith(
                                                          color:
                                                              KColor.textgrey),
                                                ),
                                                Text(
                                                  "Status : In Stock",
                                                  style: TextStyles.bodyText1
                                                      .copyWith(
                                                          color:
                                                              KColor.textgrey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          bottom: 10.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: KSize.getWidth(context, 110),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                color: const Color(0xffE9E9FA)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    cartItems[index]
                                                                ['quantity'] ==
                                                            1
                                                        ? null
                                                        : setState(() {
                                                            ref
                                                                .read(cartProvider
                                                                    .notifier)
                                                                .addToCart(
                                                                  cartItems[
                                                                          index]
                                                                      ['id'],
                                                                  cartItems[index]
                                                                          [
                                                                          'quantity']
                                                                      .toInt(),
                                                                  cartItems[
                                                                          index]
                                                                      ['name'],
                                                                  cartItems[
                                                                          index]
                                                                      [
                                                                      'category_name'],
                                                                  cartItems[
                                                                          index]
                                                                      [
                                                                      'sub_categroy_name'],
                                                                  cartItems[
                                                                          index]
                                                                      ['size'],
                                                                  cartItems[
                                                                          index]
                                                                      ['color'],
                                                                  cartItems[
                                                                          index]
                                                                      ['price'],
                                                                  cartItems[
                                                                          index]
                                                                      ['brand'],
                                                                  cartItems[
                                                                          index]
                                                                      [
                                                                      'thumbnail'],
                                                                  cartItems[
                                                                          index]
                                                                      [
                                                                      'colorId'],
                                                                  cartItems[
                                                                          index]
                                                                      [
                                                                      'sizeId'],
                                                                );
                                                            cartItems[index][
                                                                        'quantity'] ==
                                                                    1
                                                                ? null
                                                                : ref
                                                                    .read(cartProvider
                                                                        .notifier)
                                                                    .addQuantity = false;
                                                            cartItems[index][
                                                                        'quantity'] ==
                                                                    1
                                                                ? null
                                                                : ref
                                                                    .read(cartProvider
                                                                        .notifier)
                                                                    .minusQuantity = true;
                                                          });
                                                    loadCartItems();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: KColor.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    width: 30,
                                                    height: 30,
                                                    alignment: Alignment.center,
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 18,
                                                      color: KColor.textgrey,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(),
                                                  alignment: Alignment.center,
                                                  width: 30,
                                                  child: Text(
                                                    cartItems[index]['quantity']
                                                        .toString(),
                                                    style: TextStyles.bodyText1
                                                        .copyWith(
                                                            color: KColor
                                                                .textgrey),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      ref
                                                          .read(cartProvider
                                                              .notifier)
                                                          .addToCart(
                                                            cartItems[index]
                                                                ['id'],
                                                            cartItems[index]
                                                                ['quantity'],
                                                            cartItems[index]
                                                                ['name'],
                                                            cartItems[index][
                                                                'category_name'],
                                                            cartItems[index][
                                                                'sub_categroy_name'],
                                                            cartItems[index]
                                                                ['size'],
                                                            cartItems[index]
                                                                ['color'],
                                                            cartItems[index]
                                                                ['price'],
                                                            cartItems[index]
                                                                ['brand'],
                                                            cartItems[index]
                                                                ['thumbnail'],
                                                            cartItems[index]
                                                                ['colorId'],
                                                            cartItems[index]
                                                                ['sizeId'],
                                                          );

                                                      ref
                                                          .read(cartProvider
                                                              .notifier)
                                                          .addQuantity = true;
                                                      ref
                                                              .read(cartProvider
                                                                  .notifier)
                                                              .minusQuantity =
                                                          false;
                                                    });
                                                    loadCartItems();
                                                  },
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: KColor.primary,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    alignment: Alignment.center,
                                                    width: 30,
                                                    height: 30,
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 18,
                                                      color: KColor.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          SizedBox(
                                            width: KSize.getWidth(context, 210),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "৳ ${cartItems[index]['price']}",
                                                  style: TextStyles.subTitle1
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: KColor.red123),
                                                ),
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: KColor.primary,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  width: 30,
                                                  height: 30,
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    Icons
                                                        .delete_forever_rounded,
                                                    size: 18,
                                                    color: KColor.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })),
                SizedBox(
                  height: KSize.getHeight(context, 210),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomSheet: Container(
            height: KSize.getHeight(context, 246),
            decoration: BoxDecoration(
              color: KColor.containerColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(
                  15,
                ),
                topLeft: Radius.circular(
                  15,
                ),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: const Color(0xff6C7285).withOpacity(0.3),
                    offset: const Offset(4.0, 20.0),
                    blurRadius: 16.0,
                    spreadRadius: 20
                    //blurStyle: BlurStyle.outer
                    ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CouponCodeCard(
                    buttonText: "Apply",
                    controller: promoCode,
                    hintText: "Voucher Code",
                    readOnly: false,
                    tap: () {},
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10,
                        ),
                        child: Column(
                          children: [
                            text("Sub Total",
                                "৳${ref.read(cartProvider.notifier).subTotal}"),
                            text("Discount", "0%"),
                            Divider(
                              color: KColor.grey350,
                              thickness: 1,
                            ),
                            text("Total",
                                "৳${ref.read(cartProvider.notifier).subTotal}"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: KButton(
                          width: double.infinity,
                          height: 48,
                          isOutlineButton: false,
                          radius: 8,
                          color: KColor.primary,
                          textStyle: TextStyles.bodyText1.copyWith(
                              color: KColor.white, fontWeight: FontWeight.w500),
                          onPressedCallback: () {
                            ref
                                .read(addressListProvider.notifier)
                                .fetchShppingAddressList();
                            cartItems.isEmpty
                                ? toast("Empty cart List!",
                                    bgColor: KColor.errorRedText)
                                : checkLogin
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CheckoutPage()))
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                          },
                          title: "CheckOut",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
    });
  }

  text(String title, String price) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, bottom: 3, right: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.bodyText1.copyWith(color: KColor.textgrey),
          ),
          Text(
            price,
            style: TextStyles.bodyText1.copyWith(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
