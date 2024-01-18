import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/screens/notification/notification_page.dart';
import 'package:ecommerce_app/features/view/screens/shop/view/shop_page.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_styles/text_styles.dart';

class KDrawer extends ConsumerWidget {
  const KDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        color: KColor.background,
        width: context.screenWidth * 0.75,
        height: context.screenHeight * 1,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: KColor.primary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopify,
                          size: 90,
                          color: KColor.white,
                        ),
                        Text(
                          'E-commerce',
                          style: TextStyles.headline1
                              .copyWith(color: KColor.white),
                        ),
                      ],
                    ),
                  ),
                  drawerItem(() => Navigator.pop(context), Icons.home, "Home"),
                  drawerItem(
                      () => NavigationService.navigateTo(SlideLeftRoute(
                              page: ShopPage(
                            index: "",
                            title: "All Product",
                          ))),
                      Icons.shop,
                      "Shop"),
                  drawerItem(
                      () => NavigationService.navigateTo(
                          SlideLeftRoute(page: const NotificationPage())),
                      Icons.notification_important_rounded,
                      "Notifications"),
                  drawerItem(() => Navigator.pushNamed(context, '/contact'),
                      Icons.contact_page, "Contact Us"),
                  drawerItem(() => Navigator.pushNamed(context, '/about'),
                      Icons.error_rounded, "About Us"),
                  drawerItem(() => Navigator.pushNamed(context, '/about'),
                      Icons.rule_folder_sharp, "Terms & Condition"),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Divider(
                        color: KColor.black54.withOpacity(0.2), thickness: 1),
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        launchUrl(Uri(scheme: 'tel', path: '+8801998685230'));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SvgPicture.asset('assets/images/phoneIcon.svg'),
                          const SizedBox(width: 10),
                          Text(
                            '01824-580966',
                            style: TextStyles.subTitle1
                                .copyWith(color: KColor.black),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        launchUrl(
                            Uri(scheme: 'mailto', path: 'ecommerce@gmail.com'));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SvgPicture.asset('assets/images/emailIcon.svg'),
                          const SizedBox(width: 10),
                          Text(
                            'www.spinnertech.online',
                            style: TextStyles.subTitle1.copyWith(
                              fontSize: 14,
                              color: KColor.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            launchUrlString(
                                'https://www.facebook.com/finesselifestyleofficial');
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.facebook,
                            color: KColor.facebookLogoColor,
                            size: 35,
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            launchUrlString(
                                'https://www.instagram.com/finesse_lifestyle_bd/');
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.instagram,
                            color: KColor.redDamask,
                            size: 35,
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            launchUrlString(
                                'https://www.instagram.com/finesse_lifestyle_bd/');
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.twitter,
                            color: KColor.twitterLogoColor,
                            size: 35,
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            launchUrlString(
                                'https://www.youtube.com/channel/UCSUcQ8_MuhFzNh4E5BlTR-g');
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.youtube,
                            color: KColor.red,
                            size: 35,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerItem(VoidCallback onTap, IconData icon, String text) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              icon,
              color: KColor.black,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: TextStyles.bodyText1.copyWith(
                color: KColor.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
