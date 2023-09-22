import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/material.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_styles/text_styles.dart';
import '../buttons/Kdrop_down_field.dart';

class KConfirmDialog extends StatelessWidget {
  final String? message;
  final String? subMessage;
  final VoidCallback? onDelete;
  final VoidCallback? onCancel;

  const KConfirmDialog(
      {this.subMessage, this.message, this.onDelete, this.onCancel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: KColor.background,
      insetPadding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: SizedBox(
        height: KSize.getHeight(context, 180),
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text(
                    '$message',
                    textAlign: TextAlign.center,
                    style: TextStyles.headline3.copyWith(
                      color: KColor.black,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '$subMessage',
                  style: TextStyles.bodyText1.copyWith(
                    color: KColor.black.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: KButton(
                        title: 'Cancel',
                        onPressedCallback: onCancel,
                        width: context.screenWidth * 0.4,
                        height: 40,
                        textColor: KColor.white,
                        color: KColor.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: KButton(
                        title: 'Delete',
                        onPressedCallback: onDelete,
                        width: context.screenWidth * 0.4,
                        height: 40,
                        textColor: KColor.white,
                        color: KColor.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
