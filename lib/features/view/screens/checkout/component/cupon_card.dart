import 'package:ecommerce_app/features/view/global_component/text_field_container/k_text_field.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/buttons/Kdrop_down_field.dart';

class CouponCodeCard extends StatelessWidget {
  // final String? title;
  final String? hintText;
  final String? buttonText;
  final TextEditingController? controller;
  final VoidCallback? tap;
  final bool? readOnly;

  const CouponCodeCard({
    Key? key,
    // this.title,
    this.readOnly,
    this.hintText,
    this.buttonText,
    this.controller,
    this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(title!, style: TextStyles.subTitle),
        const SizedBox(height: 2),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                color: KColor.grey300,
                padding: const EdgeInsets.all(0.8),
                child: KFillNormal(
                  controller: controller!,
                  hintText: hintText!,
                  label: "",
                  inputType: TextInputType.text,
                  readOnly: readOnly!,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: KButton(
                width: double.infinity,
                height: 47,
                isOutlineButton: false,
                radius: 5,
                color: KColor.primary,
                textStyle: TextStyles.bodyText1
                    .copyWith(color: KColor.white, fontWeight: FontWeight.w500),
                title: buttonText,
                onPressedCallback: tap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
