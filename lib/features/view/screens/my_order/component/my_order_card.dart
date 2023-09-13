import 'package:flutter/material.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/size/k_size.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/buttons/Kdrop_down_field.dart';
import '../../my_order_details/my_order_details_page.dart';

class MyOrderCard extends StatelessWidget {
  final bool isChecked;
  final String id;
  final String date;
  final String userName;
  final String contract;
  final String grandTotal;
  final String paymentType;
  final String status;
  const MyOrderCard(
      {required this.isChecked,
      Key? key,
      required this.id,
      required this.date,
      required this.userName,
      required this.contract,
      required this.grandTotal,
      required this.paymentType,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: KColor.white,
          border:
              Border.all(color: KColor.textgrey.withOpacity(0.4), width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Order No: #$id",
                  style: TextStyles.subTitle.copyWith(
                    color: KColor.black54,
                  )),
              Text(
                // "Placed on 8 May",
                date,
                style: TextStyles.bodyText1.copyWith(
                  color: KColor.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Tracking Number : ",
                style: TextStyles.bodyText1.copyWith(
                  color: KColor.black54,
                ),
              ),
              Text("IW25879SB",
                  style: TextStyles.bodyText1.copyWith(color: KColor.black54)),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Quantity : ",
                      style: TextStyles.bodyText1.copyWith(
                        color: KColor.black54,
                      ),
                    ),
                    Text("3",
                        style: TextStyles.bodyText1
                            .copyWith(color: KColor.black54)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Total Amount : ",
                      style: TextStyles.bodyText1.copyWith(
                        color: KColor.black54,
                      ),
                    ),
                    Text("৳$grandTotal",
                        style: TextStyles.bodyText1
                            .copyWith(color: KColor.errorRedText)),
                  ],
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KButton(
                width: KSize.getWidth(context, 110),
                height: 40,
                isOutlineButton: false,
                radius: 8,
                color: KColor.primary,
                textStyle: TextStyles.bodyText1
                    .copyWith(color: KColor.white, fontWeight: FontWeight.w500),
                onPressedCallback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderDetailsPage(
                                orderData: "laksjdf",
                              )));
                },
                title: "Details",
              ),
              const SizedBox(width: 3),
              Text(
                status,
                style: TextStyles.bodyText1.copyWith(
                  color: KColor.green,
                ),
              ),
            ],
          ),

          // review
          // if (status == "Delivered")
          //   InkWell(
          //     onTap: () {
          //       Navigator.pushNamed(context, '/orderDetails');
          //     },
          //     child: Container(
          //       height: 40,
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(8),
          //         border: Border.all(
          //           color: KColor.black.withOpacity(0.7),
          //         ),
          //       ),
          //       child: Row(
          //         children: [
          //           Text(
          //             'Review',
          //             style: TextStyles.subtitle1.copyWith(
          //               color: KColor.background,
          //             ),
          //           ),
          //           const SizedBox(width: 3),
          //           SvgPicture.asset('assets/images/edit.svg', height: 20)
          //         ],
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
