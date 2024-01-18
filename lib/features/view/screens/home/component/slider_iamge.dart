// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/features/view/global_component/shimmer/placeholder_shimmer.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/banner_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/home/model/banner_list_model.dart';
import 'package:ecommerce_app/features/view/screens/home/state/banner_state.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
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

      return sliderState is! BannerSuccessState
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.grey.shade300,
              child: BannerPlaceholder(
                height: 135,
              ),
            )
          : SizedBox(
              width: context.screenWidth * 1,
              child: CarouselSlider(
                items: sliderData
                    .map<Widget>(
                      (element) => ClipRRect(
                        child: Image.network(
                          element.image,
                          alignment: Alignment.center,
                          width: KSize.getWidth(context, 350),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: KSize.getHeight(context, 135),
                  viewportFraction: 5,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            );
    });
  }
}
