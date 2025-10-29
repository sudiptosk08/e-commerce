import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class StoreProfilePage extends StatefulWidget {
  const StoreProfilePage({super.key});

  @override
  State<StoreProfilePage> createState() => _StoreProfilePageState();
}

class _StoreProfilePageState extends State<StoreProfilePage> {
  double ratings = 0.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            color: KColor.white,
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                    child: rowWidget(
                        "Location", "Dhaka,Banasree, Block J, Road 3")),
                Container(
                  height: 40,
                  width: 1,
                  color: KColor.background,
                ),
                Expanded(child: rowWidget("Time on Sell", "3 Years")),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: KColor.white,
            width: double.maxFinite,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                columnWidget("Main Category", "Sports & Outdoors"),
                columnWidget("Shipped on Time", "5 - 7 days delivery time"),
                columnWidget("Chat Response Time", "24 hours"),
                columnWidget("Seller Size", "Medium"),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: KColor.white,
            width: double.maxFinite,
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      "91%",
                      style: TextStyles.headline3,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Positive Seller Rating",
                      style: TextStyles.bodyText1,
                    ),
                  ],
                )),
                Container(
                  height: 40,
                  width: 1,
                  color: KColor.background,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      "Rate",
                      style: TextStyles.bodyText1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SmoothStarRating(
                      color: KColor.primary,
                      borderColor: KColor.yellow800,
                      size: 20,
                      rating: ratings,
                      onRatingChanged: (rating) {
                        setState(() {
                          ratings = rating;
                        });
                      },
                    ),
                  ],
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Seller Ratings & Reviews:",
            style: TextStyles.subTitle1,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
                color: KColor.white,
                width: double.maxFinite,
                padding: const EdgeInsets.all(12),
                child: ListView.builder(
                  itemCount: 20,
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
                              "Sudipto Sarker ",
                              style: TextStyles.bodyText1.copyWith(
                                  fontSize: 16,
                                  color: KColor.black54.withOpacity(0.8)),
                            ),
                            SmoothStarRating(
                              color: KColor.primary,
                              borderColor: KColor.yellow800,
                              size: 20,
                              rating: ratings,
                              onRatingChanged: (rating) {
                                setState(() {
                                  ratings = rating;
                                });
                              },
                            ),
                          ],
                        ),
                        Text(
                          '1 days ago',
                          style: TextStyles.bodyText2
                              .copyWith(color: KColor.black54),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Positive  Reviews for buyer',
                          style: TextStyles.bodyText2
                              .copyWith(color: KColor.black54),
                        ),
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
                )),
          ),
        ],
      ),
    );
  }

  Widget rowWidget(String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyles.subTitle1.copyWith(fontSize: 14, color: KColor.grey),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          description,
          style: TextStyles.bodyText2,
        )
      ],
    );
  }

  Widget columnWidget(String title, String description) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: TextStyles.subTitle1
                  .copyWith(fontSize: 14, color: KColor.grey),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 6,
            child: Text(
              description,
              style: TextStyles.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}
