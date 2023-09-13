import 'package:ecommerce_app/features/view/global_component/shimmer/placeholder_shimmer.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ...List.generate(
                  3,
                  (index) => const Column(
                    children: [
                      SizedBox(height: 22.0),
                      ContentPlaceholder(
                        lineType: ContentLineType.threeLines,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ...List.generate(
                  3,
                  (index) => const Column(
                    children: [
                      SizedBox(height: 22.0),
                      ContentPlaceholder(
                        lineType: ContentLineType.threeLines,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
