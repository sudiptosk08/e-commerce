import 'package:ecommerce_app/features/view/screens/filter/filter_page.dart';
import 'package:ecommerce_app/features/view/screens/shop_store_details/component/shop_categroies_product.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

String _selectedMenu = 'Sort by';

class StoreCategoriesPage extends StatefulWidget {
  const StoreCategoriesPage({super.key});

  @override
  State<StoreCategoriesPage> createState() => _StoreCategoriesPageState();
}

class _StoreCategoriesPageState extends State<StoreCategoriesPage> {
  List categories = [
    "All ",
    "T-Shirt",
    "Pant",
    "TV",
    "SmartPhone",
    "Shoes",
    "Makeup"
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            decoration: const BoxDecoration(
                color: KColor.background,
                border: Border(bottom: BorderSide(color: KColor.background))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Categories",
                    style: TextStyles.subTitle1.copyWith(
                        color: KColor.grey, fontWeight: FontWeight.normal),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(8.0, 2.0, 3.0, 2.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: KColor.grey)),
                      child: PopupMenuButton<String>(
                        child: Row(
                          children: [
                            Text(
                              _selectedMenu,
                              style: TextStyles.bodyText1
                                  .copyWith(color: KColor.grey),
                            ),
                            const Icon(
                              Icons.swap_vert_sharp,
                              size: 18,
                              color: KColor.grey,
                            ),
                          ],
                        ),
                        onSelected: (String item) {
                          setState(() {
                            _selectedMenu = item;
                          });
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: "Low Price",
                            child: Text('Low Price'),
                          ),
                          const PopupMenuItem<String>(
                            value: "High Price",
                            child: Text('High Price'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return KFilter(title: 'asdf',);
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(8.0, 2.0, 3.0, 2.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: KColor.grey)),
                        child: Row(
                          children: [
                            Text(
                              "Filter",
                              style: TextStyles.bodyText1
                                  .copyWith(color: KColor.grey),
                            ),
                            const Icon(
                              Icons.filter_alt_outlined,
                              size: 18,
                              color: KColor.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: KColor.white,
            ),
            child: TabBar(
              indicatorColor: Colors.transparent,
              unselectedLabelColor: KColor.grey,
              labelColor: KColor.black,
              isScrollable: true,
              tabs: [
                ...List.generate(
                  categories.length,
                  (index) => Container(
                    padding: const EdgeInsets.only(
                      right: 4.0,
                      left: 4.0,
                    ),
                    child: Tab(
                      text: categories[index],
                    ),
                  ),
                ),
              ],
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          Expanded(
            flex: 9,
            child: TabBarView(
              children: [
                ...List.generate(
                  categories.length,
                  (index) => ShopCategoriesProduct(
                    OrderStatus: categories[index],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
