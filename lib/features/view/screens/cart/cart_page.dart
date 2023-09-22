import 'dart:convert';
import 'package:ecommerce_app/features/view/global_component/dialog/k_confirm_dialog.dart';
import 'package:ecommerce_app/features/view/screens/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../navigation_bar.dart';
import '../../../../utils/size/k_size.dart';
import '../../global_component/appBar/app_bar.dart';
import '../../global_component/buttons/Kdrop_down_field.dart';
import '../../global_component/gray_handle/gray_handle.dart';
import '../checkout/checkout_page.dart';

class CartPage extends ConsumerStatefulWidget {
  CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCartItems();
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
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: KAppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavigationBarScreen(
                                  page: "0",
                                )));
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              checkTitle: true,
              title: "Cart",
            ),
          ),
          backgroundColor: KColor.background,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
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
                              return Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.endToStart,
                                dragStartBehavior: DragStartBehavior.start,
                                movementDuration:
                                    const Duration(milliseconds: 200),
                                resizeDuration:
                                    const Duration(milliseconds: 1000),
                                onDismissed: (direction) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return KConfirmDialog(
                                          message: 'Delete product',
                                          subMessage:
                                              'Are you sure you want to remove this item?"',
                                          onCancel: () {
                                            //cancel
                                          },
                                          onDelete: () {
                                            //delete,
                                          });
                                    },
                                  );
                                },
                                background: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  decoration: const BoxDecoration(
                                    color: KColor.errorRedText,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [Icon(Icons.delete)],
                                  ),
                                ),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: KColor.textgrey
                                                .withOpacity(0.4)),
                                        color: KColor.white,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Container(
                                              width:
                                                  KSize.getWidth(context, 125),
                                              height:
                                                  KSize.getHeight(context, 102),
                                              decoration: BoxDecoration(
                                                color: KColor.grey200!
                                                    .withOpacity(1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(7)),
                                              ),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  7)),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                        "${cartItems[index]['thumbnail']}",
                                                      )))),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: SizedBox(
                                              width: context.screenWidth * 0.55,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(cartItems[index]['name'],
                                                      style:
                                                          TextStyles.bodyText1),
                                                  SizedBox(
                                                      height: KSize.getHeight(
                                                          context, 3)),
                                                  Text(
                                                    "Color:${cartItems[index]['color']}  Size :${cartItems[index]['size']}",
                                                    style: TextStyles.bodyText1
                                                        .copyWith(
                                                            color: KColor.grey),
                                                  ),
                                                  SizedBox(
                                                      height: KSize.getHeight(
                                                          context, 6)),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "\$${cartItems[index]['price']}",
                                                        style: TextStyles
                                                            .subTitle
                                                            .copyWith(
                                                                color: KColor
                                                                    .errorRedText),
                                                      ),
                                                      Container(
                                                        width: 115,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                                width: 0.9,
                                                                color: KColor
                                                                    .gray)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                cartItems[index]
                                                                            [
                                                                            'quantity'] ==
                                                                        1
                                                                    ? null
                                                                    : setState(
                                                                        () {
                                                                        ref
                                                                            .read(cartProvider.notifier)
                                                                            .addToCart(
                                                                              cartItems[index]['id'],
                                                                              cartItems[index]['quantity'].toInt(),
                                                                              cartItems[index]['name'],
                                                                              cartItems[index]['category_name'],
                                                                              cartItems[index]['sub_categroy_name'],
                                                                              cartItems[index]['size'],
                                                                              cartItems[index]['color'],
                                                                              cartItems[index]['price'],
                                                                              cartItems[index]['brand'],
                                                                              cartItems[index]['thumbnail'],
                                                                              cartItems[index]['colorId'],
                                                                              cartItems[index]['sizeId'],
                                                                            );
                                                                        cartItems[index]['quantity'] ==
                                                                                1
                                                                            ? null
                                                                            : ref.read(cartProvider.notifier).addQuantity =
                                                                                false;
                                                                        cartItems[index]['quantity'] ==
                                                                                1
                                                                            ? null
                                                                            : ref.read(cartProvider.notifier).minusQuantity =
                                                                                true;
                                                                      });
                                                                loadCartItems();
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        border:
                                                                            Border(
                                                                  right: BorderSide(
                                                                      width:
                                                                          0.9,
                                                                      color: KColor
                                                                          .gray),
                                                                )),
                                                                width: 35,
                                                                height: 35,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    const Icon(
                                                                  Icons.remove,
                                                                  size: 18,
                                                                  color: KColor
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 37,
                                                              child: Text(
                                                                cartItems[index]
                                                                        [
                                                                        'quantity']
                                                                    .toString(),
                                                                style: TextStyles
                                                                    .bodyText1,
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
                                                                            [
                                                                            'id'],
                                                                        cartItems[index]
                                                                            [
                                                                            'quantity'],
                                                                        cartItems[index]
                                                                            [
                                                                            'name'],
                                                                        cartItems[index]
                                                                            [
                                                                            'category_name'],
                                                                        cartItems[index]
                                                                            [
                                                                            'sub_categroy_name'],
                                                                        cartItems[index]
                                                                            [
                                                                            'size'],
                                                                        cartItems[index]
                                                                            [
                                                                            'color'],
                                                                        cartItems[index]
                                                                            [
                                                                            'price'],
                                                                        cartItems[index]
                                                                            [
                                                                            'brand'],
                                                                        cartItems[index]
                                                                            [
                                                                            'thumbnail'],
                                                                        cartItems[index]
                                                                            [
                                                                            'colorId'],
                                                                        cartItems[index]
                                                                            [
                                                                            'sizeId'],
                                                                      );

                                                                  ref
                                                                      .read(cartProvider
                                                                          .notifier)
                                                                      .addQuantity = true;
                                                                  ref
                                                                      .read(cartProvider
                                                                          .notifier)
                                                                      .minusQuantity = false;
                                                                });
                                                                loadCartItems();
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border: Border(
                                                                      left: BorderSide(
                                                                          width:
                                                                              0.9,
                                                                          color:
                                                                              KColor.gray)),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: 35,
                                                                height: 35,
                                                                child:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  size: 18,
                                                                  color: KColor
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
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
            height: KSize.getHeight(context, 170),
            decoration: BoxDecoration(border: Border.all(color: KColor.white)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Column(
                    children: [
                      const GrayHandle(),
                      text("SubTotal",
                          "৳${ref.read(cartProvider.notifier).subTotal}"),
                      Divider(
                        color: KColor.grey350,
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      text("Total",
                          "৳${ref.read(cartProvider.notifier).subTotal}"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: KButton(
                    width: double.infinity,
                    height: 40,
                    isOutlineButton: false,
                    radius: 8,
                    color: KColor.primary,
                    textStyle: TextStyles.bodyText1.copyWith(
                        color: KColor.white, fontWeight: FontWeight.w500),
                    onPressedCallback: () {
                      cartItems.isEmpty
                          ? toast("Empty cart List!",
                              bgColor: KColor.errorRedText)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CheckoutPage()));
                    },
                    title: "CheckOut",
                  ),
                ),
              ],
            ),
          ));
    });
  }
  text(String title, String price) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.bodyText1,
          ),
          Text(
            price,
            style: TextStyles.bodyText1,
          )
        ],
      ),
    );
  }
}
