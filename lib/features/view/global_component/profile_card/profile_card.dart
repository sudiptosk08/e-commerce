import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_styles/text_styles.dart';

class ProfileCard extends StatelessWidget {
  final String? title;
  final String? image;
  final VoidCallback onPressed;

  const ProfileCard({this.title, this.image, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: const BoxDecoration(color: KColor.background),
        padding: const EdgeInsets.symmetric(vertical: 0),
        width: context.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(
              color: KColor.white,
              thickness: 0.9,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$title',
                            style: TextStyles.subTitle1.copyWith(
                                color: KColor.textgrey,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: KColor.textgrey,
                    ))
              ],
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            Divider(
              color: KColor.white,
              thickness: 0.9,
            )
          ],
        ),
      ),
    );
  }
}
