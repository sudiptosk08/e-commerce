import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/screens/auth/login/controller/login_controller.dart';
import 'package:ecommerce_app/features/view/screens/coupon/coupon_page.dart';
import 'package:ecommerce_app/features/view/screens/my_order/my_order_page.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/controller/get_shipping_address_controller.dart';
import 'package:ecommerce_app/features/view/screens/update_profile/update_profile.dart';
import 'package:ecommerce_app/features/view/screens/wishlist/wishList_page.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/size/k_size.dart';
import '../../../../utils/text_styles/text_styles.dart';
import '../../global_component/buttons/Kdrop_down_field.dart';
import '../../global_component/profile_card/profile_card.dart';
import '../report_issue/add_report_page.dart';
import '../shipping_address/shipping_address_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<dynamic> item = [
    {'icon': Icons.favorite_border_sharp, 'text': "WishList"},
    {'icon': Icons.list_alt_outlined, 'text': "My Order"},
    {'icon': Icons.person_2_outlined, 'text': "Profile"},
    {'icon': Icons.percent_rounded, 'text': "Cupon"}
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          backgroundColor: KColor.background,
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: KSize.getWidth(context, 90),
                        height: KSize.getHeight(context, 100),
                        decoration: BoxDecoration(
                            color: KColor.white,
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                                image: AssetImage(AppAssets.product1))),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sudipto Sarker",
                              style: TextStyles.headline5.copyWith(
                                color: KColor.black,
                              ),
                            ),
                            Text(
                              "sudiptosarker05@gmail.com",
                              style: TextStyles.bodyText1.copyWith(
                                color: KColor.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(
                            item.length,
                            (index) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      index == 0
                                          ? NavigationService.navigateTo(
                                              SizeRoute(
                                                  page: const WishListPage()))
                                          : index == 1
                                              ? NavigationService.navigateTo(
                                                  SizeRoute(
                                                      page:
                                                          const MyOrderPage()))
                                              : index == 2
                                                  ? NavigationService
                                                      .navigateTo(SizeRoute(
                                                          page:
                                                              const UpdateProfile()))
                                                  : NavigationService
                                                      .navigateTo(SizeRoute(
                                                          page:
                                                              const CouponPage()));
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: KColor.white,
                                        child: Icon(
                                          item[index]['icon'],
                                          color: KColor.primary,
                                          size: 19,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        item[index]['text'],
                                        style: TextStyles.subTitle1.copyWith(
                                            color: KColor.textgrey,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ))
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ProfileCard(
                          title: 'Shipping Address',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ShippingAddressPage(page: '')));
                            ref
                                .read(addressListProvider.notifier)
                                .fetchShppingAddressList();
                          },
                        ),
                        ProfileCard(
                          title: 'Report Issue',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ReportIssue()));
                          },
                        ),
                        ProfileCard(
                          title: 'Settings',
                          onPressed: () {},
                        ),
                        ProfileCard(
                          title: 'About Us',
                          onPressed: () {},
                        ),
                        ProfileCard(
                          title: 'Contact Us',
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    KButton(
                      height: 40,
                      isOutlineButton: false,
                      radius: 8,
                      color: KColor.primary,
                      textStyle: TextStyles.bodyText1.copyWith(
                          color: KColor.white, fontWeight: FontWeight.w500),
                      onPressedCallback: () {
                        ref.read(loginProvider.notifier).logout();
                      },
                      title: "Log Out",
                      trailingTitleIcon: Icon(
                        Icons.logout,
                        color: KColor.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
