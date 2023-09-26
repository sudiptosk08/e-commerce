// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/size/k_size.dart';
import '../../../../utils/text_styles/text_styles.dart';

class KButton extends StatefulWidget {
  final double? width;
  final double? height;
  final String? title;
  final Function()? onPressedCallback;
  final double innerPadding;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final bool isOutlineButton;
  final double radius;
  final bool hasTrailngTitleIcon;
  final Icon? leadingTitleIcon;
  final Icon? trailingTitleIcon;
  final TextOverflow textOverflow;
  final TextStyle? textStyle;
  const KButton({
    super.key,
    this.width,
    this.height,
    this.title,
    this.onPressedCallback,
    this.innerPadding = 0,
    this.color = KColor.primary,
    this.textColor = Colors.white,
    this.borderColor = KColor.grey,
    this.isOutlineButton = false,
    this.radius = 8.0,
    this.hasTrailngTitleIcon = false,
    this.leadingTitleIcon,
    this.trailingTitleIcon,
    this.textOverflow = TextOverflow.visible,
    this.textStyle,
  });

  @override
  _KButtonState createState() => _KButtonState();
}

class _KButtonState extends State<KButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: widget.onPressedCallback,
      child: Container(
        width: widget.width ?? MediaQuery.of(context).size.width,
        height: widget.height,
        padding: EdgeInsets.only(
            top: widget.innerPadding,
            bottom: widget.leadingTitleIcon != null
                ? widget.innerPadding
                : widget.innerPadding + 3),
        decoration: widget.isOutlineButton
            ? BoxDecoration(
                border: Border.all(color: widget.borderColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              )
            : BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.leadingTitleIcon != null) widget.leadingTitleIcon!,
            if (widget.leadingTitleIcon != null)
              SizedBox(width: KSize.getWidth(context, 8)),
            Expanded(
              flex: widget.textOverflow == TextOverflow.ellipsis ? 1 : 0,
              child: Text(
                widget.title ?? '',
                textAlign: TextAlign.center,
                overflow: widget.textOverflow,
                style: widget.textStyle ??
                    TextStyles.bodyText1.copyWith(
                        fontWeight: FontWeight.w500, color: KColor.white),
              ),
            ),
            if (widget.trailingTitleIcon != null)
              SizedBox(width: KSize.getWidth(context, 5)),
            if (widget.trailingTitleIcon != null) widget.trailingTitleIcon!,
          ],
        ),
      ),
    );
  }
}
