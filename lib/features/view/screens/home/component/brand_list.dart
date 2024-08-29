import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/features/view/global_component/shimmer/placeholder_shimmer.dart';
import 'package:ecommerce_app/features/view/screens/all_brand/all_brand_page.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/brand_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/home/model/brand_list_model.dart';
import 'package:ecommerce_app/features/view/screens/home/state/brands_state.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../utils/text_styles/text_styles.dart';

class BrandSection extends StatefulWidget {
  const BrandSection({Key? key}) : super(key: key);

  @override
  State<BrandSection> createState() => _BrandSectionState();
}

class _BrandSectionState extends State<BrandSection> {
  int selectIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final brandState = ref.watch(brandProvider);
      final List<BrandListData> brandListData = brandState is BrandSuccessState
          ? brandState.brandListModel!.data
          : [];
      return Container(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Brands",
                    style: TextStyles.subTitle1,
                  ),
                  GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(
                            SlideRightRoute(page: const AllBrandPage()));
                      },
                      child: Row(
                        children: [
                          Text(
                            "View All",
                            style: TextStyles.bodyText2
                                .copyWith(color: KColor.secondary),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                            color: KColor.secondary,
                          ),
                        ],
                      ))
                ],
              ),
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
                          )
                        ],
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: KSize.getHeight(context, 90),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: brandListData.length,
                        physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.fast),
                        scrollDirection: Axis.horizontal,
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
                                child: Column(
                                  children: [
                                    Center(
                                      child: Image.network(
                                        brandListData[index].image,
                                        fit: BoxFit.contain,
                                        height: KSize.getHeight(context, 60),
                                        width: KSize.getWidth(context, 110),
                                      ),
                                    ),
                                    Text(brandListData[index].name,
                                        style: TextStyles.bodyText1),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ]),
      );
    });
  }
}
