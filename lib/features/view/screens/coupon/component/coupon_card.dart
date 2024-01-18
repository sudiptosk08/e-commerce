import 'package:ecommerce_app/features/view/global_component/buttons/Kdrop_down_field.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CouponCard extends StatelessWidget {
  String couponTitle;
  String couponDetails;
  String discount;
  CouponCard(
      {required this.couponTitle,
      required this.couponDetails,
      required this.discount,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: context.screenWidth,
      height: KSize.getHeight(context, 155),
      decoration: BoxDecoration(
          color: KColor.white,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40.0, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  couponTitle,
                  style: TextStyles.subTitle1.copyWith(
                      color: KColor.errorRedText,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  couponDetails,
                  style: TextStyles.bodyText2.copyWith(
                    color: KColor.textgrey,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SvgPicture.asset("assets/svg/Group.svg"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(discount,
                        style: TextStyles.bodyText2.copyWith(
                          color: KColor.textgrey,
                        )),
                  ],
                )
              ],
            ),
          ),
          const Positioned(
              left: -40,
              top: 35,
              child: CircleAvatar(
                backgroundColor: KColor.background,
                radius: 30,
              )),
          const Positioned(
              right: -40,
              top: 35,
              child: CircleAvatar(
                backgroundColor: KColor.background,
                radius: 30,
              )),
          Positioned(
            bottom: 0,
            child: KButton(
              height: 40,
              width: context.screenWidth * 0.91,
              isOutlineButton: false,
              radius: 8,
              color: Color(0xff00CEB4),
              textStyle: TextStyles.bodyText1
                  .copyWith(color: KColor.white, fontWeight: FontWeight.w500),
              onPressedCallback: () {},
              title: "Copy",
            ),
          ),
        ],
      ),
    );
  }
}
