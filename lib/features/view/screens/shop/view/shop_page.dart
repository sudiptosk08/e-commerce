import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/global_component/product_card.dart/product_card_shimmer/product_card_shimmer.dart';
import 'package:ecommerce_app/features/view/screens/filter/filter_page.dart';
import 'package:ecommerce_app/features/view/screens/product_details/controller/product_details_controller.dart';
import 'package:ecommerce_app/features/view/screens/product_details/product_details_page.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/shop/model/product_list_model.dart';
import 'package:ecommerce_app/features/view/screens/shop/state/product_list_state.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/appBar/app_bar.dart';
import '../../../global_component/product_card.dart/product_card.dart';
import '../../../global_component/text_field_container/k_search_field.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

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
        // final wishlistState = ref.watch(wishlistProvider);
        // final shopScrollState = ref.watch(shopListScrollProvider);
        final shopState = ref.watch(productListProvider);
        final List<ProductListData> productListData =
            shopState is ProductListSuccessState
                ? shopState.productListModel!.data
                : [];

        return Scaffold(
          backgroundColor: KColor.background,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: KAppBar(
              checkTitle: true,
              title: 'Shop',
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              actions: [
                Container(
                  padding: const EdgeInsets.fromLTRB(8.0, 2.0, 3.0, 2.0),
                  child: PopupMenuButton<String>(
                    child: const Icon(
                      Icons.sort,
                    ),
                    onSelected: (String item) {
                      setState(() {
                        _selectedMenu = item;
                        ref
                            .read(productListProvider.notifier)
                            .fetchShopProductList(orderByPrice: _selectedMenu);
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: "0",
                        child: Text('Low Price'),
                      ),
                      const PopupMenuItem<String>(
                        value: "1",
                        child: Text('High Price'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
              ],
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: KSize.getWidth(context, 290),
                      child: SearchTextField(
                        callbackFunction: (query) => ref
                            .read(productListProvider.notifier)
                            .fetchShopProductList(
                              str: query,
                            ),
                        controller: controller,
                        readOnly: false,
                        hintText: 'Search here...',
                      ),
                    ),
                    const SizedBox(width: 4),
                    Builder(
                      // Wrap GestureDetector with Builder widget
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Container(
                            width: KSize.getWidth(context, 67),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 14),
                            decoration: BoxDecoration(
                              color: KColor.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.tune_outlined),
                          ),
                        );
                      },
                    ),
                  ],
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
                          child: SingleChildScrollView(
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
                                    padding: const EdgeInsets.all(6),
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 3.0,
                                      mainAxisSpacing: 2.0,
                                      childAspectRatio: 7.5 / 10,
                                    ),
                                    itemCount: productListData.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return ProductCard(
                                        id: productListData[index]
                                            .id
                                            .toString(),
                                        imagePath: productListData[index]
                                            .thumbnail
                                            .toString(),
                                        productName:
                                            productListData[index].name,
                                        discountPrice: productListData[index]
                                            .discountPrice
                                            .toString(),
                                        price: productListData[index].price,
                                        appDiscount: productListData[index]
                                            .discount
                                            .toInt(),
                                        ratingStar: productListData[index]
                                            .rating
                                            .toInt(),
                                        category: productListData[index]
                                            .category
                                            .slug
                                            .toString(),
                                        wishList:
                                            productListData[index].wishlist,
                                        tap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProductDetailsPage(),
                                              ));
                                          ref
                                              .read(productDetailsProvider
                                                  .notifier)
                                              .fetchProductsDetails(
                                                  productListData[index].slug);
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ]))
              ],
            ),
          ),
          endDrawer: const SizedBox(
            child: KFilter(),
          ),
        );
      },
    );
  }

  _categoryHeader(title, tap) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyles.subTitle,
            ),
            InkWell(
              onTap: tap,
              child: Text(
                'Reset',
                style: TextStyles.bodyText3.copyWith(
                  color: KColor.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
