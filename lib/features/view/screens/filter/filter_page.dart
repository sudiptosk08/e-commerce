import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/enums/tooltip_direction_enum.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:ecommerce_app/features/view/global_component/buttons/Kdrop_down_field.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_styles/text_styles.dart';

class KFilter extends StatefulWidget {
  const KFilter({super.key});

  @override
  State<KFilter> createState() => _KFilterState();
}

class _KFilterState extends State<KFilter> {
  var _isSelected = false;
  List<String> brand = [
    "Nick",
    "Puma",
    "Gucci",
    "Nalksilt",
    "Lotto",
    "Bata",
    "Garnier",
    "Easy",
    "Flora",
    "Waxsias",
    "Puma",
  ];
  List<String> categories = [
    "All",
    "Men",
    "Women",
    "Kids",
    "Shoes",
    "Electronics",
  ];
  List<String> tag = [
    "Low price",
    "High price",
    "Best selling",
    "Trending",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: KColor.background,
        width: context.screenWidth * 0.75,
        height: context.screenHeight * 1,
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Filter Product By',
                      style: GoogleFonts.rubik(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(color: KColor.black54.withOpacity(0.2), thickness: 1),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "PRICE RANGE",
                    style: TextStyles.subTitle.copyWith(
                      color: KColor.black54,
                    ),
                  ),
                  Container(
                      margin:
                          const EdgeInsets.only(top: 2, left: 20, right: 20),
                      alignment: Alignment.topCenter,
                      height: 50,
                      child: FlutterSlider(
                        values: const [1, 9999],
                        rangeSlider: true,
                        max: 9999,
                        min: 1,
                        step: const FlutterSliderStep(step: 10),
                        jump: true,
                        handlerWidth: 20,
                        handlerHeight: 20,
                        trackBar: const FlutterSliderTrackBar(
                          inactiveTrackBarHeight: 4,
                          activeTrackBar: BoxDecoration(
                            color: KColor.primary,
                          ),
                          activeTrackBarHeight: 10,
                        ),
                        disabled: false,
                        handler: customHandler(Icons.chevron_right),
                        rightHandler: customHandler(Icons.chevron_left),
                        tooltip: FlutterSliderTooltip(
                          custom: (value) => Padding(
                            padding: const EdgeInsets.only(top: 45.0),
                            child: SizedBox(child: Text("${value}")),
                          ),
                          direction: FlutterSliderTooltipDirection.top,
                          alwaysShowTooltip: true,
                        ),
                      )),
                  const SizedBox(height: 30),
                  Text(
                    "Categories ",
                    style: TextStyles.subTitle.copyWith(
                      color: KColor.black54,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                      direction: Axis.horizontal,
                      spacing: KSize.getWidth(context, 13),
                      runSpacing: KSize.getHeight(context, 14),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                                //s: 5.0,
                                // runSpacing: 3.0,
                                spacing: 7,
                                runSpacing: 4,
                                children: List.generate(
                                    categories.length,
                                    (index) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            margin: const EdgeInsets.only(
                                                top: 2.5,
                                                bottom: 4,
                                                right: 2.5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: KColor.white,
                                            ),
                                            child: Text(
                                              categories[index].toString(),
                                              style: TextStyles.bodyText1
                                                  .copyWith(
                                                      color: KColor.grey,
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                          ),
                                        ))),
                          ),
                        )
                      ]),

                  //wraper
                  Text(
                    "Brand ",
                    style: TextStyles.subTitle.copyWith(
                      color: KColor.black54,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                      direction: Axis.horizontal,
                      spacing: KSize.getWidth(context, 13),
                      runSpacing: KSize.getHeight(context, 14),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                                //s: 5.0,
                                // runSpacing: 3.0,
                                spacing: 7,
                                runSpacing: 4,
                                children: List.generate(
                                    brand.length,
                                    (index) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            margin: const EdgeInsets.only(
                                                top: 2.5,
                                                bottom: 4,
                                                right: 2.5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: KColor.white,
                                            ),
                                            child: Text(
                                              brand[index].toString(),
                                              style: TextStyles.bodyText1
                                                  .copyWith(
                                                      color: KColor.grey,
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                          ),
                                        ))),
                          ),
                        )
                      ]),

                  const SizedBox(height: 16),

                  Text(
                    "Tag ",
                    style: TextStyles.subTitle.copyWith(
                      color: KColor.black54,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                      direction: Axis.horizontal,
                      spacing: KSize.getWidth(context, 13),
                      runSpacing: KSize.getHeight(context, 14),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                                //s: 5.0,
                                // runSpacing: 3.0,
                                spacing: 7,
                                runSpacing: 4,
                                children: List.generate(
                                    tag.length,
                                    (index) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            width: KSize.getWidth(context, 111),
                                            padding: const EdgeInsets.all(8),
                                            margin: const EdgeInsets.only(
                                                top: 2.5,
                                                bottom: 4,
                                                right: 2.5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: KColor.white,
                                            ),
                                            child: Text(
                                              tag[index].toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyles.bodyText1
                                                  .copyWith(
                                                      color: KColor.grey,
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                          ),
                                        ))),
                          ),
                        )
                      ]),
                  const SizedBox(height: 16),

                  Text(
                    "Avarage Rating ",
                    style: TextStyles.subTitle.copyWith(
                      color: KColor.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SmoothStarRating(
                    size: 20,
                    color: KColor.primary,
                    borderColor: KColor.primary,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: KButton(
                    title: "Reset",
                    radius: 8,
                    textColor: KColor.black,
                    height: 45,
                    onPressedCallback: () {},
                  )),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: KButton(
                    title: "Apply",
                    radius: 8,
                    height: 45,
                    textColor: KColor.black,
                    onPressedCallback: () {},
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  FlutterSliderHandler customHandler(IconData icon) {
    return FlutterSliderHandler(
      decoration: const BoxDecoration(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
