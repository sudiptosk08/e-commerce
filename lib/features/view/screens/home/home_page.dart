import 'package:ecommerce_app/features/view/global_component/drawer/drawer.dart';
import 'package:ecommerce_app/features/view/screens/home/component/brand_list.dart';
import 'package:ecommerce_app/features/view/screens/home/component/grocery_item.dart';
import 'package:ecommerce_app/features/view/screens/home/component/new_arival.dart';
import 'package:ecommerce_app/features/view/screens/home/component/skinCare.dart';
import 'package:ecommerce_app/features/view/screens/notification/controller/notification_controller.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/helper/helper.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../global_component/text_field_container/k_search_field.dart';
import '../notification/notification_page.dart';
import 'component/all_product.dart';
import 'component/slider_iamge.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: KColor.background,
        drawer: const SizedBox(child: KDrawer()),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Builder(builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: SvgPicture.asset(AppAssets.menus),
                        iconSize: 30,
                        color: KColor.primary,
                        onPressed: () => Scaffold.of(context).openDrawer()),
                    Container(
                      width: KSize.getWidth(context, 275),
                      height: KSize.getHeight(context, 50),
                      alignment: Alignment.center,
                      child: SearchTextField(
                        callbackFunction: (query) {},
                        controller: controller,
                        readOnly: false,
                        hintText: 'Search here...',
                      ),
                    ),
                  ],
                ),
                Consumer(
                  builder: (context, ref, child) => Stack(children: [
                    IconButton(
                      onPressed: () {
                        Helper.dissmissKeyboard();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const NotificationPage())));
                        ref
                            .read(notificationListProvider.notifier)
                            .fetchNotificationList();
                      },
                      padding: const EdgeInsets.all(12),
                      icon: SvgPicture.asset(AppAssets.notification),
                    ),
                    Positioned(
                      right: 11,
                      top: 6,
                      child: CircleAvatar(
                        backgroundColor: KColor.red,
                        maxRadius: 7,
                        child: Text(
                          '01',
                          style: TextStyles.bodyText3
                              .copyWith(color: KColor.white),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            );
          }),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //       width: KSize.getWidth(context, 297),
              //       child: SearchTextField(
              //         callbackFunction: (query) {},
              //         controller: controller,
              //         readOnly: false,
              //         hintText: 'Search here...',
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: ((context) => const AllCategoryPage())));
              //       },
              //       child: Container(
              //           width: KSize.getWidth(context, 67),
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 20.0, vertical: 14),
              //           decoration: BoxDecoration(
              //               color: KColor.primary,
              //               borderRadius: BorderRadius.circular(8)),
              //           child: Icon(
              //             Icons.category_outlined,
              //             color: KColor.white,
              //           )),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // CategorySection(),
              SizedBox(
                height: 12,
              ),
              ImageSlider(),
              SizedBox(
                height: 15,
              ),
              AllProduct(),
              BrandSection(),
              SizedBox(
                height: 8,
              ),
              NewArrival(),
              GroceryItem(),
              SkinCare(),

              SizedBox(
                height: 5,
              ),
              // NewArrivalsProduct(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
