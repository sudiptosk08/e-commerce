import 'package:ecommerce_app/features/view/global_component/appBar/app_bar.dart';
import 'package:ecommerce_app/features/view/screens/coupon/component/coupon_card.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({super.key});

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: KAppBar(
          checkTitle: true,
          title: 'Coupon',
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Available Coupons",
                style: TextStyles.subTitle1,
              ),
              const SizedBox(
                height: 20,
              ),
              CouponCard(
                  couponTitle: "CashBack20",
                  couponDetails: "Add items worth &2 more to unlock",
                  discount: "Up to &20.00 cashback"),
              CouponCard(
                  couponTitle: "CashBack100",
                  couponDetails: "Must order balance upto 500 Tk.",
                  discount: "Up to &100.00 cashback"),
              CouponCard(
                  couponTitle: "CashBack20",
                  couponDetails: "Add items worth &2 more to unlock",
                  discount: "Up to &20.00 cashback"),
              CouponCard(
                  couponTitle: "CashBack100",
                  couponDetails: "Must order balance upto 500 Tk.",
                  discount: "Up to &100.00 cashback"),
            ],
          ),
        ),
      ),
    );
  }
}
