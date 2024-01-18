// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/global_component/product_card.dart/product_card_shimmer/product_card_shimmer.dart';
import 'package:ecommerce_app/features/view/screens/filter/filter_page.dart';
import 'package:ecommerce_app/features/view/screens/home/controller/category_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/home/model/category_list_model.dart';
import 'package:ecommerce_app/features/view/screens/home/state/categories_state.dart';
import 'package:ecommerce_app/features/view/screens/notification/controller/notification_controller.dart';
import 'package:ecommerce_app/features/view/screens/notification/notification_page.dart';
import 'package:ecommerce_app/features/view/screens/product_details/controller/product_details_controller.dart';
import 'package:ecommerce_app/features/view/screens/product_details/product_details_page.dart';
import 'package:ecommerce_app/features/view/screens/product_details/state/pagination_scroll_state.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/all_product_pagination_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/model/product_list_model.dart';
import 'package:ecommerce_app/features/view/screens/shop/state/product_list_state.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/helper/helper.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/product_card.dart/product_card.dart';
import '../../../global_component/text_field_container/k_search_field.dart';

class ShopPage extends StatefulWidget {
  dynamic index;
  String title;
  ShopPage({Key? key, required this.index, required this.title})
      : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  TextEditingController controller = TextEditingController();
  int pageNum = 1;
  bool isPageLoading = false;
  String query = "";
  var _selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final shopScrollState = ref.watch(allProductScrollProvider);
        final shopState = ref.watch(productListProvider);
        final List<ProductListData> productListData =
            shopState is ProductListSuccessState
                ? shopState.productListModel!.data
                : [];
        final categoryState = ref.watch(categoryProvider);
        final List<CategoryListData> categoryData =
            categoryState is CategorySuccessState
                ? categoryState.categoryModel!.data
                : [];

        return Scaffold(
          backgroundColor: KColor.background,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(52),
            child: SafeArea(
              child: Builder(builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                            ),
                            iconSize: 25,
                            color: KColor.black,
                            onPressed: () => Navigator.pop(context)),
                        Container(
                          width: KSize.getWidth(context, 275),
                          height: KSize.getHeight(context, 50),
                          margin: const EdgeInsets.only(top: 0),
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
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        widget.title,
                        style: TextStyles.subTitle1,
                      ),
                    ),
                    Row(
                      children: [
                        Builder(
                          // Wrap GestureDetector with Builder widget
                          builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: KColor.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.tune_outlined,
                                  size: 18,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: KColor.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: PopupMenuButton<String>(
                            position: PopupMenuPosition.under,
                            padding: const EdgeInsets.only(top: 15),
                            child: const Icon(
                              Icons.sort,
                              size: 18,
                            ),
                            onSelected: (String item) {
                              setState(() {
                                _selectedMenu = item;
                                ref
                                    .read(productListProvider.notifier)
                                    .fetchShopProductList(
                                        orderByPrice: _selectedMenu);
                              });
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: "0",
                                child: Text('Price : Low To High'),
                              ),
                              const PopupMenuItem<String>(
                                value: "1",
                                child: Text('Price : High To Low'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        )
                      ],
                    )
                  ],
                ),
                widget.index == ""
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: categoryData[widget.index]
                                .subcategories!
                                .length,
                            physics: const BouncingScrollPhysics(
                                decelerationRate: ScrollDecelerationRate.fast),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  ref
                                      .read(productListProvider.notifier)
                                      .fetchShopProductList(
                                        subCategoryID:
                                            categoryData[widget.index]
                                                .subcategories![index]
                                                .id,
                                      );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: KColor.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                bottom: 5,
                                                top: 5),
                                            child: SvgPicture.string(
                                              categoryData[widget.index]
                                                  .subcategories![index]
                                                  .icon,
                                              height: 30,
                                              width: 30,
                                              color: KColor.black54,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 1,
                                        ),
                                        Text(
                                            categoryData[widget.index]
                                                .subcategories![index]
                                                .name,
                                            style: TextStyles.bodyText3
                                                .copyWith(
                                                    color: KColor.black54)),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                const SizedBox(height: 5),
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      if (shopState is LoadingState) ...[
                        const Expanded(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: ProductCardShimmer()),
                        ),
                      ],
                      if (shopState is ProductListSuccessState) ...[
                        Expanded(
                          child: productListData.isEmpty
                              ? Container(
                                  height: 520,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'No products found!',
                                    textAlign: TextAlign.center,
                                    style: TextStyles.bodyText1
                                        .copyWith(color: KColor.black54),
                                  ))
                              : GridView.builder(
                                  padding: const EdgeInsets.all(8),
                                  physics: const ScrollPhysics(),
                                  controller: ref
                                      .read(allProductScrollProvider.notifier)
                                      .controller,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0,
                                    childAspectRatio: 8.9 / 10,
                                  ),
                                  itemCount: productListData.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return ProductCard(
                                      id: productListData[index].id.toString(),
                                      type: "Shop",
                                      imagePath: "assets/product/product3.png",
                                      productName: productListData[index].name,
                                      discountPrice: productListData[index]
                                          .discountPrice
                                          .toString(),
                                      price: productListData[index].price,
                                      appDiscount: productListData[index]
                                          .discount
                                          .toInt(),
                                      ratingStar:
                                          productListData[index].rating.toInt(),
                                      category: productListData[index]
                                          .category
                                          .slug
                                          .toString(),
                                      wishList: productListData[index].wishlist,
                                      tap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProductDetailsPage(),
                                            ));
                                        ref
                                            .read(
                                                productDetailsProvider.notifier)
                                            .fetchProductsDetails(
                                                productListData[index].slug);
                                      },
                                    );
                                  },
                                ),
                        ),
                        if (shopScrollState is ScrollReachedBottomState)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Loading ... ",
                                style: TextStyles.bodyText3
                                    .copyWith(color: KColor.grey),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const CircularProgressIndicator(
                                color: KColor.grey,
                              )
                            ],
                          ),
                      ],
                    ]))
              ],
            ),
          ),
          endDrawer: SizedBox(
            child: KFilter(
              title: widget.title,
            ),
          ),
        );
      },
    );
  }
}
