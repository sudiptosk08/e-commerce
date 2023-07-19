import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../utils/text_styles/text_styles.dart';

class KAppBar extends StatelessWidget {
  final String? title;
  final bool checkTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? color;
  const KAppBar({
    this.title,
    this.checkTitle = false,
    this.actions,
    this.leading,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? KColor.background,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: checkTitle == true
          ? Text('$title', style: TextStyles.appBarText)
          : null,
      elevation: 0,
      leading: leading,
      actions: actions,
    );
  }
}
