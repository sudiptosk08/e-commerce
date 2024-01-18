// ignore_for_file: unnecessary_null_comparison, must_be_immutable, avoid_print, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/features/view/global_component/shimmer/placeholder_shimmer.dart';
import 'package:ecommerce_app/features/view/screens/product_details/component/product_review.dart';
import 'package:ecommerce_app/features/view/screens/product_details/controller/product_details_controller.dart';
import 'package:ecommerce_app/features/view/screens/product_details/state/product_details_state.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../../../utils/text_styles/text_styles.dart';

class ProductInfo extends StatefulWidget {
  int quantity;
  final VoidCallback add;
  final VoidCallback remove;

  ProductInfo({
    required this.add,
    required this.remove,
    this.quantity = 0,
    Key? key,
  }) : super(key: key);
  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int currentIndex = 0;
  final _controller = PageController();
  int selectIndex = -1;
  int selectColor = -1;
  int selectSize = -1;
  int selectType = -1;
  bool favorite = false;
  var totalPrice;

  List<dynamic> item = ["About", "Reviews"];
  List<Map<String, dynamic>> attributeList = [];

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final productDetailsState = ref.watch(productDetailsProvider);
      final productDetails = productDetailsState is ProductDetailsSuccessState
          ? productDetailsState.productDetailsModel!.data
          : null;
      attributeList = ref.read(productDetailsProvider.notifier).attributeList;
      totalPrice = ref.read(productDetailsProvider.notifier).totalPrice;
      return productDetails != null
          ? Column(
              children: [
                Container(
                  height: KSize.getHeight(context, 302),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: KColor.containerColor,
                  ),
                  padding: const EdgeInsets.only(left: 12, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(width: 2),
                      Column(
                        children: [
                          Expanded(
                              child: Container(
                            alignment: Alignment.center,
                            width: context.screenWidth * 0.85,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              // border: Border.all(
                              //     color: KColor.gray.withOpacity(0.5)),
                              color: KColor.containerColor,
                            ),
                            padding: const EdgeInsets.all(40),
                            child: PageView.builder(
                                itemCount: productDetails.gallery.length,
                                controller: _controller,
                                itemBuilder: (ctx, position) {
                                  return Image.network(
                                    productDetails.gallery[position],
                                    fit: BoxFit.fill,
                                  );
                                }),
                          )),
                          Row(
                            children: [
                              SmoothPageIndicator(
                                controller: _controller,
                                count: productDetails.gallery.length,
                                onDotClicked: (index) {
                                  setState(() {
                                    selectIndex = index;
                                    _controller.animateToPage(
                                      selectIndex,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                  if (index == selectIndex) {}
                                },
                                effect: ExpandingDotsEffect(
                                  activeDotColor: KColor.black,
                                  dotColor: Colors.grey.shade400,
                                  dotHeight: 4,
                                  dotWidth: 4,
                                  radius: 107,
                                  spacing: 4,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, bottom: 5, top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            productDetails.name,
                            style: TextStyles.headline6,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IgnorePointer(
                                      child: Row(
                                    children: [
                                      SmoothStarRating(
                                        rating: 5,
                                        size: 17,
                                        color: KColor.yellow,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "(${productDetails.rating.toString()}) ",
                                        style: TextStyles.bodyText1
                                            .copyWith(color: KColor.textgrey),
                                      )
                                    ],
                                  )),
                                  const SizedBox(width: 6),
                                  IgnorePointer(
                                      child: Row(
                                    children: [
                                      const Icon(
                                        Icons.memory_outlined,
                                        size: 17,
                                        color: KColor.grey,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                            text:
                                                "${productDetails.stock.toString()}",
                                            style: TextStyles.bodyText1
                                                .copyWith(
                                                    color: KColor.textgrey),
                                            children: [
                                              TextSpan(
                                                text: " (In Stock)",
                                                style: TextStyles.bodyText1
                                                    .copyWith(
                                                        color: KColor.green),
                                              )
                                            ]),
                                      )
                                    ],
                                  )),
                                  IgnorePointer(
                                      child: Row(
                                    children: [
                                      const Icon(
                                        Icons.delivery_dining_outlined,
                                        size: 17,
                                        color: KColor.grey,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "70 BDT(120 BDT Out Side Dhaka)",
                                        style: TextStyles.bodyText1
                                            .copyWith(color: KColor.textgrey),
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                            thickness: 1,
                            color: Color(
                              0xffCBD4F0,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            productDetails.discount.toInt() > 0
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text.rich(
                                      TextSpan(
                                          text: ref
                                                      .read(
                                                          productDetailsProvider
                                                              .notifier)
                                                      .totalPrice
                                                      .toInt() ==
                                                  0
                                              ? "৳${productDetails.discountPrice.toString()}  "
                                              : "৳${ref.read(productDetailsProvider.notifier).totalPrice.toString()} ",
                                          style: TextStyles.headline6.copyWith(
                                              color: KColor.red,
                                              fontWeight: FontWeight.w700),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "৳${productDetails.price.toString()}",
                                              style: TextStyles.headline6
                                                  .copyWith(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: const Color(
                                                          0xff525377)),
                                            ),
                                          ]),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.centerRight,
                                    width: KSize.getWidth(context, 90),
                                    child: Text(
                                      ref
                                                  .read(productDetailsProvider
                                                      .notifier)
                                                  .totalPrice
                                                  .toInt() ==
                                              0
                                          ? "৳${productDetails.price.toString()}"
                                          : ref
                                              .read(productDetailsProvider
                                                  .notifier)
                                              .totalPrice
                                              .toString(),
                                      style: TextStyles.headline3
                                          .copyWith(color: KColor.red),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                            Container(
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                  color: Color(0xffE9E9FA),
                                  borderRadius: BorderRadius.circular(19)),
                              width: KSize.getWidth(context, 120),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: widget.remove,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: KColor.containerColor,
                                          shape: BoxShape.circle),
                                      child: const Center(
                                        child: Icon(Icons.remove,
                                            size: 25, color: KColor.textgrey),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Text(
                                      widget.quantity.toString(),
                                      style: TextStyles.headline6
                                          .copyWith(color: KColor.textgrey),
                                    ),
                                  ),
                                  InkWell(
                                    // When using InkWell check the spalsh effect if its radius matches the container

                                    onTap: widget.add,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                          color: KColor.primary,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 25,
                                          color: KColor.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const Divider(
                            thickness: 1,
                            color: Color(
                              0xffCBD4F0,
                            )),

                        Text(
                          'Variation',
                          style: TextStyles.subTitle1
                              .copyWith(color: KColor.black),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 65,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productDetails.gallery.length,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectIndex = index;
                                      _controller.animateToPage(
                                        selectIndex,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                      );
                                    });
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.5, horizontal: 2.5),
                                    decoration: BoxDecoration(
                                        color: KColor.containerColor,
                                        border: Border.all(
                                            width: 1,
                                            color: selectIndex == index
                                                ? KColor.primary
                                                : Colors.grey.shade300)),
                                    child: Center(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: productDetails.gallery[index]
                                            .toString(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        ...List.generate(
                          attributeList.length,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                attributeList[index]['attributeName'],
                                style: TextStyles.subTitle1
                                    .copyWith(color: KColor.black),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              attributeList[index]['attributeName'] == 'size'
                                  ? SizedBox(
                                      width: double.infinity,
                                      height: 40,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: attributeList[index]
                                                ["attributeValues"]
                                            .length,
                                        itemBuilder: (context, int idx) {
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectSize = idx;
                                                    ref
                                                        .read(
                                                            productDetailsProvider
                                                                .notifier)
                                                        .size = attributeList[
                                                                index]
                                                            ['attributeValues']
                                                        [idx]['value'];
                                                    ref
                                                        .read(
                                                            productDetailsProvider
                                                                .notifier)
                                                        .sizeId = attributeList[
                                                                index]
                                                            ['attributeValues']
                                                        [idx]['id'];

                                                    ref
                                                            .read(
                                                                productDetailsProvider
                                                                    .notifier)
                                                            .sizeAdditionalPrice =
                                                        int.parse(attributeList[
                                                                        index][
                                                                    'attributeValues'][idx]
                                                                [
                                                                'additional_price']
                                                            .toString());
                                                    productDetails.discount.toInt() > 0
                                                        ? ref
                                                            .read(
                                                                productDetailsProvider
                                                                    .notifier)
                                                            .totalPrice = productDetails
                                                                .discountPrice +
                                                            ref
                                                                .read(productDetailsProvider
                                                                    .notifier)
                                                                .sizeAdditionalPrice +
                                                            ref
                                                                .read(productDetailsProvider
                                                                    .notifier)
                                                                .colorAdditionalPrice +
                                                            ref
                                                                .read(productDetailsProvider
                                                                    .notifier)
                                                                .typeAdditionalPrice
                                                        : ref
                                                            .read(
                                                                productDetailsProvider
                                                                    .notifier)
                                                            .totalPrice = productDetails
                                                                .price
                                                                .toInt() +
                                                            ref
                                                                .read(productDetailsProvider.notifier)
                                                                .sizeAdditionalPrice +
                                                            ref.read(productDetailsProvider.notifier).colorAdditionalPrice +
                                                            ref.read(productDetailsProvider.notifier).typeAdditionalPrice;

                                                    print("TotalPrice :");
                                                  });
                                                },
                                                child: Container(
                                                  height: 40,
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 3,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          KColor.containerColor,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: selectSize ==
                                                                  idx
                                                              ? KColor.primary
                                                              : KColor.gray)),
                                                  child: Center(
                                                    child: Text(
                                                      attributeList[index][
                                                                  'attributeValues']
                                                              [idx]['value']
                                                          .toString(),
                                                      style: TextStyles
                                                          .bodyText2
                                                          .copyWith(
                                                              color: const Color(
                                                                  0xff697089)),
                                                    ),
                                                  ),
                                                ),
                                              ));
                                        },
                                      ),
                                    )
                                  : attributeList[index]['attributeName'] ==
                                          'color'
                                      ? SizedBox(
                                          width: double.infinity,
                                          height: 40,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: attributeList[index]
                                                    ["attributeValues"]
                                                .length,
                                            itemBuilder: (context, int idx) {
                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectColor = idx;
                                                        ref
                                                            .read(
                                                                productDetailsProvider
                                                                    .notifier)
                                                            .color = attributeList[
                                                                    index][
                                                                'attributeValues']
                                                            [idx]['value'];
                                                        ref
                                                            .read(
                                                                productDetailsProvider
                                                                    .notifier)
                                                            .colorId = attributeList[
                                                                    index][
                                                                'attributeValues']
                                                            [idx]['id'];
                                                        ref
                                                                .read(productDetailsProvider
                                                                    .notifier)
                                                                .colorAdditionalPrice =
                                                            int.parse(attributeList[
                                                                            index]
                                                                        [
                                                                        'attributeValues'][idx]
                                                                    [
                                                                    'additional_price']
                                                                .toString());
                                                        productDetails.discount.toInt() > 0
                                                            ? ref
                                                                .read(productDetailsProvider
                                                                    .notifier)
                                                                .totalPrice = productDetails
                                                                    .discountPrice +
                                                                ref
                                                                    .read(productDetailsProvider
                                                                        .notifier)
                                                                    .sizeAdditionalPrice +
                                                                ref
                                                                    .read(productDetailsProvider
                                                                        .notifier)
                                                                    .colorAdditionalPrice +
                                                                ref
                                                                    .read(productDetailsProvider
                                                                        .notifier)
                                                                    .typeAdditionalPrice
                                                            : ref
                                                                .read(productDetailsProvider
                                                                    .notifier)
                                                                .totalPrice = productDetails
                                                                    .price
                                                                    .toInt() +
                                                                ref
                                                                    .read(productDetailsProvider.notifier)
                                                                    .sizeAdditionalPrice +
                                                                ref.read(productDetailsProvider.notifier).colorAdditionalPrice +
                                                                ref.read(productDetailsProvider.notifier).typeAdditionalPrice;

                                                        print("TotalPrice :");
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 5),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 3,
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: KColor
                                                              .containerColor,
                                                          border: Border.all(
                                                              width: 1,
                                                              color: selectColor ==
                                                                      idx
                                                                  ? KColor
                                                                      .primary
                                                                  : KColor
                                                                      .gray)),
                                                      child: Center(
                                                        child: Text(
                                                            attributeList[index]
                                                                            [
                                                                            'attributeValues']
                                                                        [idx]
                                                                    ['value']
                                                                .toString(),
                                                            style: TextStyles
                                                                .bodyText2
                                                                .copyWith(
                                                                    color: const Color(
                                                                        0xff697089))),
                                                      ),
                                                    ),
                                                  ));
                                            },
                                          ),
                                        )
                                      : SizedBox(
                                          width: double.infinity,
                                          height: 40,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: attributeList[index]
                                                    ["attributeValues"]
                                                .length,
                                            itemBuilder: (context, int idx) {
                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectType = idx;
                                                        ref
                                                                .read(productDetailsProvider
                                                                    .notifier)
                                                                .typeAdditionalPrice =
                                                            int.parse(attributeList[
                                                                            index]
                                                                        [
                                                                        'attributeValues'][idx]
                                                                    [
                                                                    'additional_price']
                                                                .toString());
                                                        productDetails.discount.toInt() > 0
                                                            ? ref
                                                                .read(productDetailsProvider
                                                                    .notifier)
                                                                .totalPrice = productDetails
                                                                    .discountPrice +
                                                                ref
                                                                    .read(productDetailsProvider
                                                                        .notifier)
                                                                    .sizeAdditionalPrice +
                                                                ref
                                                                    .read(productDetailsProvider
                                                                        .notifier)
                                                                    .colorAdditionalPrice +
                                                                ref
                                                                    .read(productDetailsProvider
                                                                        .notifier)
                                                                    .typeAdditionalPrice
                                                            : ref
                                                                .read(productDetailsProvider
                                                                    .notifier)
                                                                .totalPrice = productDetails
                                                                    .price
                                                                    .toInt() +
                                                                ref
                                                                    .read(productDetailsProvider.notifier)
                                                                    .sizeAdditionalPrice +
                                                                ref.read(productDetailsProvider.notifier).colorAdditionalPrice +
                                                                ref.read(productDetailsProvider.notifier).typeAdditionalPrice;

                                                        print("TotalPrice :");
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 5),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 3,
                                                          horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: selectType ==
                                                                      idx
                                                                  ? const Color(
                                                                      0xff697089)
                                                                  : KColor
                                                                      .gray)),
                                                      child: Center(
                                                        child: Text(
                                                          attributeList[index][
                                                                      'attributeValues']
                                                                  [idx]['value']
                                                              .toString(),
                                                          style: TextStyles.bodyText2.copyWith(
                                                              color: selectType ==
                                                                      idx
                                                                  ? const Color(
                                                                      0xff697089)
                                                                  : KColor
                                                                      .grey800),
                                                        ),
                                                      ),
                                                    ),
                                                  ));
                                            },
                                          ),
                                        )
                            ],
                          ),
                        ),
                        const Divider(
                            thickness: 1,
                            color: Color(
                              0xffCBD4F0,
                            )),
                        //  ...List.generate(productDetails.attributes., (index) => null);
                        const SizedBox(height: 7),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: 55,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.only(right: 16),
                                      width: KSize.getWidth(context, 167),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: index == currentIndex
                                            ? KColor.primary
                                            : KColor.containerColor,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                        child: Text(
                                          item[index],
                                          style: TextStyles.bodyText1.copyWith(
                                            color: index == currentIndex
                                                ? KColor.white
                                                : KColor.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                        if (currentIndex == 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: TextStyles.subTitle1
                                    .copyWith(color: KColor.black),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                productDetails.description,
                                textAlign: TextAlign.justify,
                                style: TextStyles.bodyText1.copyWith(
                                  color: KColor.textgrey,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Specification',
                                style: TextStyles.subTitle1
                                    .copyWith(color: KColor.black),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              _specification("Brand", productDetails.brand),
                              _specification(
                                  "Category", productDetails.category.name),
                              _specification("Product Type",
                                  productDetails.subcategory.name),
                              _specification("Material", "Cotton 98%"),
                              _specification("Gender", "Men"),
                            ],
                          ),
                        if (currentIndex == 1) const ProductReview(),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                            thickness: 1,
                            color: Color(
                              0xffCBD4F0,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 9,
                      ),
                      BannerPlaceholder(
                        height: 320,
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      const TitlePlaceholder(width: double.infinity),
                      const SizedBox(
                        height: 9,
                      ),
                      const TitlePlaceholder(
                        width: double.infinity,
                      ),
                    ]),
              ));
    });
  }

  Row _specification(title, description) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: KSize.getWidth(context, 130),
          child: Text(title, style: TextStyles.bodyText1),
        ),
        Text(":  ", style: TextStyles.bodyText1),
        Expanded(child: Text(description, style: TextStyles.bodyText1))
      ],
    );
  }
}
