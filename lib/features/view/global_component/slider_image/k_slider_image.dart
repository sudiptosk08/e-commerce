// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:flutter/material.dart';

class KImageSlider extends StatefulWidget {
  const KImageSlider({super.key});

  @override
  _KImageSliderState createState() => _KImageSliderState();
}

class _KImageSliderState extends State<KImageSlider> {
  var index;
  @override
  void initState() {
    super.initState();
  }

  List<Map<String, dynamic>> bannerImage = [
    {
      "image": AppAssets.product1,
    },
    {
      "image": AppAssets.product2,
    },
    {
      "image": AppAssets.product3,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        key: UniqueKey(),
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: 165,
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13))),
        child: Container(
          child: CarouselSlider(
            items: bannerImage
                .map<Widget>(
                  (element) => ClipRRect(
                    child: Image.network(
                      element['image'],
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 210,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ));
  }
}
