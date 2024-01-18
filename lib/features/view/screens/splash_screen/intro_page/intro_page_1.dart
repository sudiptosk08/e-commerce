import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: KSize.getWidth(context, 336),
          height: KSize.getHeight(context, 340),
          child: Image.asset(
            "assets/icons/splash1.png",
          ),
        ),
        SizedBox(
          width: KSize.getWidth(context, 252),
          height: KSize.getHeight(context, 80),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Update product everyday",
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
              "We provide everything that you desire from ecommerce",
              style: TextStyles.bodyText3,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
