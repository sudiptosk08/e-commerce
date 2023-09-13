import 'package:ecommerce_app/features/view/screens/shop/view/shop_page.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/product_card.dart/popular_product_card.dart';

class NewArrivalsProduct extends StatefulWidget {
  const NewArrivalsProduct({super.key});

  @override
  _NewArrivalsProductState createState() => _NewArrivalsProductState();
}

class _NewArrivalsProductState extends State<NewArrivalsProduct> {
  List<dynamic> product = [
    {
      'id': 1,
      'imagePath': AppAssets.shoe1,
      'productName': "Party Dress Black -120 fabrics cloths Medimu Size",
      'price': 240,
      'ratingStar': 5,
      'discountPrice': 160,
      'appDiscount': 4
    },
    {
      'id': 2,
      'imagePath': AppAssets.shoe2,
      'productName': "Party Dress Black liaud iuweyr klasdl",
      'price': 180,
      'ratingStar': 5,
      'discountPrice': 120,
      'appDiscount': 6
    },
    {
      'id': 3,
      'imagePath': AppAssets.shoe3,
      'productName': "Party Dress Black asraf hosainlk adsl",
      'price': 700,
      'ratingStar': 13,
      'discountPrice': 590,
      'appDiscount': 5
    },
    {
      'id': 4,
      'imagePath': AppAssets.shoe5,
      'productName': "Party Dress Black Uhouas Jidhai Ieasl",
      'price': 24.00,
      'ratingStar': 5,
      'discountPrice': 20,
      'appDiscount': 3
    },
  ];
  @override
  Widget build(BuildContext context) {
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ShopPage()));
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
                product.length,
                (index) {
                  return PopularProductCard(
                      id: product[index]['id'].toString(),
                      imagePath: product[index]['imagePath'],
                      productName: product[index]['productName'],
                      appDiscount: product[index]['appDiscount'],
                      price: product[index]['price'].toString(),
                      ratingStar: product[index]['ratingStar'],
                      discountPrice:
                          product[index]['discountPrice'].toString());
                  // here by default width and height is 0
                },
              ),
            ],
          ),
        )
      ]),
    );
  }
}
