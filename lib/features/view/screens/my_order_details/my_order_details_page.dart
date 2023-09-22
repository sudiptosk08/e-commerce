import 'package:ecommerce_app/features/view/screens/my_order_details/page/track_order_page.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/page/write_review_page.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/size/k_size.dart';
import '../../../../utils/text_styles/text_styles.dart';
import '../../global_component/appBar/app_bar.dart';
import '../../global_component/buttons/Kdrop_down_field.dart';
import 'component/order_item_card.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order No: #${198754}", style: TextStyles.subTitle),
                  Text("30-03-2023",
                      style:
                          TextStyles.bodyText1.copyWith(color: KColor.black54)),
                ],
              ),
              const SizedBox(height: 5),
              const OrderItemCard(),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: KColor.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order Information", style: TextStyles.subTitle),
                        Text(
                          "Delivered",
                          style: TextStyles.bodyText1.copyWith(
                            color: KColor.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _getTotal("Shipping Address", "Modina Market, Sylhet"),
                    const SizedBox(height: 8),
                    _getTotal("Payment Method", "Cash On Delivery"),
                    const SizedBox(height: 8),
                    _getTotal("Delivery Method", "Pathao"),
                    const SizedBox(height: 8),
                    _getTotal("Discount", "20%"),
                    const SizedBox(height: 8),
                    _getTotal("Total Amount", "825"),
                    const SizedBox(height: 8),
                    _getTotal("Tracking Number", "IW25879SB"),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  KButton(
                    width: context.screenWidth * 0.4,
                    height: 40,
                    radius: 8,
                    title: 'Write Review',
                    textStyle: TextStyles.bodyText1.copyWith(
                        color: KColor.white, fontWeight: FontWeight.w500),
                    onPressedCallback: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WriteReview()));
                    },
                  ),
                  KButton(
                    width: context.screenWidth * 0.4,
                    height: 40,
                    textStyle: TextStyles.bodyText1.copyWith(
                        color: KColor.white, fontWeight: FontWeight.w500),
                    onPressedCallback: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrackOrder()));
                    },
                    radius: 8,
                    title: 'Track Order',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
