import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/global_component/text_field_container/k_search_field.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/category_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/home/model/category_list_model.dart';
import 'package:ecommerce_app/features/view/screens/home/state/categories_state.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/view/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_styles/text_styles.dart';
import '../../global_component/appBar/app_bar.dart';

class AllBrandPage extends StatefulWidget {
  const AllBrandPage({Key? key}) : super(key: key);

  @override
  State<AllBrandPage> createState() => _AllBrandPageState();
}

class _AllBrandPageState extends State<AllBrandPage> {
  int cateSelectIndex = 0;
  int subCateSelectIndex = 0;
  TextEditingController controller = TextEditingController();
  List<dynamic> brandList = [
    {
      'image': "assets/product/agora.png",
      'name': "Agora",
    },
    {
      'image': "assets/product/grocery.png",
      'name': "Unilever",
    },
    {
      'image': "assets/product/brand.png",
      'name': "Jamuna",
    },
    {
      'image': "assets/product/agora.png",
      'name': "Agora",
    },
  ];
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
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              KAppBar(
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      }),
                  checkTitle: true,
                  title: 'Brands'),
              SearchTextField(
                callbackFunction: (query) {},
                controller: controller,
                readOnly: false,
                hintText: 'Search here...',
              ),
            ],
          ),
        ),
        body: GridView.builder(
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 0.0,
            childAspectRatio: 2 / 3,
          ),
          itemCount: brandList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  subCateSelectIndex = index;
                  ref.read(productListProvider.notifier).fetchShopProductList(
                      subCategoryID:
                          categoryData[index].subcategories![index].id);
                });
                NavigationService.navigateTo(FadeRoute(
                    page: ShopPage(
                  index: "",
                  title: brandList[index]['name'].toString(),
                )));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 7, left: 13, right: 13),
                color: KColor.background,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: KColor.white,
                      child: Padding(
                        padding: const EdgeInsets.all(11),
                        child: Image.asset(
                          brandList[index]['image'],
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Flexible(
                      child: Text(
                        brandList[index]['name'].toString(),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyles.bodyText2
                            .copyWith(color: KColor.black, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
