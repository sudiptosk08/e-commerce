import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
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
    required this.ratingStar,
    required this.category,
    required this.appDiscount,
    required this.wishList,
    required this.tap,
    required this.type,
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
  final int ratingStar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        width: KSize.getWidth(context, 144),
        decoration: const BoxDecoration(
          color: Color(0xffF9F9F9),
          borderRadius:  BorderRadius.all(Radius.circular(8)),
        ),
        child: GestureDetector(
          onTap: tap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    height: KSize.getHeight(context, 115),
                    width: KSize.getHeight(context, 175),
                    decoration: BoxDecoration(
                      color: Color(0xffF9F9F9),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                type == "New Arrival"
                    ? Positioned(
                        left: 3,
                        top: 5,
                        child: Container(
                          width: 27,
                          height: 27,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: KColor.background,
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "new",
                            style: TextStyles.bodyText3.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 11,
                                color: KColor.errorRedText),
                          ),
                        ),
                      )
                    : appDiscount > 0
                        ? Positioned(
                            left: 3,
                            top: 5,
                            child: Container(
                              width: 27,
                              height: 27,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: KColor.background,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "$appDiscount%",
                                style: TextStyles.bodyText3.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: KColor.errorRedText),
                              ),
                            ),
                          )
                        : Container(),
                Positioned(
                  right: 3,
                  top: 5,
                  child: Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                        color: wishList == false
                            ? KColor.background
                            : KColor.errorRedText,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      size: 18,
                      color: wishList == false
                          ? KColor.errorRedText
                          : KColor.white,
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
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
                      const SizedBox(
                        height: 2,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: appDiscount > 0 ? 3.5 : 0),
                        child: Text.rich(TextSpan(
                            text: appDiscount > 0 ? "৳ $discountPrice " : null,
                            style: TextStyles.bodyText2.copyWith(
                              color: KColor.errorRedText,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              appDiscount > 0
                                  ? TextSpan(
                                      text: " ৳ $price",
                                      style: TextStyles.bodyText2.copyWith(
                                        color: KColor.textgrey,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    )
                                  : TextSpan(
                                      text: " ৳ $price",
                                      style: TextStyles.bodyText2.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: KColor.errorRedText,
                                        letterSpacing: 0.3,
                                      ),
                                    )
                            ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SmoothStarRating(
                              rating: 5,
                              size: 14,
                              color: KColor.yellow,
                            ),
                            Text(
                              " (650)",
                              style: TextStyles.bodyText2.copyWith(
                                color: KColor.textgrey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  type == "Shop"
                      ? Container(
                          width: 32,
                          height: 32,
                          margin: const EdgeInsets.only(top: 5, right: 7),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: KColor.primary,
                              borderRadius: BorderRadius.circular(50)),
                          child: Image.asset(
                            AppAssets.bag,
                            color: KColor.white,
                            fit: BoxFit.contain,
                            height: 20,
                            width: 19,
                          ))
                      : Container()
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
