import 'package:ecommerce_app/features/view/global_component/buttons/Kdrop_down_field.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../utils/size/k_size.dart';
import '../../../../utils/text_styles/text_styles.dart';

class PopularProductCard extends StatelessWidget {
  const PopularProductCard({
    Key? key,
    this.width = 45,
    this.aspectRatio = 1.02,
    required this.imagePath,
    required this.productName,
    required this.category,
    required this.price,
    required this.discountPrice,
    required this.id,
    required this.ratingStar,
    required this.appDiscount,
  }) : super(key: key);

  final double width, aspectRatio;
  final String category;
  final int appDiscount;
  final String imagePath;
  final String productName;
  final String price;
  final String discountPrice;
  final String id;
  final int ratingStar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: KSize.getWidth(context, 274),
        decoration: BoxDecoration(
          color: KColor.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: GestureDetector(
          onTap: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Stack(children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 14),
                    width: KSize.getWidth(context, 125),
                    height: KSize.getWidth(context, 122),
                    decoration: BoxDecoration(
                      color: KColor.grey200!.withOpacity(1),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage(
                                  "assets/product/product1.png", //imagePath,
                                )))),
                  ),
                  Positioned(
                      top: 2,
                      left: 6,
                      child: Text(
                        "$appDiscount% Off",
                        style: TextStyles.bodyText3.copyWith(
                          fontWeight: FontWeight.w600,
                          color: KColor.errorRedText,
                          letterSpacing: 0.3,
                        ),
                      ))
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                  width: KSize.getWidth(context, 124),
                  height: KSize.getWidth(context, 122),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(right: appDiscount > 0 ? 3.5 : 0),
                        child: Text.rich(TextSpan(
                            text: appDiscount > 0 ? "৳ $discountPrice " : null,
                            style: TextStyles.subTitle1.copyWith(
                              color: KColor.errorRedText,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              appDiscount > 0
                                  ? TextSpan(
                                      text: "৳ $price",
                                      style: TextStyles.subTitle1.copyWith(
                                        color: KColor.primary,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    )
                                  : TextSpan(
                                      text: "৳ $price",
                                      style: TextStyles.subTitle1.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: KColor.errorRedText,
                                        letterSpacing: 0.3,
                                      ),
                                    )
                            ])),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star,
                            color: KColor.primary,
                            size: 19,
                          ),
                          Text(
                            "4.9 ",
                            textAlign: TextAlign.center,
                            style: TextStyles.subTitle1,
                          ),
                        ],
                      ),
                      Text(
                        productName,
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.bodyText1,
                      ),
                      Text(
                        category,
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.bodyText1
                            .copyWith(color: KColor.black54),
                      ),
                      KButton(
                        color: KColor.primary,
                        height: 30,
                        width: KSize.getWidth(context, 124),
                        radius: 8,
                        title: "Add to Cart",
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget colorContainer(Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: CircleAvatar(maxRadius: 8, minRadius: 8, backgroundColor: color),
    );
  }
}
