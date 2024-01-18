import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/global_component/appBar/app_bar.dart';
import 'package:ecommerce_app/features/view/global_component/buttons/Kdrop_down_field.dart';
import 'package:ecommerce_app/features/view/global_component/text_field_container/k_text_field.dart';
import 'package:ecommerce_app/features/view/screens/checkout/controller/checkout_controller.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardPaymentScreen extends StatefulWidget {
  const CardPaymentScreen({super.key});

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  var selectMethod = -1;
  TextEditingController nameController = TextEditingController();

  List<dynamic> productSizeList = [
    {'name': "VISA", 'image': AppAssets.visa},
    {'name': "Master ", 'image': AppAssets.master},
    {'name': "GPay", 'image': AppAssets.gpay},
  ];
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final orderState = ref.watch(orderProvider);

      return Scaffold(
        backgroundColor: KColor.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: KAppBar(
              checkTitle: true,
              title: 'Checkout',
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios))),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Card Method',
                style: TextStyles.subTitle1.copyWith(color: KColor.black),
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
                        padding: const EdgeInsets.only(
                            left: 8, top: 3.0, bottom: 3.0, right: 7),
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
                              color: selectMethod == index
                                  ? const Color(0xffEDFFF6)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
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
                                        .copyWith(color: KColor.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              KFillNormal(
                  label: "",
                  inputType: TextInputType.name,
                  controller: nameController,
                  hintText: "Card Holder Name",
                  readOnly: false),
              const SizedBox(
                height: 12,
              ),
              KFillNormal(
                  label: "",
                  inputType: TextInputType.number,
                  controller: nameController,
                  hintText: "Card Number ",
                  readOnly: false),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: KFillNormal(
                        label: "",
                        inputType: TextInputType.name,
                        controller: nameController,
                        hintText: "Exp Date",
                        readOnly: false),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: KFillNormal(
                        label: "",
                        inputType: TextInputType.name,
                        controller: nameController,
                        hintText: "CVC",
                        readOnly: false),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Save my card details for next time?",
                    style:
                        TextStyles.bodyText2.copyWith(color: KColor.textgrey),
                  ),
                  Switch(
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                    activeColor: KColor.primary,
                  ),
                ],
              )
            ],
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
            onPressedCallback: () {
              // ref.read(orderProvider.notifier).orderPlaced(
              //       cartItems: orderItems,
              //       totalAmount: ref.read(cartProvider.notifier).subTotal,
              //       paymentMethoId: selectMethod,
              //       deliveryMethodId: "1",
              //       firstName: getStringAsync(firstName),
              //       lastName: getStringAsync(lastName),
              //       discount: "0",
              //       insideDhaka: isChecked,
              //       region: storedAddresses['region'].toString(),
              //       address: storedAddresses['address'].toString(),
              //       area: storedAddresses['area'].toString(),
              //       phone: storedAddresses['phone'].toString(),
              //       city: storedAddresses['city'].toString(),
              //       email: "sudiptosarker05@gmail.com",
              //     );
            },
            title:
                orderState is LoadingState ? "Please Wait" : "Place to Order",
          ),
        ),
      );
    });
  }
}
