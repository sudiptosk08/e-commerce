import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../utils/text_styles/text_styles.dart';

class ProductInfo extends StatefulWidget {
  final String? productName;
  final String? productGroup;
  final String? price;
  final String? description;
  final String? id;
  final String? userId;
  int quantity;
  final VoidCallback add;
  final VoidCallback remove;

  ProductInfo({
    this.productName,
    this.productGroup,
    this.price,
    this.description,
    this.id,
    this.userId,
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
  int selectIndex = 0;
  int selectSize = 0;
  bool favorite = false;
  List<dynamic> productImageList = [
    {
      'url':
          "https://media.e-valy.com/cms/products/images/74af17be-18cb-4212-a25c-a39606344b5c"
    },
    {
      'url':
          "https://media.e-valy.com/cms/products/images/c11c8b41-03db-498e-88c9-fd037e8a9ead?h=250&w=250"
    },
    {
      'url':
          "https://media.e-valy.com/cms/products/images/11461ceb-d498-4ac0-b849-08e1c7cbbc0e?h=250&w=250"
    }
  ];
  List<dynamic> productSizeList = [
    {'size': "S"},
    {'size': "M"},
    {'size': "L"},
    {'size': "XL"}
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: KSize.getHeight(context, 380),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: KColor.white,
          ),
          padding: const EdgeInsets.only(left: 8, right: 12, bottom: 15),
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
                        border: Border.all(color: KColor.gray.withOpacity(0.5)),
                        color: KColor.white,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: PageView.builder(
                          itemCount: productImageList.length,
                          controller: _controller,
                          itemBuilder: (ctx, position) {
                            return Image.network(
                              productImageList[position]['url'],
                              fit: BoxFit.fill,
                            );
                          }),
                    ),
                  ),
                  Row(
                    children: [
                      SmoothPageIndicator(
                        controller: _controller,
                        count: productImageList.length,
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
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: KSize.getWidth(context, 260),
                      child: Text(
                        "Essentials Men's Short-Sleeve Crewneck T-Shirt",
                        style: TextStyles.headline6,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: KSize.getWidth(context, 90),
                      child: Text(
                        "৳195.00",
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
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 19),
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
                                  "4.9 ",
                                  style: TextStyles.bodyText1
                                      .copyWith(color: KColor.gray223),
                                )
                              ],
                            )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 19),
                            child: IgnorePointer(
                                child: Row(
                              children: [
                                const Icon(
                                  Icons.brightness_1_sharp,
                                  size: 15,
                                  color: KColor.primary,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "100+ Reviews",
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: widget.add,
                            child: const CircleAvatar(
                              backgroundColor: KColor.primary,
                              child: Center(
                                child: Icon(
                                  Icons.remove,
                                  size: 25,
                                  color: KColor.black,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
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
                            onTap: widget.remove,
                            child: const CircleAvatar(
                              backgroundColor: KColor.primary,
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 25,
                                  color: KColor.black,
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
                  style: TextStyles.subTitle.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productImageList.length,
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
                            height: 54,
                            width: 54,
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
                                imageUrl:
                                    productImageList[index]['url'].toString(),
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
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productSizeList.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectSize = index;
                              });
                            },
                            child: Container(
                              height: 54,
                              width: 54,
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1,
                                      color: selectSize == index
                                          ? KColor.primary
                                          : KColor.gray)),
                              child: Center(
                                child: Text(
                                  productSizeList[index]['size'].toString(),
                                  style: TextStyles.headline6,
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
                const SizedBox(height: 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyles.subTitle.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "The Tech Hera is here to fulfil all of your chunky sneakers wishes. The wavy lifted midsole and suede accents level up your look while keeping you comfortable. And its durable design holds up beautifully to everyday wear—which is perfect, because you'll definitely want to wear these every day. holds up beautifully to everyday wear—which is perfect, because you'll definitely want",
                      textAlign: TextAlign.justify,
                      style:
                          TextStyles.bodyText1.copyWith(color: KColor.gray223),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Specification',
                      style: TextStyles.subTitle.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    _specification("Brand", "Upma"),
                    _specification("Product Type", "T-Shirt"),
                    _specification("Material", "Cotton 98%"),
                    _specification("Gender", "Men"),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
