import 'package:ecommerce_app/features/view/global_component/product_card.dart/product_card.dart';
import 'package:ecommerce_app/features/view/global_component/slider_image/k_slider_image.dart';
import 'package:ecommerce_app/features/view/screens/product_details/product_details_page.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class StoreHomePage extends StatefulWidget {
  const StoreHomePage({super.key});

  @override
  State<StoreHomePage> createState() => _StoreHomePageState();
}

class _StoreHomePageState extends State<StoreHomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                border: Border.all(color: KColor.white),
                borderRadius: BorderRadius.circular(7)),
            child: const KImageSlider(),
          ),
          const SizedBox(
            height: 7,
          ),
          ProductCard(
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
                    builder: (context) => const ProductDetailsPage(),
                  ));
            },
          ),
          const SizedBox(
            height: 7,
          ),
          ProductCard(
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
                    builder: (context) => const ProductDetailsPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
