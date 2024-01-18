import 'package:flutter/material.dart';

import '../../../../utils/colors/app_colors.dart';

class GrayHandle extends StatelessWidget {
  const GrayHandle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: 120,
        height: 5,
        decoration: BoxDecoration(
          color: KColor.black,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
