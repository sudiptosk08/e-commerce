import 'package:ecommerce_app/features/view/screens/my_order/controller/my_order_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/controller/my_order_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/size/k_size.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/buttons/Kdrop_down_field.dart';
import '../../my_order_details/my_order_details_page.dart';

class MyOrderCard extends StatelessWidget {
  final bool isChecked;
  final String id;
  final String inVoice;
  final String date;
  final String paymentMethod;
  final String paymentStatus;
  final String grandTotal;
  final String deliveryType;
  final String status;
  const MyOrderCard(
      {required this.isChecked,
      Key? key,
      required this.inVoice,
      required this.id,
      required this.date,
      required this.paymentMethod,
      required this.paymentStatus,
      required this.grandTotal,
      required this.deliveryType,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: KColor.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(inVoice,
                  style: TextStyles.subTitle1.copyWith(
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
              SizedBox(
                width: KSize.getWidth(context, 112),
                child: Text(
                  "Delivered By",
                  style: TextStyles.bodyText1
                      .copyWith(color: KColor.black54, wordSpacing: 2),
                ),
              ),
              Text(":",
                  style: TextStyles.bodyText1.copyWith(color: KColor.black54)),
              Text(" $deliveryType",
                  style: TextStyles.bodyText1.copyWith(color: KColor.green)),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: KSize.getWidth(context, 112),
                child: Text(
                  "Payment  Method ",
                  style: TextStyles.bodyText1
                      .copyWith(color: KColor.black54, wordSpacing: 1.3),
                ),
              ),
              Text(":",
                  style: TextStyles.bodyText1.copyWith(color: KColor.black54)),
              Text(" $paymentMethod",
                  style: TextStyles.bodyText1.copyWith(color: KColor.green)),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: KSize.getWidth(context, 112),
                child: Text(
                  "Payment  Status ",
                  style: TextStyles.bodyText1
                      .copyWith(color: KColor.black54, wordSpacing: 1.3),
                ),
              ),
              Text(":",
                  style: TextStyles.bodyText1.copyWith(color: KColor.black54)),
              Text(" $paymentStatus",
                  style: TextStyles.bodyText1.copyWith(color: KColor.green)),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Consumer(
                    builder: (context, ref, child) => KButton(
                      width: status == "Pending"
                          ? KSize.getWidth(context, 80)
                          : KSize.getWidth(context, 110),
                      height: 37,
                      isOutlineButton: false,
                      radius: 8,
                      color: status == "Cancelled"
                          ? KColor.errorRedText
                          : KColor.primary,
                      textStyle: TextStyles.bodyText1.copyWith(
                          color: KColor.white, fontWeight: FontWeight.w800),
                      onPressedCallback: () {
                        ref
                            .read(myOrderDetailsProvider.notifier)
                            .fetchMyOrdersDetails(id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const OrderDetailsPage()));
                      },
                      title: status == "Cancelled" ? "Re - Order" : "Details",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Consumer(
                    builder: (context, ref, child) => status == "Pending"
                        ? KButton(
                            width: KSize.getWidth(context, 80),
                            height: 37,
                            isOutlineButton: false,
                            radius: 8,
                            color: KColor.errorRedText,
                            textStyle: TextStyles.bodyText1.copyWith(
                                color: KColor.white,
                                fontWeight: FontWeight.w800),
                            onPressedCallback: () {
                              ref
                                  .read(myOrderProvider.notifier)
                                  .cancelOrder(id: id.toInt());
                            },
                            title: "Cancel",
                          )
                        : Container(),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    status,
                    style: TextStyles.subTitle1.copyWith(
                      color: KColor.green,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text("৳$grandTotal",
                      style: TextStyles.subTitle1.copyWith(
                        color: KColor.errorRedText,
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
