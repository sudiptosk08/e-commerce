import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
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
                    height: 40,
                    margin: const EdgeInsets.only(top: 7, right: 3),
                    decoration: const BoxDecoration(
                      color: KColor.background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: KColor.red,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
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
                          color: KColor.errorRedText,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          appDiscount > 0
                              ? TextSpan(
                                  text: " ৳ $price",
                                  style: TextStyles.subTitle1.copyWith(
                                      color: KColor.grey,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: KColor.grey),
                                )
                              : TextSpan(
                                  text: " ৳ $price",
                                  style: TextStyles.subTitle1.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: KColor.errorRedText,
                                    letterSpacing: 0.3,
                                  ),
                                )
                        ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 17,
                        color: KColor.yellow,
                      ),
                      Text(
                        " $ratingStar",
                        style: TextStyles.bodyText2.copyWith(
                          color: KColor.grey,
                        ),
                      ),
                      Text(
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
