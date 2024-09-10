import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/global_component/appBar/app_bar.dart';
import 'package:ecommerce_app/features/view/global_component/shimmer/placeholder_shimmer.dart';
import 'package:ecommerce_app/features/view/global_component/text_field_container/k_search_field.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/brand_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/home/model/brand_list_model.dart';
import 'package:ecommerce_app/features/view/screens/home/state/brands_state.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_styles/text_styles.dart';

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
    return Consumer(builder: (context, ref, _) {
      final brandState = ref.watch(brandProvider);
      final List<BrandListData> brandListData = brandState is BrandSuccessState
          ? brandState.brandListModel!.data
          : [];
      return Scaffold(
        backgroundColor: KColor.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(115),
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
        body: Container(
          padding: const EdgeInsets.only(
            left: 13,
            right: 13,
          ),
          width: double.infinity,
          // color: KColor.primary.withOpacity(0.2),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 6,
                ),
                brandState is! BrandSuccessState
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade100,
                              highlightColor: Colors.grey.shade300,
                              child: const CategoryPlaceholder(),
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade100,
                              highlightColor: Colors.grey.shade300,
                              child: const CategoryPlaceholder(),
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade100,
                              highlightColor: Colors.grey.shade300,
                              child: const CategoryPlaceholder(),
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade100,
                              highlightColor: Colors.grey.shade300,
                              child: const CategoryPlaceholder(),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0.0,
                          childAspectRatio: 4.5 / 3,
                        ),
                        itemCount: brandListData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // // setState(() => selectIndex = index);
                              // ref.read(shopProvider.notifier).fetchShopProductList(
                              //     groupId: categoryData[index].id, categoryId: "", str: "");
                              // Navigator.pushNamed(context, '/shop');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: KColor.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.network(
                                  brandListData[index].image,
                                  fit: BoxFit.scaleDown,
                                  height: KSize.getHeight(context, 60),
                                  width: KSize.getWidth(context, 83),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ]),
        ),
      );
    });
  }
}
