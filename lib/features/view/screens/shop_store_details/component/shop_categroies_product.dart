// ignore_for_file: non_constant_identifier_names

import 'package:ecommerce_app/features/view/global_component/product_card.dart/product_card.dart';
import 'package:ecommerce_app/features/view/screens/product_details/product_details_page.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:flutter/material.dart';

class ShopCategoriesProduct extends StatefulWidget {
  final String OrderStatus;

  const ShopCategoriesProduct({Key? key, required this.OrderStatus})
      : super(key: key);

  @override
  State<ShopCategoriesProduct> createState() => _ShopCategoriesProductState();
}

class _ShopCategoriesProductState extends State<ShopCategoriesProduct> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: 7.5 / 10,
      ),
      itemCount: 7,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return ProductCard(
          id: "",
          category: "Ki jani re bhai",
          type: "Hoasd ansult",
          wishList: false,
          imagePath: AppAssets.product2,
          productName: "Mens T-shirt with fabricsi caoton cloths",
          discountPrice: "12.0",
          price: "20.35",
          appDiscount: 0,
          ratingStar: 5,
          tap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductDetailsPage(
                  
                  ),
                ));
          },
        );
      },
    );
  }
}
