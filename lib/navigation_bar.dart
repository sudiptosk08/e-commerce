// ignore_for_file: unrelated_type_equality_checks, library_private_types_in_public_api

import 'package:ecommerce_app/constant/shared_preference_constant.dart';
import 'package:ecommerce_app/features/view/screens/all_categories/all_categories_page.dart';
import 'package:ecommerce_app/features/view/screens/auth/login/login_page.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/banner_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/brand_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/category_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/my_order/controller/my_order_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/wishlist/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'features/view/screens/cart/cart_page.dart';
import 'features/view/screens/home/home_page.dart';
import 'features/view/screens/profile/profile_page.dart';

class NavigationBarScreen extends StatefulWidget {
  final String page;
  const NavigationBarScreen({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  bool? checkLogin;
  @override
  void initState() {
    currentScreen = widget.page == 2 ? const CartPage() : const HomePage();
    currentTab = widget.page == 2 ? 2 : 0;
    checkLogin = getBoolAsync(isLoggedIn, defaultValue: false);

    super.initState();
  }

  Widget currentScreen = const NavigationBarScreen(
    page: "0",
  );

  int currentTab = 0;
  final List<Widget> screens = [
    const HomePage(),
    const AllCategoryPage(),
    const CartPage(),
    const ProfilePage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          color: KColor.background,
          child: Scaffold(
            body: PageStorage(
              bucket: bucket,
              child: currentScreen,
            ),
            // floatingActionButton: FloatingActionBottom(),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              padding: const EdgeInsets.all(0),
              color: KColor.white,
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = const HomePage();
                            currentTab = 0;
                            // store.state.logoutUserData = null;
                            ref
                                .read(productListProvider.notifier)
                                .fetchShopProductList();

                            ref.read(brandProvider.notifier).fetchBrand();
                            ref
                                .read(sliderProvider.notifier)
                                .fetchSliderDetails();
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image:
                                    const AssetImage("assets/icons/house.png"),
                                width: 20,
                                height: 20,
                                color: currentTab == 0
                                    ? KColor.black
                                    : KColor.gray223),
                            const SizedBox(
                              height: 3,
                            ),
                            currentTab == 0
                                ? const Icon(
                                    Icons.brightness_1,
                                    color: KColor.black,
                                    size: 4,
                                  )
                                : Icon(
                                    Icons.brightness_1,
                                    color: KColor.white,
                                    size: 4,
                                  ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Home",
                              style: TextStyles.bodyText3.copyWith(
                                  color: currentTab == 0
                                      ? KColor.black
                                      : KColor.gray223),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = const AllCategoryPage();
                            currentTab = 1;
                            ref
                                .read(categoryProvider.notifier)
                                .fetchCategoryDetails();
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image:
                                    const AssetImage("assets/icons/menu.png"),
                                width: 20,
                                height: 20,
                                color: currentTab == 1
                                    ? KColor.black
                                    : KColor.gray223),
                            const SizedBox(
                              height: 3,
                            ),
                            currentTab == 1
                                ? const Icon(
                                    Icons.brightness_1,
                                    color: KColor.black,
                                    size: 4,
                                  )
                                : Icon(
                                    Icons.brightness_1,
                                    color: KColor.white,
                                    size: 4,
                                  ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Category",
                              style: TextStyles.bodyText3.copyWith(
                                color: currentTab == 1
                                    ? KColor.black
                                    : KColor.gray223,
                              ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = const CartPage();
                            currentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: const AssetImage("assets/icons/bag.png"),
                                width: 24,
                                height: 22,
                                fit: BoxFit.cover,
                                color: currentTab == 2
                                    ? KColor.black
                                    : KColor.gray223),
                            const SizedBox(
                              height: 3,
                            ),
                            currentTab == 2
                                ? const Icon(
                                    Icons.brightness_1,
                                    color: KColor.black,
                                    size: 4,
                                  )
                                : Icon(
                                    Icons.brightness_1,
                                    color: KColor.white,
                                    size: 4,
                                  ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Cart",
                              style: TextStyles.bodyText3.copyWith(
                                color: currentTab == 2
                                    ? KColor.black
                                    : KColor.gray223,
                              ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = checkLogin!
                                ? const ProfilePage()
                                : const LoginPage();

                            currentTab = 3;
                            ref
                                .read(wishlistProvider.notifier)
                                .fetchWishlistProducts();
                            ref
                                .read(myOrderProvider.notifier)
                                .fetchMyOrders("Pending");
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image:
                                    const AssetImage("assets/icons/avatar.png"),
                                width: 20,
                                height: 20,
                                color: currentTab == 3
                                    ? KColor.black
                                    : KColor.gray223),
                            const SizedBox(
                              height: 3,
                            ),
                            currentTab == 3
                                ? const Icon(
                                    Icons.brightness_1,
                                    color: KColor.black,
                                    size: 4,
                                  )
                                : Icon(
                                    Icons.brightness_1,
                                    color: KColor.white,
                                    size: 4,
                                  ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Account",
                              style: TextStyles.bodyText3.copyWith(
                                color: currentTab == 3
                                    ? KColor.black
                                    : KColor.gray223,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
