import 'package:ecommerce_app/constant/shared_preference_constant.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/component/add_shipping_address_page.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/shipping_address_page.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../utils/colors/app_colors.dart';

class ShippingInfoCard extends StatefulWidget {
  String? city;
  String? address;
  String? addressType;
  String? area;
  String? phone;
  String? region;
  var addressDetails;
  ShippingInfoCard(
      {required this.city,
      required this.address,
      required this.addressType,
      required this.area,
      required this.phone,
      required this.region,
      required this.addressDetails,
      super.key});

  @override
  State<ShippingInfoCard> createState() => _ShippingInfoCardState();
}

class _ShippingInfoCardState extends State<ShippingInfoCard> {
  Map<String, dynamic>? storedAddresses;

  @override
  Widget build(BuildContext context) {
    return widget.city != null ||
            widget.address != null ||
            widget.addressType != null ||
            widget.area != null ||
            widget.phone != null ||
            widget.region != null
        ? Container(
            //padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 4),
            height: KSize.getHeight(context, 160),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffEDFFF6),
                border: Border.all(color: const Color(0xff9BDBBB), width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 2),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          widget.addressType == "Home"
                              ? Image.asset(
                                  AppAssets.home,
                                  height: 30,
                                )
                              : Image.asset(
                                  AppAssets.office,
                                  height: 30,
                                ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.addressType.toString()}  Address",
                            style: TextStyles.bodyText1
                                .copyWith(color: KColor.primary),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
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
                                  '${widget.phone}',
                                  style: TextStyles.bodyText1
                                      .copyWith(color: KColor.black),
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text('${widget.city} ',
                                  style: TextStyles.bodyText1.copyWith(
                                      color: const Color(0xff677294))),
                              Row(
                                children: [
                                  Text(
                                    '${widget.region} ',
                                    style: TextStyles.bodyText1.copyWith(
                                        color: const Color(0xff677294)),
                                  ),
                                  Text(
                                    '${widget.area} ',
                                    style: TextStyles.bodyText1.copyWith(
                                        color: const Color(0xff677294)),
                                  ),
                                ],
                              ),
                              Text(
                                '${widget.address}',
                                style: TextStyles.bodyText1
                                    .copyWith(color: const Color(0xff677294)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  widget.addressDetails!.isNotEmpty
                                      ? ShippingAddressPage(
                                          page: 'checkout',
                                        )
                                      :  AddShippingAddressPage(
                                           area: "",
                                          city: "",
                                          house: "",
                                          region: "",
                                          selectedValue: 0,
                                      )));
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.edit,
                      size: 20,
                      color: Color(0xff677294),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  Icons.check_circle,
                  size: 25,
                  color: KColor.green,
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => widget.addressDetails!.isNotEmpty
                          ? ShippingAddressPage(
                              page: 'checkout',
                            )
                          : AddShippingAddressPage(
                            area: "",
                            city: "",
                            house: "",
                            region: "",
                            selectedValue: 0,
                          )));
            },
            child: Container(
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
            ),
          );
  }
}
