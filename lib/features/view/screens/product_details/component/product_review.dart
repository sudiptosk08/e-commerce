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
          ? Container(
              color: KColor.white,
              width: double.maxFinite,
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: productDetails.length,
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
                            productDetails[index].userName.toString(),
                            style: TextStyles.bodyText1.copyWith(
                                fontSize: 16,
                                color: KColor.black54.withOpacity(0.8)),
                          ),
                          SmoothStarRating(
                            color: KColor.primary,
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
                            .copyWith(color: KColor.black54),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        productDetails[index].review,
                        style: TextStyles.bodyText2
                            .copyWith(color: KColor.black54),
                      ),
                      const SizedBox(height: 8),
                      ...List.generate(
                          productDetails[index].images.length,
                          (index) => SizedBox(
                                width: 50,
                                height: 40,
                                child: Image.network(
                                    productDetails[index].images[index]),
                              )),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        child: Divider(
                          color: KColor.grey,
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
