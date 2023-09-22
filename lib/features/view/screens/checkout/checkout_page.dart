import 'dart:convert';
import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/constant/shared_preference_constant.dart';
import 'package:ecommerce_app/features/view/screens/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/features/view/screens/checkout/component/cupon_card.dart';
import 'package:ecommerce_app/features/view/screens/checkout/component/shipping_info_card.dart';
import 'package:ecommerce_app/features/view/screens/checkout/controller/checkout_controller.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/controller/get_shipping_address_controller.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../utils/assets/app_assets.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/size/k_size.dart';
import '../../../../utils/text_styles/text_styles.dart';
import '../../global_component/appBar/app_bar.dart';
import '../../global_component/buttons/Kdrop_down_field.dart';
import '../shipping_address/shipping_address_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  var selectMethod = -1;

  String? city;
  String? address;
  String? addressType;
  String? area;
  String? phone;
  String? region;

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
  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> orderItems = [];

  @override
  void initState() {
    super.initState();
    _loadShippingInfo();
    loadCartItems();
    loadOrderItems();
  }

  Future<void> _loadShippingInfo() async {
    // Your asynchronous code to load shipping information
    // It can include await operations to fetch data

    // For example:
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? addressesJson = prefs.getString('user_addresses');
    if (addressesJson != null) {
      Map<String, dynamic> storedAddresses = json.decode(addressesJson);
      setState(() {
        city = storedAddresses['city'];
        address = storedAddresses['address'];
        addressType = storedAddresses['addressType'];
        area = storedAddresses['area'];
        phone = storedAddresses['phone'];
        region = storedAddresses['region'];
      });
    }
  }

  Future<void> loadCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItemStrings = prefs.getStringList('cartItems') ?? [];
    setState(() {
      cartItems = cartItemStrings.map((itemString) {
        return Map<String, dynamic>.from(json.decode(itemString));
      }).toList();
      print("CartItems$cartItems");
    });
  }

  Future<void> loadOrderItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> orderItemStrings = prefs.getStringList('orderItems') ?? [];
    setState(() {
      orderItems = orderItemStrings.map((itemString) {
        return Map<String, dynamic>.from(json.decode(itemString));
      }).toList();
      print("Order Items$orderItems");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final orderState = ref.watch(orderProvider);
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
                    Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: KColor.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order Info',
                                    style: TextStyles.subTitle
                                        .copyWith(color: KColor.black),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              ListView.builder(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cartItems.length,
                                  itemBuilder: (ctx, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: context.screenWidth * .50,
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              "${cartItems[index]['name']}",
                                              style: TextStyles.bodyText1
                                                  .copyWith(
                                                      color: KColor.black
                                                          .withOpacity(0.6)),
                                            ),
                                          ),
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            '(x${cartItems[index]['quantity']})',
                                            style: TextStyles.bodyText1
                                                .copyWith(
                                                    color: KColor.black
                                                        .withOpacity(0.6)),
                                          ),
                                          Text(
                                            '৳${cartItems[index]['price']}',
                                            style: TextStyles.bodyText1
                                                .copyWith(
                                                    color: KColor.black
                                                        .withOpacity(0.6)),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ])),
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
                                            ref
                                                .read(addressListProvider
                                                    .notifier)
                                                .fetchShppingAddressList();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShippingAddressPage(
                                                          page: 'checkout',
                                                        )));
                                          },
                                          icon: Icon(
                                            Icons.add_business_rounded,
                                            color: KColor.black54,
                                            size: 25,
                                          )),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  ShippingInfoCard()
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                          Text(
                            'Payment Method',
                            style: TextStyles.subTitle
                                .copyWith(color: KColor.black),
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
                                        left: 8,
                                        top: 3.0,
                                        bottom: 3.0,
                                        right: 7),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectMethod = index;
                                        });
                                      },
                                      child: Container(
                                        width: 80,
                                        margin:
                                            const EdgeInsets.only(bottom: 5),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 2),
                                        decoration: BoxDecoration(
                                            color: selectMethod == index
                                                ? KColor.primary
                                                    .withOpacity(0.2)
                                                : Colors.transparent,
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
                                              left:
                                                  KSize.getWidth(context, 3.0)),
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
                              text("SubTotal",
                                  "৳${ref.read(cartProvider.notifier).subTotal}"),
                              const SizedBox(
                                height: 8,
                              ),
                              text("Shipping", "৳100"),
                              const SizedBox(
                                height: 5,
                              ),
                              text("Discount", "0%"),
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
                              text("Total",
                                  "৳${ref.read(cartProvider.notifier).subTotal + 100}"),
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
            onPressedCallback: () {
              ref.read(orderProvider.notifier).orderPlaced(
                  cartItems: orderItems,
                  totalAmount: ref.read(cartProvider.notifier).subTotal + 100,
                  paymentMethoId: selectMethod,
                  deliveryMethodId: "1",
                  firstName: getStringAsync(firstName),
                  lastName: getStringAsync(lastName),
                  discount: "0",
                  region: region.toString(),
                  address: address.toString(),
                  area: area.toString(),
                  phone: phone.toString(),
                  city: city.toString(),
                  email: "sudiptosarker05@gmail.com");
            },
            title:
                orderState is LoadingState ? "Please Wait" : "Place to Order",
          ),
        ),
      );
    });
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
