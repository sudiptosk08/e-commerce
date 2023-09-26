// ignore_for_file: file_names, avoid_print

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/global_component/shimmer/placeholder_shimmer.dart';
import 'package:ecommerce_app/features/view/screens/wishlist/controller/wishlist_controller.dart';
import 'package:ecommerce_app/features/view/screens/wishlist/model/wishlist_model.dart';
import 'package:ecommerce_app/features/view/screens/wishlist/state/wishList_state.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../global_component/appBar/app_bar.dart';
import 'component/wishlist_card.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      // final wishlistState = ref.watch(wishlistProvider);
      // final shopScrollState = ref.watch(shopListScrollProvider);
      final wishListState = ref.watch(wishlistProvider);
      final List<Datum> wishListData = wishListState is WishlistSuccessState
          ? wishListState.wishlistModel!.data
          : [];

      return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: KAppBar(
            checkTitle: true,
            title: "WishList",
          ),
        ),
        backgroundColor: KColor.background,
        body: SingleChildScrollView(
          child: wishListState is LoadingState
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ...List.generate(
                              8,
                              (index) => const Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      WishListPlaceholder(
                                        lineType: ContentLineType.threeLines,
                                      ),
                                    ],
                                  )),
                        ]),
                  ))
              : wishListData.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: const BouncingScrollPhysics(
                                decelerationRate: ScrollDecelerationRate.fast),
                            shrinkWrap: true,
                            itemCount: wishListData.length,
                            itemBuilder: (ctx, index) {
                              return WishListCard(
                                img: wishListData[index].product.thumbnail,
                                productId: wishListData[index].product.id,
                                isChecked: true,
                                productName: wishListData[index].product.name,
                                group: wishListData[index].product.brand,
                                price:
                                    wishListData[index].product.price.toInt(),
                                appDiscount: wishListData[index]
                                    .product
                                    .discount
                                    .toInt(),
                                disprice:
                                    wishListData[index].product.discountPrice,
                                cancel: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                                delete: () {
                                  ref
                                      .read(wishlistProvider.notifier)
                                      .deleteWishlist(
                                        id: wishListData[index].id.toString(),
                                      );
                                  print("On Delete Tap");
                                },
                                add: () {},
                              );
                            },
                          )
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 520,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.gift,
                            color: KColor.grey.withOpacity(0.4),
                            size: 35,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "No product available!",
                            style: TextStyles.bodyText2
                                .copyWith(color: KColor.black54),
                          )
                        ],
                      ),
                    ),
        ),
      );
    });
  }
}
