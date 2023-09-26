// ignore_for_file: avoid_print

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/global_component/shimmer/placeholder_shimmer.dart';
import 'package:ecommerce_app/features/view/screens/my_order/controller/my_order_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/my_order/state/my_orderList_state.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../model/my_order_list_model.dart';
import 'my_order_card.dart';

class SpecificOrder extends StatefulWidget {
  final String orderStatus;
  const SpecificOrder({Key? key, required this.orderStatus}) : super(key: key);

  @override
  State<SpecificOrder> createState() => _SpecificOrderState();
}

class _SpecificOrderState extends State<SpecificOrder> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final orderState = ref.watch(myOrderProvider);

      final List<Datum>? orderList = orderState is MyOrderListSuccessState
          ? orderState.myOrderListModel?.data
              .where((element) => (element.status == widget.orderStatus))
              .toList()
          : [];
      print("using -----index where");
      if (orderList!.isNotEmpty) {
        print(
            orderList.where((element) => element.status == "Cancelled").length);
      }
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: orderState is LoadingState
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ...List.generate(
                            5,
                            (index) => const Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    MyOrderPlaceholder(
                                      lineType: ContentLineType.threeLines,
                                    ),
                                  ],
                                )),
                      ]),
                ))
            : orderList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.database,
                          color: KColor.grey,
                          size: 35,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "No Data Available !",
                          style: TextStyles.bodyText1.copyWith(
                            color: KColor.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            MyOrderCard(
                                isChecked: true,
                                id: orderList[index].id.toString(),
                                inVoice: orderList[index].orderId,
                                date: orderList[index].createdAt.toString(),
                                paymentMethod: orderList[index].paymentMethod,
                                paymentStatus: orderList[index].paymentStatus,
                                grandTotal:
                                    orderList[index].totalPrice.toString(),
                                deliveryType: orderList[index].deliveryMethodId,
                                status: orderList[index].status),
                          ],
                        ),
                      );
                    },
                  ),
      );
    });
  }
}
