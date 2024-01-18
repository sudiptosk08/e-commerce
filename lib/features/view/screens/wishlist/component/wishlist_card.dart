// ignore_for_file: must_be_immutable

import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';

import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/buttons/custom_button.dart';
import '../../../global_component/dialog/k_confirm_dialog.dart';

class WishListCard extends StatefulWidget {
  int? quantity;
  int? productId;
  final String? img;
  final bool? isChecked;
  final String? productName;
  final String? group;
  final int? price;
  final int? disprice;
  final int? appDiscount;

  int? total;
  final VoidCallback? cancel;
  final VoidCallback? delete;
  final VoidCallback? add;

  WishListCard({
    Key? key,
    this.quantity,
    required this.productId,
    required this.img,
    this.isChecked,
    this.productName,
    this.group,
    this.price,
    this.disprice,
    this.appDiscount,
    this.total,
    this.cancel,
    this.delete,
    this.add,
  }) : super(key: key);

  @override
  State<WishListCard> createState() => _WishListCardState();
}

class _WishListCardState extends State<WishListCard> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: KColor.containerColor,
          border: Border.all(
              color: KColor.containerColor.withOpacity(0.4), width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: context.screenWidth * 0.35,
            height: context.screenHeight * 0.15,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
                // child: Image.network(
                //   "${widget.img}",
                //   fit: BoxFit.fill,
                // ),
                child: Image.asset(AppAssets.product1),
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: KSize.getWidth(context, 205),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.productName}',
                  maxLines: 2,
                  style: TextStyles.bodyText1.copyWith(color: KColor.black),
                ),
                Text(
                  '${widget.group}',
                  style: TextStyles.bodyText1.copyWith(color: KColor.textgrey),
                ),
                SmoothStarRating(
                  color: KColor.yellow,
                  borderColor: KColor.yellow,
                  size: 15,
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text(
                    //   "৳${widget.price.toString()}",
                    //   style: TextStyles.headline4
                    //       .copyWith(color: KColor.errorRedText),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: widget.appDiscount! > 0 ? 1 : 0),
                          child: Text.rich(TextSpan(
                              text: widget.appDiscount! > 0
                                  ? "৳ ${widget.disprice} "
                                  : null,
                              style: TextStyles.subTitle1.copyWith(
                                color: KColor.errorRedText,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                widget.appDiscount! > 0
                                    ? TextSpan(
                                        text: " ৳ ${widget.price.toString()}",
                                        style: TextStyles.subTitle1.copyWith(
                                          color: KColor.textgrey,
                                          fontWeight: FontWeight.w600,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )
                                    : TextSpan(
                                        text: " ৳ ${widget.price}",
                                        style: TextStyles.subTitle1.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: KColor.errorRedText,
                                          letterSpacing: 0.3,
                                        ),
                                      )
                              ])),
                        ),
                        Row(
                          children: [
                            Text(
                              "Status : ",
                              style: TextStyles.bodyText2
                                  .copyWith(color: KColor.textgrey),
                            ),
                            Text(
                              "In stock",
                              style: TextStyles.bodyText2
                                  .copyWith(color: KColor.primary),
                            ),
                          ],
                        )
                      ],
                    ),
                    widget.isChecked == true
                        ? InkWell(
                            onTap: widget.add,
                            child: Container(
                                width: 40,
                                height: 32,
                                decoration: const BoxDecoration(
                                    color: KColor.background,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: KColor.errorRedText,
                                  size: 19,
                                )))
                        : Row(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  setState(() {
                                    widget.quantity = (widget.quantity! + 1);
                                  });
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: KColor.black, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.add,
                                        size: 10, color: KColor.textgrey),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  widget.quantity.toString(),
                                  style: TextStyles.headline4.copyWith(
                                    color: KColor.black,
                                  ),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  if (widget.quantity! > 1) {
                                    setState(() {
                                      widget.quantity = (widget.quantity! - 1);
                                    });
                                  }
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: KColor.white, width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                      child: Icon(Icons.remove,
                                          size: 10, color: KColor.black)),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
