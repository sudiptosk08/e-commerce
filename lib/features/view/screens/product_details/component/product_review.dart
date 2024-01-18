import 'package:ecommerce_app/features/view/screens/product_details/controller/product_details_controller.dart';
import 'package:ecommerce_app/features/view/screens/product_details/model/product_details_model.dart';
import 'package:ecommerce_app/features/view/screens/product_details/state/product_details_state.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ProductReview extends StatefulWidget {
  const ProductReview({super.key});

  @override
  State<ProductReview> createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final productDetailsState = ref.watch(productDetailsProvider);
      List<Review>? productDetails =
          productDetailsState is ProductDetailsSuccessState
              ? productDetailsState.productDetailsModel!.data.reviews
              : null;

      return productDetails!.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 150,
                  decoration: BoxDecoration(
                      color: KColor.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                                text: "05",
                                style: TextStyles.headline2,
                                children: [
                                  TextSpan(
                                      text: "/",
                                      style: TextStyles.headline6
                                          .copyWith(fontSize: 15)),
                                  TextSpan(
                                      text: "5 Star Rating",
                                      style: TextStyles.bodyText2)
                                ]),
                          ),
                          SmoothStarRating(
                            color: KColor.yellow800,
                            borderColor: KColor.yellow800,
                            size: 24,
                            rating: 5,
                          ),
                          Text(" 50+  Ratings",
                              style: TextStyles.bodyText2
                                  .copyWith(color: KColor.textgrey))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 87,
                                height: 6,
                                decoration: BoxDecoration(
                                    color: KColor.grey200,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 6,
                                      decoration: BoxDecoration(
                                          color: KColor.yellow800,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "(05 star)",
                                style: TextStyles.bodyText3,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 87,
                                height: 6,
                                decoration: BoxDecoration(
                                    color: KColor.grey200,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 65,
                                      height: 6,
                                      decoration: BoxDecoration(
                                          color: KColor.yellow800,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "(04 star)",
                                style: TextStyles.bodyText3,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 87,
                                height: 6,
                                decoration: BoxDecoration(
                                    color: KColor.grey200,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 6,
                                      decoration: BoxDecoration(
                                          color: KColor.yellow800,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "(03 star)",
                                style: TextStyles.bodyText3,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 87,
                                height: 6,
                                decoration: BoxDecoration(
                                    color: KColor.grey200,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 6,
                                      decoration: BoxDecoration(
                                          color: KColor.yellow800,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "(02 star)",
                                style: TextStyles.bodyText3,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 87,
                                height: 6,
                                decoration: BoxDecoration(
                                    color: KColor.grey200,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 6,
                                      decoration: BoxDecoration(
                                          color: KColor.yellow800,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "(01 star)",
                                style: TextStyles.bodyText3,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  "Product Reviews",
                  style: TextStyles.subTitle1,
                ),
                const SizedBox(
                  height: 7,
                ),
                ListView.builder(
                  itemCount: productDetails.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: KColor.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                productDetails[index].userName.toString(),
                                style: TextStyles.bodyText1.copyWith(
                                    fontSize: 16,
                                    color: KColor.black54.withOpacity(0.8)),
                              ),
                              SmoothStarRating(
                                color: KColor.yellow800,
                                borderColor: KColor.yellow800,
                                size: 20,
                                rating: productDetails[index].rating.toDouble(),
                                onRatingChanged: (rating) {
                                  // setState(() {
                                  //   ratings = rating;
                                  // });
                                },
                              ),
                            ],
                          ),
                          Text(
                            productDetails[index].createTime,
                            style: TextStyles.bodyText2
                                .copyWith(color: KColor.textgrey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            productDetails[index].review,
                            style: TextStyles.bodyText2
                                .copyWith(color: KColor.textgrey),
                          ),
                          const SizedBox(height: 8),
                          ...List.generate(
                              productDetails[index].images.length,
                              (index) => SizedBox(
                                    width: 65,
                                    height: 50,
                                    child: Image.network(
                                      productDetails[index].images[index],
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                        ],
                      ),
                    );
                  },
                ),
              ],
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    height: 150,
                    decoration: BoxDecoration(
                        color: KColor.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                  text: "05",
                                  style: TextStyles.headline2,
                                  children: [
                                    TextSpan(
                                        text: "/",
                                        style: TextStyles.headline6
                                            .copyWith(fontSize: 15)),
                                    TextSpan(
                                        text: "5 Star Rating",
                                        style: TextStyles.bodyText2)
                                  ]),
                            ),
                            SmoothStarRating(
                              color: KColor.yellow800,
                              borderColor: KColor.yellow800,
                              size: 24,
                              rating: 5,
                            ),
                            Text(" 50+  Ratings",
                                style: TextStyles.bodyText2
                                    .copyWith(color: KColor.textgrey))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 87,
                                  height: 6,
                                  decoration: BoxDecoration(
                                      color: KColor.grey200,
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 75,
                                        height: 6,
                                        decoration: BoxDecoration(
                                            color: KColor.yellow800,
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "(05 star)",
                                  style: TextStyles.bodyText3,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 87,
                                  height: 6,
                                  decoration: BoxDecoration(
                                      color: KColor.grey200,
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 69,
                                        height: 6,
                                        decoration: BoxDecoration(
                                            color: KColor.yellow800,
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "(04 star)",
                                  style: TextStyles.bodyText3,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 87,
                                  height: 6,
                                  decoration: BoxDecoration(
                                      color: KColor.grey200,
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 6,
                                        decoration: BoxDecoration(
                                            color: KColor.yellow800,
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "(03 star)",
                                  style: TextStyles.bodyText3,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 87,
                                  height: 6,
                                  decoration: BoxDecoration(
                                      color: KColor.grey200,
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 51,
                                        height: 6,
                                        decoration: BoxDecoration(
                                            color: KColor.yellow800,
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "(02 star)",
                                  style: TextStyles.bodyText3,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 87,
                                  height: 6,
                                  decoration: BoxDecoration(
                                      color: KColor.grey200,
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 6,
                                        decoration: BoxDecoration(
                                            color: KColor.yellow800,
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "(01 star)",
                                  style: TextStyles.bodyText3,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Product Reviews",
                    style: TextStyles.subTitle1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "No avaiable Reviews",
                      style: TextStyles.bodyText2,
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
