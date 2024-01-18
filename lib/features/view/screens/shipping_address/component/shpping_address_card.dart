// ignore_for_file: must_be_immutable

import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/dialog/k_confirm_dialog.dart';

class ShippingAddressCard extends StatefulWidget {
  bool isChecked;
  final String? addressType;
  final String? userName;
  final String? phone;
  final String? address;
  final String? city;
  final String? zone;
  final String? area;
  final VoidCallback? cancel;
  final VoidCallback? delete;

  final VoidCallback? onSelect;
  final VoidCallback? onTap;

  ShippingAddressCard({
    this.isChecked = false,
    this.userName,
    this.addressType,
    this.phone,
    this.address,
    this.city,
    this.zone,
    this.area,
    this.cancel,
    this.delete,
    this.onSelect,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<ShippingAddressCard> createState() => _ShippingAddressCardState();
}

class _ShippingAddressCardState extends State<ShippingAddressCard> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      dragStartBehavior: DragStartBehavior.start,
      movementDuration: const Duration(milliseconds: 200),
      resizeDuration: const Duration(milliseconds: 1000),
      onDismissed: (direction) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return KConfirmDialog(
              message: 'Delete product',
              subMessage: 'Are you sure you want to delete this product?',
              onCancel: widget.cancel,
              onDelete: widget.delete,
            );
          },
        );
      },
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: const BoxDecoration(
          color: KColor.primary,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Icon(Icons.delete)],
        ),
      ),
      child: Container(
        //padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 6),
        height: KSize.getHeight(context, 170),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffEDFFF6),
            border: Border.all(color: const Color(0xff9BDBBB), width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            '${widget.userName}',
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
                        Text(
                          '${widget.address}',
                          style: TextStyles.bodyText1
                              .copyWith(color: const Color(0xff677294)),
                        ),
                        Text(
                          '${widget.area}',
                          style: TextStyles.bodyText1
                              .copyWith(color: const Color(0xff677294)),
                        ),
                        Row(
                          children: [
                            Text('${widget.city}, ',
                                style: TextStyles.bodyText1
                                    .copyWith(color: const Color(0xff677294))),
                            Text(
                              '${widget.zone} ',
                              style: TextStyles.bodyText1
                                  .copyWith(color: const Color(0xff677294)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: widget.onTap,
                  icon: const FaIcon(
                    FontAwesomeIcons.edit,
                    size: 20,
                    color: Color(0xff677294),
                  ),
                ),
                SizedBox(
                  height: KSize.getHeight(context, 32),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      widget.onSelect
                          ?.call(); // Notify the parent widget when selected
                    });
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          widget.isChecked ? KColor.green : KColor.transparent,
                      // borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: const Color(0xff677294), width: 1),
                    ),
                    child: widget.isChecked
                        ? Padding(
                            padding: const EdgeInsets.all(2),
                            child: Image.asset(AppAssets.check),
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// Container(
//             //padding: const EdgeInsets.all(8),
//             margin: const EdgeInsets.only(bottom: 4),
//             height: KSize.getHeight(context, 170),
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: const Color(0xffEDFFF6),
//                 border: Border.all(color: const Color(0xff9BDBBB), width: 1)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(width: 2),
//                 Flexible(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           widget.addressType == "Home"
//                               ? Image.asset(
//                                   AppAssets.home,
//                                   height: 35,
//                                 )
//                               : Image.asset(
//                                   AppAssets.home,
//                                   height: 35,
//                                 ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             "${widget.addressType.toString()}  Address",
//                             style: TextStyles.bodyText1
//                                 .copyWith(color: KColor.primary),
//                           ),
//                         ],
//                       ),
//                       Flexible(
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 4.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Flexible(
//                                 child: Text(
//                                   "${getStringAsync(firstName)} ${getStringAsync(lastName)}",
//                                   style: TextStyles.bodyText1
//                                       .copyWith(color: KColor.black),
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Flexible(
//                                 child: Text(
//                                   '${widget.phone}',
//                                   style: TextStyles.bodyText1
//                                       .copyWith(color: KColor.black),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 7,
//                               ),
//                               Text('${widget.city} ',
//                                   style: TextStyles.bodyText1.copyWith(
//                                       color: const Color(0xff677294))),
//                               Row(
//                                 children: [
//                                   Text(
//                                     '${widget.region} ',
//                                     style: TextStyles.bodyText1.copyWith(
//                                         color: const Color(0xff677294)),
//                                   ),
//                                   Text(
//                                     '${widget.area} ',
//                                     style: TextStyles.bodyText1.copyWith(
//                                         color: const Color(0xff677294)),
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 '${widget.address}',
//                                 style: TextStyles.bodyText1
//                                     .copyWith(color: const Color(0xff677294)),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 2.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => widget.addressDetails!.isNotEmpty
//                                   ? ShippingAddressPage(
//                                       page: 'checkout',
//                                     )
//                                   : const AddShippingAddressPage()));
//                     },
//                     child: const FaIcon(
//                       FontAwesomeIcons.edit,
//                       size: 20,
//                       color: Color(0xff677294),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 const Icon(
//                   Icons.check_circle,
//                   size: 25,
//                   color: KColor.green,
//                 ),
//               ],
//             ),
//           )