// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/features/view/global_component/shimmer/placeholder_shimmer.dart';
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
                  height: KSize.getHeight(context, 380),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: KColor.white,
                  ),
                  padding: const EdgeInsets.only(left: 12, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(width: 8),
                      Column(
                        children: [
                          Expanded(
                              child: Container(
                            alignment: Alignment.center,
                            width: context.screenWidth * 0.9,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: KColor.gray.withOpacity(0.5)),
                              color: KColor.white,
                            ),
                            padding: const EdgeInsets.all(8),
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
                                effect: const ExpandingDotsEffect(
                                  activeDotColor: KColor.primary,
                                  dotColor: KColor.grey,
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
                        left: 12, right: 12, bottom: 5, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: KSize.getWidth(context, 240),
                              child: Text(
                                productDetails.name,
                                style: TextStyles.headline6,
                              ),
                            ),
                            productDetails.discount.toInt() > 0
                                ? Container(
                                    alignment: Alignment.centerRight,
                                    width: KSize.getWidth(context, 112),
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
                                              : ref
                                                  .read(productDetailsProvider
                                                      .notifier)
                                                  .totalPrice
                                                  .toString(),
                                          style: TextStyles.headline3.copyWith(
                                              color: KColor.errorRedText),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "৳${productDetails.price.toString()}",
                                              style: TextStyles.headline3
                                                  .copyWith(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: KColor.primary),
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
                                          .copyWith(color: KColor.errorRedText),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: KSize.getWidth(context, 200),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 19),
                                    child: IgnorePointer(
                                        child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 25,
                                          color: KColor.primary,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${productDetails.rating.toString()} ",
                                          style: TextStyles.bodyText1
                                              .copyWith(color: KColor.gray223),
                                        )
                                      ],
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 19),
                                    child: IgnorePointer(
                                        child: Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 20,
                                          color: KColor.primary,
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          "${productDetails.stock.toString()}(stock)",
                                          style: TextStyles.bodyText1
                                              .copyWith(color: KColor.gray223),
                                        )
                                      ],
                                    )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: KSize.getWidth(context, 150),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: widget.remove,
                                    child: CircleAvatar(
                                      backgroundColor: KColor.primary,
                                      child: Center(
                                        child: Icon(
                                          Icons.remove,
                                          size: 25,
                                          color: KColor.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Text(
                                      widget.quantity.toString(),
                                      style: TextStyles.headline6.copyWith(
                                        color: KColor.black,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    // When using InkWell check the spalsh effect if its radius matches the container
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: widget.add,
                                    child: CircleAvatar(
                                      backgroundColor: KColor.primary,
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
                        Text(
                          'Variation',
                          style:
                              TextStyles.subTitle.copyWith(color: Colors.black),
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
                                        vertical: 2, horizontal: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1,
                                            color: selectIndex == index
                                                ? KColor.primary
                                                : KColor.gray)),
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
                                style: TextStyles.subTitle
                                    .copyWith(color: Colors.black),
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
                                                  width: 40,
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 3,
                                                      horizontal: 2),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
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
                                                          .bodyText3
                                                          .copyWith(
                                                              color: selectSize ==
                                                                      idx
                                                                  ? KColor
                                                                      .primary
                                                                  : KColor
                                                                      .grey800),
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
                                                      width: 40,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 5),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 3,
                                                          horizontal: 2),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
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
                                                          attributeList[index][
                                                                      'attributeValues']
                                                                  [idx]['value']
                                                              .toString(),
                                                          style: TextStyles
                                                              .bodyText3
                                                              .copyWith(
                                                                  color: selectColor == idx
                                                                      ? KColor
                                                                          .primary
                                                                      : KColor
                                                                          .grey800),
                                                        ),
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
                                                      width: 40,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 5),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 3,
                                                          horizontal: 2),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: selectType ==
                                                                      idx
                                                                  ? KColor
                                                                      .primary
                                                                  : KColor
                                                                      .gray)),
                                                      child: Center(
                                                        child: Text(
                                                          attributeList[index][
                                                                      'attributeValues']
                                                                  [idx]['value']
                                                              .toString(),
                                                          style: TextStyles
                                                              .bodyText3
                                                              .copyWith(
                                                                  color: selectType == idx
                                                                      ? KColor
                                                                          .primary
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

                        //  ...List.generate(productDetails.attributes., (index) => null);
                        const SizedBox(height: 12),
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
                                            ? KColor.black54.withOpacity(0.8)
                                            : const Color.fromARGB(
                                                255, 220, 220, 222),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                        child: Text(
                                          item[index],
                                          style: TextStyles.bodyText1.copyWith(
                                            color: index == currentIndex
                                                ? KColor.white
                                                : KColor.black54
                                                    .withOpacity(0.4),
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
                                style: TextStyles.subTitle
                                    .copyWith(color: Colors.black),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                productDetails.description,
                                textAlign: TextAlign.justify,
                                style: TextStyles.bodyText1
                                    .copyWith(color: KColor.gray223),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Specification',
                                style: TextStyles.subTitle
                                    .copyWith(color: Colors.black),
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
                        // if (currentIndex == 1) const ProductReview(),
                        const SizedBox(
                          height: 80,
                        ),
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
              child: const SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 9,
                      ),
                      BannerPlaceholder(),
                      SizedBox(
                        height: 9,
                      ),
                      TitlePlaceholder(width: double.infinity),
                      SizedBox(
                        height: 9,
                      ),
                      TitlePlaceholder(
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
          child: Text(title,
              style: TextStyles.bodyText1.copyWith(color: KColor.black54)),
        ),
        Text(":  ",
            style: TextStyles.bodyText1.copyWith(color: KColor.black54)),
        Expanded(
            child: Text(description,
                style: TextStyles.bodyText1.copyWith(color: KColor.black54))),
      ],
    );
  }
}
