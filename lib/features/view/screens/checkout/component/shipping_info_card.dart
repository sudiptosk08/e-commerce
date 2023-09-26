import 'dart:convert';

import 'package:ecommerce_app/constant/shared_preference_constant.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../utils/colors/app_colors.dart';

class ShippingInfoCard extends StatefulWidget {
  const ShippingInfoCard({super.key});

  @override
  State<ShippingInfoCard> createState() => _ShippingInfoCardState();
}

class _ShippingInfoCardState extends State<ShippingInfoCard> {
  String? city;
  String? address;
  String? addressType;
  String? area;
  String? phone;
  String? region;

  Map<String, dynamic>? storedAddresses;

  @override
  void initState() {
    super.initState();
    loadDataFromLocalStorage();
  }

  Future<void> loadDataFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? addressesJson = prefs.getString('user_addresses');
    storedAddresses = addressesJson != null ? json.decode(addressesJson) : null;

    getAddress(); // Call the method to update the state.
  }

  // Rest of your code remains the same...

  getAddress() {
    if (storedAddresses != null) {
      // You can access the stored addresses like this:
      city = storedAddresses!['city'];
      address = storedAddresses!['address'];
      addressType = storedAddresses!['addressType'];
      area = storedAddresses!['area'];
      phone = storedAddresses!['phone'];
      region = storedAddresses!['region'];

      // Use the retrieved values as needed in your app.
    } else {
      // No addresses are stored in local storage.
    }
  }

  @override
  Widget build(BuildContext context) {
    return city != null ||
            address != null ||
            addressType != null ||
            area != null ||
            phone != null ||
            region != null
        ? Container(
            //padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 4),
            height: 105,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: KColor.white,
                border: Border.all(
                    color: KColor.textgrey.withOpacity(0.4), width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                "${getStringAsync(firstName)} ${getStringAsync(lastName)}",
                                style: TextStyles.bodyText1
                                    .copyWith(color: KColor.black),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Flexible(
                              child: Text(
                                '$phone',
                                style: TextStyles.bodyText1
                                    .copyWith(color: KColor.black),
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text('$city ',
                                style: TextStyles.bodyText1
                                    .copyWith(color: KColor.black54)),
                            Row(
                              children: [
                                Text(
                                  '$region ',
                                  style: TextStyles.bodyText1
                                      .copyWith(color: KColor.black54),
                                ),
                                Text(
                                  '$area ',
                                  style: TextStyles.bodyText1
                                      .copyWith(color: KColor.black54),
                                ),
                              ],
                            ),
                            Text(
                              '$address',
                              style: TextStyles.bodyText1
                                  .copyWith(color: KColor.black54),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(
                      left: 13, top: 4, right: 13, bottom: 4),
                  decoration: BoxDecoration(
                      color: KColor.black,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    addressType.toString(),
                    style: TextStyles.bodyText1.copyWith(color: KColor.white),
                  ),
                )
              ],
            ),
          )
        : Container(
            //padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 4),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: KColor.grey300,
                border: Border.all(
                    color: KColor.textgrey.withOpacity(0.4), width: 1)),

            child: Center(
              child: Text(
                "Add Shipping Address",
                style: TextStyles.bodyText1,
              ),
            ),
          );
  }
}
