import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/global_component/shimmer/placeholder_shimmer.dart';
import 'package:ecommerce_app/features/view/global_component/text_field_container/k_search_field.dart';
import 'package:ecommerce_app/features/view/screens/all_categories/controller/category_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/all_categories/model/category_list_model.dart';
import 'package:ecommerce_app/features/view/screens/all_categories/state/categories_state.dart';
import 'package:ecommerce_app/features/view/screens/home/state/categories_state.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/view/shop_page.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/appBar/app_bar.dart';

class AllCategoryPage extends StatefulWidget {
  const AllCategoryPage({Key? key}) : super(key: key);

  @override
  State<AllCategoryPage> createState() => _AllCategoryPageState();
}

class _AllCategoryPageState extends State<AllCategoryPage> {
  int cateSelectIndex = 0;
  int subCateSelectIndex = 0;
  TextEditingController controller = TextEditingController();
  // List<dynamic> categoryData = [
  //   {'name': "Fashion", 'image': "assets/category/category1.png"},
  //   {'name': "Medicine", 'image': "assets/category/category2.png"},
  //   {'name': "Furniture", 'image': "assets/category/category3.png"},
  //   {'name': "Home & Appliance", 'image': "assets/category/category4.png"},
  //   {'name': "Sports & Outdoors", 'image': "assets/category/category5.png"},
  //   {'name': "Toys & Games", 'image': "assets/category/category6.png"},
  //   {'name': "Bag & Travels", 'image': "assets/category/category7.png"},
  //   {'name': "Groceries", 'image': "assets/category/category8.png"},
  //   {'name': "Stationery", 'image': "assets/category/category9.png"},
  //   {'name': "Beauty", 'image': "assets/category/category10.png"},
  // ];
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final categoryState = ref.watch(categorylistProvider);
      final List<CategroyListData> categoryData =
          categoryState is CategoryListSuccessState
              ? categoryState.categoryListModle!.data
              : [];

      return Scaffold(
        backgroundColor: KColor.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              const KAppBar(checkTitle: true, title: 'Categories'),
              SearchTextField(
                callbackFunction: (query) {},
                controller: controller,
                readOnly: false,
                hintText: 'Search here...',
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView.builder(
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0.0,
              childAspectRatio: 2 / 3,
            ),
            itemCount: categoryData.length,
            itemBuilder: (context, index) {
              return categoryState is! CategoryListSuccessState
                  ? Column(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade100,
                          highlightColor: Colors.grey.shade300,
                          child: const CategoryPlaceholder(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade100,
                          highlightColor: Colors.grey.shade300,
                          child: TitlePlaceholder(
                            width: KSize.getWidth(context, 120),
                          ),
                        ),
                      ],
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          subCateSelectIndex = index;
                          ref
                              .read(productListProvider.notifier)
                              .fetchShopProductList(
                                  subCategoryID: categoryData[index]
                                      .subcategories![index]
                                      .id);
                        });
                        NavigationService.navigateTo(FadeRoute(
                            page: ShopPage(
                          index: "",
                          title: categoryData[index].name.toString(),
                        )));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: KSize.getHeight(context, 85),
                            width: KSize.getWidth(context, 80),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: KColor.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(7))),
                            child: Image.network(
                              categoryData[index].image.toString(),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Flexible(
                            child: Text(
                              categoryData[index].name.toString(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyles.bodyText2
                                  .copyWith(color: KColor.black, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      );
    });
  }
}
