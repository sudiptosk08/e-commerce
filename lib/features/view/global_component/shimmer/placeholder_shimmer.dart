// ignore_for_file: must_be_immutable

import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/material.dart';

class BannerPlaceholder extends StatelessWidget {
  int height;
  BannerPlaceholder({required this.height, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: KSize.getHeight(context, height),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: Colors.white,
      ),
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  final double width;

  const TitlePlaceholder({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 12.0,
            color: Colors.white,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: width,
            height: 12.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

enum ContentLineType {
  twoLines,
  threeLines,
}

class ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const ContentPlaceholder({
    Key? key,
    required this.lineType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        width: KSize.getWidth(context, 148),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: KSize.getWidth(context, 152),
              height: KSize.getWidth(context, 115),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: KSize.getWidth(context, 8),
            ),
            Container(
              width: double.infinity,
              height: KSize.getWidth(context, 8),
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 8.0),
            ),
            if (lineType == ContentLineType.threeLines)
              Container(
                width: double.infinity,
                height: KSize.getWidth(context, 8),
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 8.0),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70.0,
                  height: KSize.getWidth(context, 8),
                  color: Colors.white,
                ),
                Container(
                  width: 70.0,
                  height: KSize.getWidth(context, 8),
                  color: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WishListPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const WishListPlaceholder({
    Key? key,
    required this.lineType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 125.0,
            height: 90.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: KSize.getWidth(context, 8),
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                Container(
                  width: double.infinity,
                  height: KSize.getWidth(context, 8),
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    width: double.infinity,
                    height: KSize.getWidth(context, 8),
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                Container(
                  width: 80.0,
                  height: KSize.getWidth(context, 8),
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyOrderPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const MyOrderPlaceholder({
    Key? key,
    required this.lineType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: KSize.getWidth(context, 8),
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                Container(
                  width: double.infinity,
                  height: KSize.getWidth(context, 8),
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    width: double.infinity,
                    height: KSize.getWidth(context, 8),
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80.0,
                          height: 38.0,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 80.0,
                          height: 38.0,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 80.0,
                          height: KSize.getWidth(context, 8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Container(
                          width: 80.0,
                          height: KSize.getWidth(context, 8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CategoryPlaceholder extends StatelessWidget {
  const CategoryPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        width: 80.0,
        height: 52.0,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }
}
