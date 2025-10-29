// ignore_for_file: file_names

import 'package:ecommerce_app/features/view/global_component/shop_store/shop_store_card.dart';
import 'package:ecommerce_app/features/view/screens/shop_store/shop_store_page.dart';
import 'package:ecommerce_app/features/view/screens/shop_store_details/shop_store_details_page.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';

class ShopStoreList extends StatefulWidget {
  const ShopStoreList({super.key});

  @override
  _ShopStoreListState createState() => _ShopStoreListState();
}

class _ShopStoreListState extends State<ShopStoreList> {
  List<dynamic> store = [
    {
      'id': 1,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/3670d41c-f083-4e87-81eb-1ec37dd27482?h=350&w=350",
      'shopName': "Diamond Plaza ",
      'ratingStar': 5,
    },
    {
      'id': 2,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/25185cbc-3340-40a9-8a77-7b7c57067130?h=350&w=350",
      'shopName': "Ajanta Shoes",
      'ratingStar': 3,
    },
    {
      'id': 3,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/7f4646c1-6e94-43ef-98d3-7def922409bc?h=350&w=350",
      'shopName': "Opera Mall",
      'ratingStar': 5,
    },
    {
      'id': 4,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/9f768178-4ede-40ed-b1ec-0244df11e5ea?h=350&w=350",
      'shopName': "Nutrinix Food ",
      'ratingStar': 4.5,
    },
    {
      'id': 5,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/7343818c-4068-4787-9333-92ad5de0bab9?h=350&w=350",
      'shopName': "Transcom",
      'ratingStar': 4,
    },
    {
      'id': 6,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/c6f8a30f-6d26-43ec-9e82-05f90c16b367?h=350&w=350",
      'shopName': "Nestle",
      'ratingStar': 4,
    },
    {
      'id': 7,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/bbe2d1fa-0bbb-4080-83d4-4f96cc5dec5d?h=350&w=350",
      'shopName': "Jamuna Electronics ",
      'ratingStar': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 13, right: 13, bottom: 3),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 3, right: 3, bottom: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shop & Store",
                style: TextStyles.subTitle1,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShopStorePage()));
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
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast),
          child: Row(
            children: [
              ...List.generate(
                store.length,
                (index) {
                  return ShopStoreCard(
                    id: store[index]['id'].toString(),
                    imagePath: store[index]['imagePath'],
                    shopName: store[index]['shopName'],
                    ratingStar: 5,
                    tap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShopStoreDetailsPage(
                                    shopName: store[index]['shopName'],
                                    shopImage: store[index]['imagePath'],
                                    shopAddress:
                                        "Dhaka,Banasress,Block J, Road 3",
                                  )));
                    },
                  );
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
