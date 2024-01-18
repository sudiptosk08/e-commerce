// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/constant/shared_preference_constant.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/controller/get_shipping_address_controller.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/state/get_shipping_address_state.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_styles/text_styles.dart';
import '../../global_component/appBar/app_bar.dart';
import '../../global_component/buttons/Kdrop_down_field.dart';
import '../checkout/checkout_page.dart';
import 'component/add_shipping_address_page.dart';
import 'component/shpping_address_card.dart';

class ShippingAddressPage extends StatefulWidget {
  String page;
  ShippingAddressPage({super.key, required this.page});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  int selectedAddressIndex = getIntAsync(selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final addressState = ref.watch(addressListProvider);
      final addressDetails = addressState is ShippingAddressListSuccessState
          ? addressState.shippingAddressList!.data
          : null;

      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: KAppBar(
            checkTitle: true,
            title: "Shipping Address",
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            actions: [
              IconButton(
                  padding: const EdgeInsets.only(right: 10),
                  highlightColor: KColor.grey100,
                  // color: KColor.primary,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddShippingAddressPage(
                                  area: "",
                                  city: "",
                                  house: "",
                                  region: "",
                                  selectedValue: 0,
                                )));
                  },
                  icon: const Icon(
                    Icons.add_home_outlined,
                    size: 30,
                  )),
            ],
          ),
        ),
        backgroundColor: KColor.background,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              margin: const EdgeInsets.only(
                  top: 12, left: 12, right: 12, bottom: 70),
              child: addressDetails != null
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: addressDetails.length,
                      itemBuilder: (ctx, index) {
                        return ShippingAddressCard(
                          onTap: () {
                            setState(() {
                              selectedAddressIndex = index;
                              setValue(selectedIndex, selectedAddressIndex);
                            });
                            NavigationService.navigateTo(SizeRoute(
                                page: AddShippingAddressPage(
                              area: addressDetails[index].area,
                              city: addressDetails[index].city,
                              house: addressDetails[index].address,
                              region: addressDetails[index].address,
                              selectedValue:
                                  addressDetails[index].addressType == "Home"
                                      ? 0
                                      : 1,
                            )));
                          },
                          isChecked: index ==
                              selectedAddressIndex, // Check if this address is selected
                          // Other properties...
                          onSelect: () {
                            // Update the selected address index when an address is selected

                            setState(() {
                              selectedAddressIndex = index;
                              setValue(selectedIndex, selectedAddressIndex);
                            });
                          },
                          userName:
                              "${getStringAsync(firstName)} ${getStringAsync(lastName)}",
                          phone: addressDetails[index].phone,
                          address: addressDetails[index].address,
                          city: addressDetails[index].city,
                          zone: addressDetails[index].region,
                          area: addressDetails[index].area,
                          addressType: addressDetails[index].addressType,
                          cancel: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          delete: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    )
                  : Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: KSize.getHeight(context, 220),
                            ),
                            const Icon(
                              Icons.add_box_rounded,
                              size: 35,
                              color: KColor.grey,
                            ),
                            Text(
                              "Add Shipping Address",
                              style: TextStyles.subTitle1,
                            ),
                          ]),
                    )),
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
            textColor: KColor.black,
            onPressedCallback: () async {
              var addresses = {
                'city': addressDetails![selectedAddressIndex].city,
                'address': addressDetails[selectedAddressIndex].address,
                'addressType': addressDetails[selectedAddressIndex].addressType,
                'area': addressDetails[selectedAddressIndex].area,
                'phone': addressDetails[selectedAddressIndex].phone,
                'region': addressDetails[selectedAddressIndex].region,
              };
              saveAddressesToLocalStorage(addresses);
              widget.page == 'checkout'
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckoutPage()))
                  : Navigator.pop(context);
            },
            title: "Save Address",
          ),
        ),
        //floatingActionButton:
      );
    });
  }

  void saveAddressesToLocalStorage(Map<String, dynamic> addresses) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_addresses', json.encode(addresses));
  }
}
