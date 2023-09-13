import 'package:ecommerce_app/features/view/screens/product_details/controller/product_details_controller.dart';
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
      final productDetails = productDetailsState is ProductDetailsSuccessState
          ? productDetailsState.productDetailsModel!.data
          : null;

      return productDetails!.reviews == []
          ? Container(
              color: KColor.white,
              width: double.maxFinite,
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: productDetails.reviews.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productDetails.reviews[index].userName.toString(),
                            style: TextStyles.bodyText1.copyWith(
                                fontSize: 16,
                                color: KColor.black54.withOpacity(0.8)),
                          ),
                          SmoothStarRating(
                            color: KColor.primary,
                            borderColor: KColor.yellow800,
                            size: 20,
                            rating:
                                productDetails.reviews[index].rating.toDouble(),
                            onRatingChanged: (rating) {
                              // setState(() {
                              //   ratings = rating;
                              // });
                            },
                          ),
                        ],
                      ),
                      Text(
                        productDetails.reviews[index].createTime,
                        style: TextStyles.bodyText2
                            .copyWith(color: KColor.black54),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        productDetails.reviews[index].review,
                        style: TextStyles.bodyText2
                            .copyWith(color: KColor.black54),
                      ),
                      const SizedBox(height: 8),
                      ...List.generate(
                          productDetails.reviews[index].images.length,
                          (index) => SizedBox(
                                width: 50,
                                height: 40,
                                child: Image.network(productDetails
                                    .reviews[index].images[index]),
                              )),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        child: Divider(
                          color: KColor.background,
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  );
                },
              ))
          : Center(
              child: Text(
                "No avaiable Reviews",
                style: TextStyles.bodyText2,
              ),
            );
    });
  }
}
