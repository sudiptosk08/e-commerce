import 'package:ecommerce_app/features/view/global_component/shimmer/placeholder_shimmer.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/component/order_item_card.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/component/stepper.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/controller/my_order_details_controller.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/state/my_order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/size/k_size.dart';
import '../../../../utils/text_styles/text_styles.dart';
import '../../global_component/appBar/app_bar.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  int _currentStep = 0;
  List<String> _steps = ['Order Placed', 'In Progress', 'Shipped', 'Delivered'];

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final orderState = ref.watch(myOrderDetailsProvider);
      //  final List<Datum>? wishlistData = wishlistProductsState is WishlistSuccessState ? wishlistProductsState.wishlistModel?.wishlist.data : [];

      final orderDetailsAddress = orderState is MyOrderDetailsSuccessState
          ? orderState.myOrderDetailsModel!.data.userAddress
          : null;

      final orderDetails = orderState is MyOrderDetailsSuccessState
          ? orderState.myOrderDetailsModel!.data
          : null;

      return Scaffold(
        backgroundColor: KColor.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: KAppBar(
            checkTitle: true,
            title: 'Order Details',
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
        ),
        body: orderDetails != null
            ? SingleChildScrollView(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order Id #${orderDetails.orderId}",
                              style: TextStyles.subTitle1),
                        ],
                      ),
                      KStepper(),
                      const SizedBox(height: 5),
                      const OrderItemCard(),
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: KColor.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Shipping Method",
                                        style: TextStyles.subTitle1),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        orderDetails.deliveryMethodId ??
                                            "Pathao (Home Delivery)",
                                        style: TextStyles.bodyText2.copyWith(
                                            color: KColor.textgrey,
                                            fontSize: 13)),
                                  ],
                                ),
                                SizedBox(
                                  width: 130,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Payment Status  ",
                                          style: TextStyles.subTitle1),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text("Unpaid",
                                          style: TextStyles.bodyText2.copyWith(
                                              color: KColor.textgrey,
                                              fontSize: 13)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Order Date",
                                        style: TextStyles.subTitle1),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(orderDetails.createdAt.toString(),
                                        style: TextStyles.bodyText2.copyWith(
                                            color: KColor.textgrey,
                                            fontSize: 13)),
                                  ],
                                ),
                                SizedBox(
                                  width: 130,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Estimate Delivery",
                                          style: TextStyles.subTitle1),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text("3-5 days (all items)",
                                          style: TextStyles.bodyText2.copyWith(
                                              color: KColor.textgrey,
                                              fontSize: 13)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: KColor.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Shipping Information",
                                    style: TextStyles.subTitle1),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _getTotal(
                              "Shipping City/Region",
                              "${orderDetailsAddress!.city}, ${orderDetailsAddress.region}",
                            ),
                            const SizedBox(height: 8),
                            _getTotal(
                              "Shipping Address",
                              "${orderDetailsAddress.address.toString()} , ${orderDetailsAddress.area}",
                            ),
                            const SizedBox(height: 8),
                            _getTotal(
                                "Payment Method", orderDetails.paymentMethod),
                            const SizedBox(height: 8),
                            _getTotal("Discount", orderDetails.deliveryCharge),
                            const SizedBox(height: 8),
                            _getTotal("Total Amount", orderDetails.totalPrice),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          height: 9,
                        ),
                        const WishListPlaceholder(
                            lineType: ContentLineType.threeLines),
                        const SizedBox(
                          height: 9,
                        ),
                        const WishListPlaceholder(
                            lineType: ContentLineType.threeLines),
                        const SizedBox(
                          height: 9,
                        ),
                        const TitlePlaceholder(width: double.infinity),
                        const SizedBox(
                          height: 9,
                        ),
                        BannerPlaceholder(
                          height: 220,
                        ),
                      ]),
                )),
      );
    });
  }

  Row _getTotal(title, description) {
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

class StepWidget extends StatelessWidget {
  final String title;
  final bool isActive;

  const StepWidget({
    required this.title,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Text(
        title,
        style: TextStyles.bodyText1,
      ),
    );
  }
}
