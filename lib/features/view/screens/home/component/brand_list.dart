import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/text_styles/text_styles.dart';

class BrandSection extends StatefulWidget {
  const BrandSection({Key? key}) : super(key: key);

  @override
  State<BrandSection> createState() => _BrandSectionState();
}

class _BrandSectionState extends State<BrandSection> {
  int selectIndex = -1;
  List<dynamic> categories = [
    {
      'image':
          "https://chaldn.com/asset/Egg.ChaldalWeb.Fabric/Egg.ChaldalWeb1/1.0.0+Deploy-Release-324/Default/stores/chaldal/components/landingPage2/LandingPage/images/pran.png?q=low&webp=1",
      'name': "Pran",
    },
    {
      'image':
          "https://chaldn.com/asset/Egg.ChaldalWeb.Fabric/Egg.ChaldalWeb1/1.0.0+Deploy-Release-324/Default/stores/chaldal/components/landingPage2/LandingPage/images/uniliver.png?q=low&webp=1",
      'name': "Unilever",
    },
    {
      'image':
          "https://chaldn.com/asset/Egg.ChaldalWeb.Fabric/Egg.ChaldalWeb1/1.0.0+Deploy-Release-324/Default/stores/chaldal/components/landingPage2/LandingPage/images/nestle.png?q=low&webp=1",
      'name': "Nestle",
    },
    {
      'image':
          "https://chaldn.com/asset/Egg.ChaldalWeb.Fabric/Egg.ChaldalWeb1/1.0.0+Deploy-Release-324/Default/stores/chaldal/components/landingPage2/LandingPage/images/nestle.png?q=low&webp=1",
      'name': "Marico",
    },
    {
      'image':
          "https://brand.assets.adidas.com/image/upload/icon_smart_app_banner_3c2a6e1def.png",
      'name': "Adidas",
    },
    {
      'image':
          "https://chaldn.com/asset/Egg.ChaldalWeb.Fabric/Egg.ChaldalWeb1/1.0.0+Deploy-Release-324/Default/stores/chaldal/components/landingPage2/LandingPage/images/fresh.png?q=low&webp=1",
      'name': "Fresh",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 120,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // // setState(() => selectIndex = index);
                      // ref.read(shopProvider.notifier).fetchShopProductList(
                      //     groupId: categoryData[index].id, categoryId: "", str: "");
                      // Navigator.pushNamed(context, '/shop');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: KColor.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 5, top: 5),
                                child:
                                    Image.network(categories[index]['image']),
                              ),
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            Text(categories[index]['name'],
                                style: TextStyles.bodyText3),
                            const SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
    );
  }
}
