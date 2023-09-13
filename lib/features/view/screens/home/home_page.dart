import 'package:ecommerce_app/features/view/global_component/drawer/drawer.dart';
import 'package:ecommerce_app/features/view/screens/all_categories/all_categories_page.dart';
import 'package:ecommerce_app/features/view/screens/home/component/brand_list.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/helper/helper.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/material.dart';
import '../../global_component/text_field_container/k_search_field.dart';
import '../notification/notification_page.dart';
import 'component/categories_list.dart';
import 'component/popular_product.dart';
import 'component/new&noteworthy.dart';
import 'component/slider_iamge.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

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
          preferredSize: const Size.fromHeight(50),
          child: Builder(builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: const Image(
                          image: AssetImage(AppAssets.menus),
                        ),
                        iconSize: 30,
                        color: Colors.black,
                        onPressed: () => Scaffold.of(context).openDrawer()),
                    const Image(
                      image: AssetImage(AppAssets.shopfy),
                      width: 110,
                      height: 120,
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Helper.dissmissKeyboard();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const NotificationPage())));
                  },
                  padding: const EdgeInsets.all(12),
                  icon: const Image(
                    image: AssetImage(AppAssets.notification),
                  ),
                ),
              ],
            );
          }),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: KSize.getWidth(context, 297),
                    child: SearchTextField(
                      callbackFunction: (query) {},
                      controller: controller,
                      readOnly: false,
                      hintText: 'Search here...',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const AllCategoryPage())));
                    },
                    child: Container(
                        width: KSize.getWidth(context, 67),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 14),
                        decoration: BoxDecoration(
                            color: KColor.primary,
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.category_outlined,
                          color: KColor.white,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const CategorySection(),
              const SizedBox(
                height: 15,
              ),
              const ImageSlider(),
              const SizedBox(
                height: 15,
              ),
              const PopularProduct(),
              const SizedBox(
                height: 5,
              ),
              const NewArrivalsProduct(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
