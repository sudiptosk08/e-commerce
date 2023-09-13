import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: 3,
      itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.3),
          child: Container(
            width: double.infinity,
            padding:const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(width: 1, color: KColor.textgrey.withOpacity(0.4)),
              color: KColor.white,
            ),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 90,
                  padding: const EdgeInsets.all(2),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            "https://assets.adidas.com/images/w_383,h_383,f_auto,q_auto,fl_lossy,c_fill,g_auto/3f5a615e22184343bd10af8d008646d7_9366/ultraboost-light-running-shoes.jpg",
                          )),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 190,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("YunKeliu Men Blazer Coat hati ghora palki ",
                          style: TextStyles.bodyText1
                            ..copyWith(color: KColor.black54)),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text("Color : ",
                                  style: TextStyles.bodyText1
                                      .copyWith(color: KColor.black54)),
                              const SizedBox(
                                width: 2,
                              ),
                              Text("Gray",
                                  style: TextStyles.bodyText1
                                      .copyWith(color: KColor.black54)),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Text("Size : ",
                                  style: TextStyles.bodyText1
                                      .copyWith(color: KColor.black54)),
                              const SizedBox(
                                width: 2,
                              ),
                              Text("L",
                                  style: TextStyles.bodyText1
                                      .copyWith(color: KColor.black54)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Group : ",
                              style: TextStyles.bodyText1
                                  .copyWith(color: KColor.black54)),
                          const SizedBox(
                            width: 2,
                          ),
                          Text("Shirt",
                              style: TextStyles.bodyText1
                                  .copyWith(color: KColor.black54)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Price : ",
                              style: TextStyles.bodyText1
                                  .copyWith(color: KColor.black54)),
                          const SizedBox(
                            width: 2,
                          ),
                          Text("1050",
                              style: TextStyles.bodyText1
                                  .copyWith(color: KColor.errorRedText)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
