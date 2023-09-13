import 'package:flutter/material.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_styles/text_styles.dart';
import '../../global_component/appBar/app_bar.dart';
import '../../global_component/buttons/Kdrop_down_field.dart';
import '../checkout/checkout_page.dart';
import 'component/add_shipping_address_page.dart';
import 'component/shpping_address_card.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  @override
  Widget build(BuildContext context) {
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
                color: KColor.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AddShippingAddressPage()));
                },
                icon: const Icon(
                  Icons.add_box_outlined,
                  size: 30,
                )),
          ],
        ),
      ),
      backgroundColor: KColor.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.all(12),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (ctx, index) {
              return ShippingAddressCard(
                isChecked: false,
                userName: "Sudipto Sarker",
                address: "Meradiya Bazar",
                city: "Dhaka",
                zone: "Banossree",
                area: "Banossree",
                cancel: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                delete: () {
                  Navigator.pop(context);
                },
                add: () {
                  //if (cartState is! LoadingState) {
                  // ref.read(cartProvider.notifier).addCart(
                  //       product: wishlistData[index].product,
                  //       barCode: "3211",
                  //       quantity: 1,
                  //     );
                  //}
                },
              );
            },
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
          textColor: KColor.black,
          onPressedCallback: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CheckoutPage()));
          },
          title: "Save Address",
        ),
      ),
      //floatingActionButton:
    );
  }
}
