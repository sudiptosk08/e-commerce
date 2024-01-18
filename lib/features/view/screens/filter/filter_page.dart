// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/enums/tooltip_direction_enum.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/global_component/buttons/Kdrop_down_field.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/brand_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/category_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/home/model/brand_list_model.dart';
import 'package:ecommerce_app/features/view/screens/home/model/category_list_model.dart';
import 'package:ecommerce_app/features/view/screens/home/state/brands_state.dart';
import 'package:ecommerce_app/features/view/screens/home/state/categories_state.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/view/shop_page.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_styles/text_styles.dart';

class KFilter extends StatefulWidget {
  String title;
  KFilter({required this.title, super.key});

  @override
  State<KFilter> createState() => _KFilterState();
}

class _KFilterState extends State<KFilter> {
  List<String> brandIdList = [];
  String? brandId = '';
  List<String> subCategoryIdList = [];
  String? subCategoryId = '';
  List<String> categoryIdList = [];
  String? categoryId = '';
  var cateSelectIndex;
  bool selectcategory = false;
  var ratings = 0;
  var priceRange;
  double _lowerValue = 1.0;
  double _upperValue = 9999.0;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final categoryState = ref.watch(categoryProvider);
        final List<CategoryListData> categoryData =
            categoryState is CategorySuccessState
                ? categoryState.categoryModel!.data
                : [];
        final brandState = ref.watch(brandProvider);
        final List<BrandListData> brandListData =
            brandState is BrandSuccessState
                ? brandState.brandListModel!.data
                : [];
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
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_back_ios,
                          ),
                          const SizedBox(width: 20),
                          Center(
                            child: Text('Filter Product By',
                                style: TextStyles.headline6),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      Divider(
                          color: KColor.black.withOpacity(0.2), thickness: 1),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "PRICE RANGE",
                        style: TextStyles.subTitle1.copyWith(
                          color: KColor.black,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                              top: 2, left: 20, right: 20),
                          alignment: Alignment.topCenter,
                          height: 50,
                          child: FlutterSlider(
                            values: [
                              _lowerValue,
                              _upperValue,
                            ],
                            rangeSlider: true,
                            max: 9999,
                            min: 0,
                            step: const FlutterSliderStep(step: 10),
                            jump: true,
                            handlerWidth: 20,
                            handlerHeight: 20,
                            trackBar: const FlutterSliderTrackBar(
                              inactiveTrackBarHeight: 4,
                              activeTrackBar: BoxDecoration(
                                color: KColor.secondary,
                              ),
                              activeTrackBarHeight: 5,
                            ),
                            disabled: false,
                            onDragging: (handlerIndex, lowerValue, upperValue) {
                              setState(() {
                                _lowerValue = lowerValue;
                                _upperValue = upperValue;
                                print("LowerValue $_lowerValue");
                                print("UpperValue $_upperValue");
                              });
                            },
                            handler: customHandler(Icons.chevron_right),
                            rightHandler: customHandler(Icons.chevron_left),
                            tooltip: FlutterSliderTooltip(
                              custom: (value) => Padding(
                                padding: const EdgeInsets.only(top: 45.0),
                                child: SizedBox(child: Text("$value")),
                              ),
                              direction: FlutterSliderTooltipDirection.top,
                              alwaysShowTooltip: true,
                            ),
                          )),
                      const SizedBox(height: 30),
                      Text(
                        "CATEGORIES ",
                        style: TextStyles.subTitle1.copyWith(
                          color: KColor.black,
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
                                        categoryData.length,
                                        (index) => InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (categoryIdList.contains(
                                                      categoryData[index]
                                                          .id
                                                          .toString())) {
                                                    categoryIdList.removeWhere(
                                                        (element) =>
                                                            element ==
                                                            categoryData[index]
                                                                .id
                                                                .toString());
                                                  } else {
                                                    categoryIdList.add(
                                                        categoryData[index]
                                                            .id
                                                            .toString());
                                                  }
                                                  categoryId =
                                                      categoryIdList.join(",");
                                                  cateSelectIndex = index;

                                                  selectcategory = true;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                margin: const EdgeInsets.only(
                                                    top: 2.5,
                                                    bottom: 4,
                                                    right: 2.5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: const Color(
                                                              0xFF697089)
                                                          .withOpacity(0.6)),
                                                  color:
                                                      cateSelectIndex == index
                                                          ? KColor.grey400
                                                          : KColor.transparent,
                                                ),
                                                child: Text(
                                                  categoryData[index].name,
                                                  style: TextStyles.bodyText1
                                                      .copyWith(
                                                          color:
                                                              cateSelectIndex ==
                                                                      index
                                                                  ? KColor.white
                                                                  : Color(
                                                                      0xFF697089),
                                                          fontWeight: FontWeight
                                                              .normal),
                                                ),
                                              ),
                                            ))),
                              ),
                            )
                          ]),
                      // selectcategory
                      //     ? const SizedBox(height: 16)
                      //     : const SizedBox(height: 0),

                      // selectcategory
                      //     ? Text(
                      //         "SUB CATEGORIES ",
                      //         style: TextStyles.subTitle1.copyWith(
                      //           color: KColor.black,
                      //         ),
                      //       )
                      //     : Container(),
                      // selectcategory
                      //     ? const SizedBox(height: 10)
                      //     : const SizedBox(height: 0),

                      // selectcategory
                      //     ? Wrap(
                      //         direction: Axis.horizontal,
                      //         spacing: KSize.getWidth(context, 13),
                      //         runSpacing: KSize.getHeight(context, 14),
                      //         children: [
                      //             Padding(
                      //               padding: const EdgeInsets.only(left: 8.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: Wrap(
                      //                     //s: 5.0,
                      //                     // runSpacing: 3.0,
                      //                     spacing: 7,
                      //                     runSpacing: 4,
                      //                     children: List.generate(
                      //                         categoryData[cateSelectIndex]
                      //                             .subcategories!
                      //                             .length,
                      //                         (index) => InkWell(
                      //                               onTap: () {
                      //                                 setState(() {
                      //                                   if (subCategoryIdList
                      //                                       .contains(categoryData[
                      //                                               index]
                      //                                           .subcategories![
                      //                                               index]
                      //                                           .id
                      //                                           .toString())) {
                      //                                     subCategoryIdList
                      //                                         .removeWhere((element) =>
                      //                                             element ==
                      //                                             categoryData[
                      //                                                     index]
                      //                                                 .subcategories![
                      //                                                     index]
                      //                                                 .id
                      //                                                 .toString());
                      //                                   } else {
                      //                                     subCategoryIdList.add(
                      //                                         categoryData[
                      //                                                 index]
                      //                                             .subcategories![
                      //                                                 index]
                      //                                             .id
                      //                                             .toString());
                      //                                   }
                      //                                   subCategoryId =
                      //                                       subCategoryIdList
                      //                                           .join(",");
                      //                                 });
                      //                               },
                      //                               child: Container(
                      //                                 padding:
                      //                                     const EdgeInsets.all(
                      //                                         8),
                      //                                 margin:
                      //                                     const EdgeInsets.only(
                      //                                         top: 2.5,
                      //                                         bottom: 4,
                      //                                         right: 2.5),
                      //                                 decoration: BoxDecoration(
                      //                                   borderRadius:
                      //                                       BorderRadius
                      //                                           .circular(5.0),
                      //                                   color: subCategoryIdList
                      //                                           .contains(categoryData[
                      //                                                   index]
                      //                                               .subcategories![
                      //                                                   index]
                      //                                               .id
                      //                                               .toString())
                      //                                       ? KColor.grey400
                      //                                       : KColor.white,
                      //                                 ),
                      //                                 child: Text(
                      //                                   categoryData[index]
                      //                                       .subcategories![
                      //                                           index]
                      //                                       .name
                      //                                       .toString(),
                      //                                   textAlign:
                      //                                       TextAlign.center,
                      //                                   style: TextStyles.bodyText1.copyWith(
                      //                                       color: subCategoryIdList.contains(categoryData[
                      //                                                   index]
                      //                                               .subcategories![
                      //                                                   index]
                      //                                               .id
                      //                                               .toString())
                      //                                           ? KColor.white
                      //                                           : KColor.grey,
                      //                                       fontWeight:
                      //                                           FontWeight
                      //                                               .normal),
                      //                                 ),
                      //                               ),
                      //                             ))),
                      //               ),
                      //             )
                      //           ])
                      //     : Container(),
                      const SizedBox(height: 10),
                      //wraper
                      Text(
                        "BRAND ",
                        style: TextStyles.subTitle1.copyWith(
                          color: KColor.black,
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
                                        brandListData.length,
                                        (index) => InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (brandIdList.contains(
                                                      brandListData[index]
                                                          .id
                                                          .toString())) {
                                                    brandIdList.removeWhere(
                                                        (element) =>
                                                            element ==
                                                            brandListData[index]
                                                                .id
                                                                .toString());
                                                  } else {
                                                    brandIdList.add(
                                                        brandListData[index]
                                                            .id
                                                            .toString());
                                                  }
                                                  brandId =
                                                      brandIdList.join(",");
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                margin: const EdgeInsets.only(
                                                    top: 2.5,
                                                    bottom: 4,
                                                    right: 2.5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: const Color(
                                                              0xFF697089)
                                                          .withOpacity(0.6)),
                                                  color: brandIdList.contains(
                                                          brandListData[index]
                                                              .id
                                                              .toString())
                                                      ? KColor.grey400
                                                      : KColor.transparent,
                                                ),
                                                child: Text(
                                                  brandListData[index]
                                                      .name
                                                      .toString(),
                                                  style: TextStyles.bodyText1
                                                      .copyWith(
                                                          color: brandIdList.contains(
                                                                  brandListData[
                                                                          index]
                                                                      .id
                                                                      .toString())
                                                              ? KColor.white
                                                              : const Color(
                                                                  0xff697089),
                                                          fontWeight: FontWeight
                                                              .normal),
                                                ),
                                              ),
                                            ))),
                              ),
                            )
                          ]),

                      const SizedBox(height: 16),

                      Text(
                        "AVARAGE RATING ",
                        style: TextStyles.subTitle1.copyWith(
                          color: KColor.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SmoothStarRating(
                            size: 20,
                            spacing: 1,
                            color: KColor.yellow,
                            borderColor: KColor.yellow,
                            rating: ratings.toDouble(),
                            onRatingChanged: (rating) {
                              setState(() {
                                ratings = rating.toInt();
                              });
                            },
                          ),
                          Text(
                            " (05 star)",
                            style: TextStyles.bodyText1,
                          ),
                        ],
                      )
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
                        radius: 7,
                        textColor: KColor.black,
                        color: KColor.transparent,
                        borderColor: Color(0xff697089).withOpacity(0.6),
                        height: 34,
                        onPressedCallback: () {},
                        isOutlineButton: true,
                      )),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                          child: KButton(
                        title: "Apply",
                        radius: 8,
                        height: 34,
                        textColor: KColor.white,
                        onPressedCallback: () {
                          ref
                              .read(productListProvider.notifier)
                              .fetchShopProductList(
                                  brandID: brandId,
                                  categoryID: cateSelectIndex,
                                  subCategoryID: subCategoryId,
                                  maxPrice:
                                      _upperValue == 9999.0 ? "" : _upperValue,
                                  minPrice:
                                      _lowerValue == 1.0 ? "" : _lowerValue,
                                  orderByPrice: 0,
                                  ratings: ratings == 0 ? "" : ratings,
                                  str: "");
                          NavigationService.navigateToReplacement(
                              SlideLeftRoute(
                                  page: ShopPage(
                            index: "",
                            title: widget.title,
                          )));
                        },
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  FlutterSliderHandler customHandler(IconData icon) {
    return FlutterSliderHandler(
      decoration: const BoxDecoration(),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFE0E0E0),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
