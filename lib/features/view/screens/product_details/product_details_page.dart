import 'package:ecommerce_app/features/view/screens/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/features/view/screens/product_details/component/related_product_card.dart';
import 'package:ecommerce_app/features/view/screens/product_details/controller/product_details_controller.dart';
import 'package:ecommerce_app/features/view/screens/product_details/state/product_details_state.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/wishlist/controller/wishlist_controller.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../global_component/appBar/app_bar.dart';
import 'component/product_info.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // List<String> items = ["Variations", "Descriptions", "Reviews"];
  int currentIndex = 0;
  int quantity = 1;
  var selectWishlist = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      // final wishlistState = ref.watch(wishlistProvider);
      final productDetailsState = ref.watch(productDetailsProvider);
      final productDetails = productDetailsState is ProductDetailsSuccessState
          ? productDetailsState.productDetailsModel!.data
          : null;
      selectWishlist = productDetails != null ? productDetails.wishlist : false;
      return Scaffold(
        backgroundColor: KColor.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: KAppBar(
            checkTitle: true,
            color: KColor.background,
            title: "Product Details",
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(productDetailsProvider.notifier).size = "";
                  ref.read(productDetailsProvider.notifier).color = "";

                  ref.read(productDetailsProvider.notifier).totalPrice = 0;
                  ref
                      .read(productDetailsProvider.notifier)
                      .sizeAdditionalPrice = 0;
                  ref
                      .read(productDetailsProvider.notifier)
                      .colorAdditionalPrice = 0;
                  ref
                      .read(productDetailsProvider.notifier)
                      .typeAdditionalPrice = 0;
                  ref.read(productDetailsProvider.notifier).attributeList = [];
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: KColor.textgrey,
                )),
            actions: [
              Container(
                padding: const EdgeInsets.all(7),
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    color: KColor.containerColor, shape: BoxShape.circle),
                child: InkWell(
                  onTap: () {
                    selectWishlist = true;
                    setState(() {
                      ref
                          .read(wishlistProvider.notifier)
                          .addWishlist(id: productDetails!.id.toString());
                      ref
                          .read(productListProvider.notifier)
                          .fetchShopProductList();
                    });
                  },
                  child: Icon(
                    selectWishlist == false
                        ? Icons.favorite_border
                        : Icons.favorite,
                    color: selectWishlist == false
                        ? KColor.textgrey
                        : KColor.errorRedText,
                    size: 25,
                  ),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Column(
              children: [
                ProductInfo(
                  quantity: quantity,
                  add: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  remove: () {
                    setState(() {
                      quantity--;
                      if (quantity < 0) {
                        quantity = 0;
                      }
                    });
                  },
                ),
                const RelatedProduct(),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              if (ref.read(productDetailsProvider.notifier).size == "") {
                toast("Select a size", bgColor: KColor.errorRedText);
              } else if (ref.read(productDetailsProvider.notifier).color ==
                  "") {
                toast("Select a color", bgColor: KColor.errorRedText);
              } else {
                ref.read(cartProvider.notifier).addToCart(
                      productDetails!.id.toString(),
                      quantity,
                      productDetails.name.toString(),
                      productDetails.category.name.toString(),
                      productDetails.subcategory.name.toString(),
                      ref.read(productDetailsProvider.notifier).size,
                      ref.read(productDetailsProvider.notifier).color,
                      ref
                          .read(productDetailsProvider.notifier)
                          .totalPrice
                          .toString(),
                      productDetails.brand.toString(),
                      productDetails.thumbnail.toString(),
                      ref
                          .read(productDetailsProvider.notifier)
                          .sizeId
                          .toString(),
                      ref
                          .read(productDetailsProvider.notifier)
                          .colorId
                          .toString(),
                    );
                ref.read(cartProvider.notifier).minusQuantity = false;
                ref.read(cartProvider.notifier).addQuantity = true;
                ref.read(productDetailsProvider.notifier).size = "";
                ref.read(productDetailsProvider.notifier).color = "";

                ref.read(productDetailsProvider.notifier).totalPrice = 0;
                ref.read(productDetailsProvider.notifier).sizeAdditionalPrice =
                    0;
                ref.read(productDetailsProvider.notifier).colorAdditionalPrice =
                    0;
                ref.read(productDetailsProvider.notifier).typeAdditionalPrice =
                    0;
                ref.read(productDetailsProvider.notifier).attributeList = [];
              }
            },
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                  color: KColor.primary,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_checkout_outlined,
                      color: KColor.white),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Add to cart',
                    style: TextStyles.bodyText1.copyWith(
                      color: KColor.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
