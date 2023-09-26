// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/global_component/shimmer/placeholder_shimmer.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/banner_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/home/model/banner_list_model.dart';
import 'package:ecommerce_app/features/view/screens/home/state/banner_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  var index;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final sliderState = ref.watch(sliderProvider);
      final List<Datum> sliderData = sliderState is BannerSuccessState
          ? sliderState.bannerListModel!.data
          : [];

      return sliderState is LoadingState
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.grey.shade300,
              child: BannerPlaceholder(height: 165),
            )
          : Container(
              key: UniqueKey(),
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 165,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              child: Carousel(
                boxFit: BoxFit.fitWidth,
                images: List.generate(
                  sliderData.length,
                  (index) => ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      sliderData[index].image,
                      alignment: Alignment.center,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                borderRadius: true,
                dotIncreaseSize: 2,
                radius: const Radius.circular(4),
                dotBgColor: Colors.grey.withOpacity(0.0),
                dotSize: 3,
                autoplay: true,
                autoplayDuration: const Duration(seconds: 3),
                animationCurve: Curves.easeInOut,
              ));
    });
  }
}
