import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: KSize.getWidth(context, 336),
          height: KSize.getHeight(context, 340),
          child: Image.asset(
            "assets/icons/splash3.png",
          ),
        ),
        SizedBox(
          width: KSize.getWidth(context, 252),
          height: KSize.getHeight(context, 80),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Free Shipping vouchers ",
              style: TextStyles.headline3,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          width: KSize.getWidth(context, 252),
          height: KSize.getHeight(context, 75),
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40),
            child: Text(
              "Unlimited free vouchers to great shopping experience",
              style: TextStyles.bodyText3,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
