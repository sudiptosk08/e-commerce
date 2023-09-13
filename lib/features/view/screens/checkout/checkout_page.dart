import 'package:ecommerce_app/features/view/screens/checkout/component/cupon_card.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';
import '../../../../utils/assets/app_assets.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/size/k_size.dart';
import '../../../../utils/text_styles/text_styles.dart';
import '../../global_component/appBar/app_bar.dart';
import '../../global_component/buttons/Kdrop_down_field.dart';
import '../shipping_address/shipping_address_page.dart';
import 'component/cart_item_list.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  var selectMethod;

  TextEditingController promoCode = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController referralCode = TextEditingController();
  TextEditingController giftVoucherCode = TextEditingController();

  List<dynamic> productSizeList = [
    {'name': "COD", 'image': AppAssets.cod},
    {'name': "bkash", 'image': AppAssets.bkash},
    {'name': "Nagod", 'image': AppAssets.nagad},
    {'name': "Card", 'image': AppAssets.card},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: KAppBar(
            checkTitle: true,
            title: 'Checkout',
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios))),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SvgPicture.asset('assets/images/stepper_three.svg'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SelectedItems(),
                  Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: KColor.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Shipping Info',
                                      style: TextStyles.subTitle
                                          .copyWith(color: KColor.black),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ShippingAddressPage()));
                                        },
                                        icon: const Icon(Icons.edit)),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Sudipto Sarker',
                                  style: TextStyles.bodyText1.copyWith(
                                      color: KColor.black.withOpacity(0.6)),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '01758039342',
                                  style: TextStyles.bodyText1.copyWith(
                                      color: KColor.black.withOpacity(0.6)),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Sylhet Sardar, Sylhet , Bangladesh",
                                  style: TextStyles.bodyText1.copyWith(
                                      color: KColor.black.withOpacity(0.6)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        Text(
                          'Payment Method',
                          style:
                              TextStyles.subTitle.copyWith(color: KColor.black),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 90,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productSizeList.length,
                            itemBuilder: (context, int index) {
                              return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectMethod = index;
                                      });
                                    },
                                    child: Container(
                                      width: 80,
                                      margin: const EdgeInsets.only(bottom: 5),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              width: 2,
                                              color: selectMethod == index
                                                  ? KColor.primary
                                                  : KColor.grey
                                                      .withOpacity(0.6))),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: KSize.getWidth(context, 3.0)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(
                                              "${productSizeList[index]['image']}",
                                              height: 50,
                                              width: 50,
                                            ),
                                            Text(
                                              "${productSizeList[index]['name']}",
                                              style: TextStyles.bodyText1
                                                  .copyWith(
                                                      color: KColor.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: KColor.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            text("SubTotal", "৳3200"),
                            const SizedBox(
                              height: 8,
                            ),
                            text("Shipping", "৳100"),
                            const SizedBox(
                              height: 5,
                            ),
                            text("Discount", "20%"),
                            CouponCodeCard(
                              buttonText: "Apply",
                              controller: promoCode,
                              hintText: "Voucher Code",
                              readOnly: false,
                              tap: () {},
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: KColor.grey350,
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            text("Total", "৳3310"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.screenHeight * 0.1),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(12.0),
        child: KButton(
          width: double.infinity,
          height: 40,
          isOutlineButton: false,
          radius: 8,
          color: KColor.primary,
          textStyle: TextStyles.bodyText1
              .copyWith(color: KColor.white, fontWeight: FontWeight.w500),
          onPressedCallback: () {},
          title: "Place to Order",
        ),
      ),
    );
  }

  text(String title, String price) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.bodyText1,
          ),
          Text(
            price,
            style: TextStyles.bodyText1,
          )
        ],
      ),
    );
  }
}
