import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/model/product_list_model.dart';
import 'package:ecommerce_app/features/view/screens/shop/state/product_list_state.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/features/view/screens/product_details/product_details_page.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/product_card.dart/product_card.dart';
import '../../shop/view/shop_page.dart';

class PopularProduct extends StatefulWidget {
  const PopularProduct({super.key});

  @override
  _PopularProductState createState() => _PopularProductState();
}

class _PopularProductState extends State<PopularProduct> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final shopState = ref.watch(productListProvider);
      final List<ProductListData> productListData =
          shopState is ProductListSuccessState
              ? shopState.productListModel!.data
              : [];
      return Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New & Noteworthy",
                  style: TextStyles.subTitle,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, SlideLeftRoute(page: const ShopPage()));
                  },
                  child: Text(
                    "view all",
                    style:
                        TextStyles.bodyText1.copyWith(color: KColor.secondary),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
              child: Row(
                children: [
                  ...List.generate(
                    productListData.length,
                    (index) {
                      return ProductCard(
                        id: productListData[index].id.toString(),
                        imagePath: productListData[index].thumbnail,
                        productName: productListData[index].name,
                        appDiscount: productListData[index].discount.toInt(),
                        price: productListData[index].price.toString(),
                        ratingStar: productListData[index].rating.toInt(),
                        category: productListData[index].category.slug,
                        wishList: productListData[index].wishlist,
                        discountPrice:
                            productListData[index].discountPrice.toString(),
                        tap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ProductDetailsPage(),
                              ));
                        },
                      );
                      // here by default width and height is 0
                    },
                  ),
                ],
              ),
            )
          ]));
    });
  }
}
