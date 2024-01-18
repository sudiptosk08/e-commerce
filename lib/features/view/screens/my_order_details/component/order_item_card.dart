import 'package:ecommerce_app/features/view/global_component/buttons/Kdrop_down_field.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/controller/my_order_details_controller.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/model/my_order_details_model.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/page/write_review_page.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/state/my_order_details_state.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final orderState = ref.watch(myOrderDetailsProvider);
      //  final List<Datum>? wishlistData = wishlistProductsState is WishlistSuccessState ? wishlistProductsState.wishlistModel?.wishlist.data : [];

      final List<Item> orderDetailsItem =
          orderState is MyOrderDetailsSuccessState
              ? orderState.myOrderDetailsModel!.data.items
              : [];

      return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: orderDetailsItem.length,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.3),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: KColor.white,
              ),
              child: Row(
                children: [
                  Container(
                    width: KSize.getWidth(context, 108),
                    height: 90,
                    padding: const EdgeInsets.all(2),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              orderDetailsItem[index].image,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: KSize.getWidth(context, 215),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(orderDetailsItem[index].name,
                            maxLines: 1,
                            style: TextStyles.bodyText1
                              ..copyWith(color: KColor.black54)),
                        Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Text("Size",
                                      style: TextStyles.bodyText1
                                          .copyWith(color: KColor.black54)),
                                ),
                                Text(": ",
                                    style: TextStyles.bodyText1
                                        .copyWith(color: KColor.black54)),
                                Text(orderDetailsItem[index].variants[0].value,
                                    style: TextStyles.bodyText1
                                        .copyWith(color: KColor.black54)),
                              ],
                            ),
                            Text("   ||   ",
                                style: TextStyles.bodyText1
                                    .copyWith(color: KColor.black54)),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Text("Color ",
                                      style: TextStyles.bodyText1
                                          .copyWith(color: KColor.black54)),
                                ),
                                Text(": ",
                                    style: TextStyles.bodyText1
                                        .copyWith(color: KColor.black54)),
                                Text(orderDetailsItem[index].variants[1].value,
                                    style: TextStyles.bodyText1
                                        .copyWith(color: KColor.black54)),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: Text("Qty",
                                  style: TextStyles.bodyText1
                                      .copyWith(color: KColor.black54)),
                            ),
                            Text(": ",
                                style: TextStyles.bodyText1
                                    .copyWith(color: KColor.black54)),
                            Text(orderDetailsItem[index].quantity,
                                style: TextStyles.bodyText1
                                    .copyWith(color: KColor.black54)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Text("Price",
                                      style: TextStyles.bodyText1
                                          .copyWith(color: KColor.black54)),
                                ),
                                Text(": ",
                                    style: TextStyles.bodyText1
                                        .copyWith(color: KColor.black54)),
                                Text("৳${orderDetailsItem[index].total}",
                                    style: TextStyles.subTitle1.copyWith(
                                        color: KColor.errorRedText,
                                        height: 1.5)),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            KButton(
                              width: 90,
                              height: 29,
                              radius: 4,
                              color: KColor.errorRedText,
                              title: 'Write Review',
                              textStyle: TextStyles.bodyText2.copyWith(
                                  color: KColor.white,
                                  fontWeight: FontWeight.w500),
                              onPressedCallback: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WriteReview(
                                            id: orderDetailsItem[index]
                                                .productId)));
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      );
    });
  }
}
