import 'package:flutter/material.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.name,
      required this.onTap,
      required this.width,
      required this.height,
      required this.textColor,
      required this.color});
  final String name;
  final double width;
  final double height;
  final Color color;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            name,
            style: TextStyles.bodyText1
                .copyWith(color: KColor.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
