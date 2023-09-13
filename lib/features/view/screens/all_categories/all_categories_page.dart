import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/category_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/home/model/category_list_model.dart';
import 'package:ecommerce_app/features/view/screens/home/state/categories_state.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/view/shop_page.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_styles/text_styles.dart';
import '../../global_component/appBar/app_bar.dart';

class AllCategoryPage extends StatefulWidget {
  const AllCategoryPage({Key? key}) : super(key: key);

  @override
  State<AllCategoryPage> createState() => _AllCategoryPageState();
}

class _AllCategoryPageState extends State<AllCategoryPage> {
  int cateSelectIndex = 0;
  int subCateSelectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final categoryState = ref.watch(categoryProvider);
      final List<CategoryListData> categoryData =
          categoryState is CategorySuccessState
              ? categoryState.categoryModel!.data
              : [];

      return Scaffold(
        backgroundColor: KColor.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: KAppBar(
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  }),
              checkTitle: true,
              title: 'Categories'),
        ),
        body: Row(
          children: [
            Container(
              width: KSize.getWidth(context, 100),
              height: double.infinity,
              color: KColor.white,
              margin: const EdgeInsets.only(left: 12, right: 5),
              child: GridView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, mainAxisExtent: 95),
                itemCount: categoryData.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: cateSelectIndex == index
                                ? KColor.primary.withOpacity(0.3)
                                : KColor.background,
                            width: 2),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          cateSelectIndex = index;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: index == 0
                                ? EdgeInsets.only(top: 12)
                                : EdgeInsets.only(top: 0),
                            width: KSize.getWidth(context, 51),
                            height: KSize.getHeight(context, 55),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: cateSelectIndex == index
                                  ? KColor.primary.withOpacity(0.3)
                                  : KColor.grey300,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: SvgPicture.string(
                                categoryData[index].icon,
                                height: 35,
                                width: 35,
                                color: KColor.black54,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Flexible(
                            child: Text(
                              categoryData[index].name.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyles.bodyText3.copyWith(
                                color: KColor.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: KSize.getWidth(context, 252),
              height: double.infinity,
              color: KColor.white,
              child: GridView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 2.8 / 3,
                ),
                itemCount: categoryData[cateSelectIndex].subcategories!.length,
                itemBuilder: (context, index) {
                  return InkWell(
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
                      NavigationService.navigateTo(
                          FadeRoute(page: const ShopPage()));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 7, left: 7),
                      color: KColor.background,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: KSize.getWidth(context, 55),
                            height: KSize.getHeight(context, 60),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: KColor.grey300,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: SvgPicture.string(
                                categoryData[index].subcategories![index].icon,
                                height: 35,
                                width: 35,
                                color: KColor.black54,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Flexible(
                            child: Text(
                              categoryData[index]
                                  .subcategories![index]
                                  .name
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: TextStyles.bodyText3.copyWith(
                                color: KColor.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
