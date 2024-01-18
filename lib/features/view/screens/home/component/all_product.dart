// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/global_component/shimmer/placeholder_shimmer.dart';
import 'package:ecommerce_app/features/view/screens/product_details/controller/product_details_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/model/product_list_model.dart';
import 'package:ecommerce_app/features/view/screens/shop/state/product_list_state.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/features/view/screens/product_details/product_details_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/product_card.dart/product_card.dart';
import '../../shop/view/shop_page.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final shopState = ref.watch(productListProvider);
      final List<ProductListData> productListData =
          shopState is ProductListSuccessState
              ? shopState.productListModel!.data
              : [];
      return Container(
          padding: const EdgeInsets.only(left: 13, right: 13),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Product",
                  style: TextStyles.subTitle1,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          SlideLeftRoute(
                              page: ShopPage(
                            index: "",
                            title: "All Product",
                          )));
                    },
                    child: Row(
                      children: [
                        Text(
                          "View All",
                          style: TextStyles.bodyText2
                              .copyWith(color: KColor.secondary),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: KColor.secondary,
                        ),
                      ],
                    ))
              ],
            ),
            shopState is! ProductListSuccessState
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: List.generate(
                              5,
                              (index) => const ContentPlaceholder(
                                    lineType: ContentLineType.threeLines,
                                  )),
                        ),
                      ),
                    ))
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.fast),
                    child: Row(
                      children: [
                        ...List.generate(
                          productListData.length,
                          (index) {
                            return ProductCard(
                              type: "New adsfwsd",
                              id: productListData[index].id.toString(),
                              imagePath: "assets/product/product1.png",
                              productName: productListData[index].name,
                              appDiscount:
                                  productListData[index].discount.toInt(),
                              price: productListData[index].price.toString(),
                              ratingStar: productListData[index].rating.toInt(),
                              category: productListData[index].category.slug,
                              wishList: productListData[index].wishlist,
                              discountPrice: productListData[index]
                                  .discountPrice
                                  .toString(),
                              tap: () {
                                NavigationService.navigateTo(SizeRoute(
                                  page: const ProductDetailsPage(),
                                ));
                                ref
                                    .read(productDetailsProvider.notifier)
                                    .fetchProductsDetails(
                                        productListData[index].slug);
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
