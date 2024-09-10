import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../../utils/size/k_size.dart';
import '../../../../utils/text_styles/text_styles.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.discountPrice,
    required this.id,
    required this.category,
    required this.appDiscount,
    required this.wishList,
    required this.tap,
    required this.type,
    required this.stock,
    required this.ratingStar,
    required this.width,
  }) : super(key: key);

  final int appDiscount;
  final String imagePath;
  final String productName;
  final String category;
  final String price;
  final String discountPrice;
  final String id;
  final VoidCallback? tap;
  final bool wishList;
  final String type;
  final String stock;
  final int width;
  final int ratingStar;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      borderRadius: BorderRadius.circular(5),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: KColor.background,
        color: KColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: KSize.getWidth(context, width),
              height: KSize.getHeight(context, 150),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: KColor.white,
                image: DecorationImage(
                  image: NetworkImage(imagePath),
                  fit: BoxFit.scaleDown,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 30,
                    margin: const EdgeInsets.only(top: 7, right: 3),
                    decoration: const BoxDecoration(
                      color: KColor.background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: KColor.red,
                      size: 19,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.9,
              color: KColor.background,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 7, bottom: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyles.bodyText1),
                  Text.rich(
                    TextSpan(
                        text: appDiscount > 0 ? "৳ $discountPrice " : null,
                        style: TextStyles.subTitle1.copyWith(
                          fontSize: 17,
                          color: KColor.red,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          appDiscount > 0
                              ? TextSpan(
                                  text: " ৳ $price",
                                  style: TextStyles.subTitle1.copyWith(
                                      color: KColor.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: KColor.grey),
                                )
                              : TextSpan(
                                  text: " ৳ $price",
                                  style: TextStyles.subTitle1.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: KColor.red,
                                   
                                    letterSpacing: 0.3,
                                  ),
                                )
                        ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      type == "New Arrival"
                          ? const Icon(
                              Icons.star,
                              size: 17,
                              color: KColor.yellow,
                            )
                          : SmoothStarRating(
                              rating: ratingStar.toDouble(),
                              size: 15,
                              color: KColor.yellow,
                              borderColor: KColor.yellow,
                            ),
                      type == "New Arrival"
                          ? Text(
                              " 4.2",
                              style: TextStyles.bodyText2.copyWith(
                                color: KColor.grey,
                              ),
                            )
                          : Text(
                              " ($stock)",
                              style: TextStyles.bodyText2.copyWith(
                                color: KColor.grey,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
