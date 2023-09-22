import 'package:ecommerce_app/features/view/screens/home/controller/popular_product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/home/state/popular_product_state.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/model/product_list_model.dart';
import 'package:ecommerce_app/features/view/screens/shop/view/shop_page.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/product_card.dart/popular_product_card.dart';

class NewArrivalsProduct extends StatefulWidget {
  const NewArrivalsProduct({super.key});

  @override
  _NewArrivalsProductState createState() => _NewArrivalsProductState();
}

class _NewArrivalsProductState extends State<NewArrivalsProduct> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final shopState = ref.watch(popularProductProvider);
      final List<ProductListData> productListData =
          shopState is PopularProductSuccessState
              ? shopState.popularProductModel!.data
              : [];
      return Container(
        padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Product",
                style: TextStyles.subTitle,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShopPage()));
                },
                child: Text(
                  "view all",
                  style: TextStyles.bodyText1.copyWith(color: KColor.secondary),
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
                    return PopularProductCard(
                        id: productListData[index].id.toString(),
                        imagePath: productListData[index].thumbnail,
                        productName: productListData[index].name,
                        category: productListData[index].category.name,
                        appDiscount: productListData[index].discount.toInt(),
                        price: productListData[index].price.toString(),
                        ratingStar: productListData[index].rating.toInt(),
                        discountPrice:
                            productListData[index].discountPrice.toString());
                    // here by default width and height is 0
                  },
                ),
              ],
            ),
          )
        ]),
      );
    });
  }
}
