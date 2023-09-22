import 'package:ecommerce_app/features/view/screens/my_order/controller/my_order_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/wishlist/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/features/view/global_component/buttons/floatingActionButton.dart';
import 'package:ecommerce_app/features/view/screens/my_order/my_order_page.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/view/screens/cart/cart_page.dart';
import 'features/view/screens/home/home_page.dart';
import 'features/view/screens/profile/profile_page.dart';
import 'features/view/screens/wishlist/wishList_page.dart';

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
  @override
  void initState() {
    currentScreen = widget.page == 2 ? CartPage() : HomePage();
    currentTab = widget.page == 2 ? 2 : 0;
    super.initState();
  }

  Widget currentScreen = const NavigationBarScreen(
    page: "0",
  );

  int currentTab = 0;
  final List<Widget> screens = [
    HomePage(),
    const WishListPage(),
    const MyOrderPage(),
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
            floatingActionButton: const FloatingActionBottom(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              color: KColor.background,
              child: Container(
                  height: 55,
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
                            currentScreen = HomePage();
                            currentTab = 0;
                            // store.state.logoutUserData = null;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: const AssetImage(AppAssets.home),
                                width: 30,
                                height: 25,
                                color: currentTab == 0
                                    ? KColor.primary
                                    : KColor.gray223),
                            Text(
                              "Home",
                              style: TextStyles.bodyText3.copyWith(
                                color: currentTab == 0
                                    ? KColor.primary
                                    : KColor.gray223,
                              ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.only(right: 25),
                        onPressed: () {
                          setState(() {
                            currentScreen = const WishListPage();
                            // : Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => token != null
                            //             ? CartScreen()
                            //             : LogInScreen()));
                            currentTab = 1;
                            ref
                                .read(wishlistProvider.notifier)
                                .fetchWishlistProducts();
                            // store.dispatch(LogoutUserAction("WishList"));
                            // store.state.logoutUserData = null;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: const AssetImage(AppAssets.favourite),
                                width: 30,
                                height: 25,
                                color: currentTab == 1
                                    ? KColor.primary
                                    : KColor.gray223),
                            Text(
                              "Wishlist",
                              style: TextStyles.bodyText3.copyWith(
                                color: currentTab == 1
                                    ? KColor.primary
                                    : KColor.gray223,
                              ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.only(left: 25),
                        onPressed: () {
                          setState(() {
                            // Navigator.push(
                            //     context,
                            // MaterialPageRoute(
                            //     builder: (context) => token != null
                            //         ? CartScreen()
                            //         : LogInScreen()));

                            currentScreen = const MyOrderPage();
                            currentTab = 2;
                               ref
                                .read(myOrderProvider.notifier)
                                .fetchMyOrders('Pending');
                            // store.dispatch(LogoutUserAction("CartPage"));
                            // store.state.logoutUserData = null;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: const AssetImage(AppAssets.compare),
                                width: 30,
                                height: 25,
                                color: currentTab == 2
                                    ? KColor.primary
                                    : KColor.gray223),
                            Text(
                              "Orders",
                              style: TextStyles.bodyText3.copyWith(
                                color: currentTab == 2
                                    ? KColor.primary
                                    : KColor.gray223,
                              ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            // token != null
                            currentScreen = const ProfilePage();
                            // : Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //              CartPage()
                            //             ));
                            currentTab = 3;
                            // store.dispatch(LogoutUserAction("ProfileScreen"));
                            // store.state.logoutUserData = null;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: const AssetImage(AppAssets.profile),
                                width: 30,
                                height: 25,
                                color: currentTab == 3
                                    ? KColor.primary
                                    : KColor.gray223),
                            Text(
                              "Account",
                              style: TextStyles.bodyText3.copyWith(
                                color: currentTab == 3
                                    ? KColor.primary
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
