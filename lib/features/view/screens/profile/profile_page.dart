import 'package:ecommerce_app/features/view/screens/shipping_address/controller/get_shipping_address_controller.dart';
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
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: KSize.getWidth(context, 70),
                            height: KSize.getHeight(context, 90),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: KColor.black.withOpacity(0.4),
                                ),
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                    image: AssetImage(AppAssets.product1))),
                          ),
                          const Positioned(
                            right: 1,
                            top: 50,
                            child: CircleAvatar(
                                radius: 14,
                                backgroundColor: KColor.black,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                )),
                          ),
                        ],
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
                                color: KColor.black54,
                              ),
                            ),
                            Text(
                              "sudiptosarker05@gmail.com",
                              style: TextStyles.bodyText1.copyWith(
                                color: KColor.black.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      onPressedCallback: () {},
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
