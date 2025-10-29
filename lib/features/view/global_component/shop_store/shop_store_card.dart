import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../../utils/size/k_size.dart';
import '../../../../utils/text_styles/text_styles.dart';

class ShopStoreCard extends StatelessWidget {
  const ShopStoreCard({
    Key? key,
    required this.imagePath,
    required this.shopName,
    required this.id,
    required this.ratingStar,
    required this.tap,
  }) : super(key: key);

  final String imagePath;
  final String shopName;
  final String id;
  final VoidCallback? tap;
  final int ratingStar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
      child: Container(
        width: KSize.getWidth(context, 160),
        decoration: BoxDecoration(
          color: KColor.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: GestureDetector(
          onTap: tap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.25,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: KColor.grey200!.withOpacity(1),
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 8),
                        child: Image.network(
                          imagePath,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shopName,
                      maxLines: 2,
                      textAlign: TextAlign.justify,
                      style: TextStyles.bodyText2,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SmoothStarRating(
                              color: KColor.yellow,
                              borderColor: KColor.yellow800,
                              rating: 4,
                              size: 15,
                            ),
                            Text(
                              "(2.00)",
                              style: TextStyles.bodyText2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
