import 'package:ecommerce_app/features/view/screens/product_details/controller/product_details_controller.dart';
import 'package:ecommerce_app/features/view/screens/product_details/state/product_details_state.dart';
import 'package:ecommerce_app/features/view/screens/shop/controller/product_list_controller.dart';
import 'package:ecommerce_app/features/view/screens/wishlist/controller/wishlist_controller.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

      return Scaffold(
        backgroundColor: KColor.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: KAppBar(
            checkTitle: true,
            color: KColor.white,
            title: "Product Details",
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: InkWell(
                  onTap: () {
                    selectWishlist = !selectWishlist;
                    setState(() {
                      ref
                          .read(wishlistProvider.notifier)
                          .addWishlist(id: productDetails!.id.toString());
                    });
                  },
                  child: Icon(
                    selectWishlist == false
                        ? Icons.favorite_border
                        : Icons.favorite,
                    color: selectWishlist == false
                        ? KColor.black
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
                  quantity: 1,
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
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 33.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                  color: KColor.primary,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_checkout_outlined,
                    color: KColor.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Add to cart',
                    style: TextStyles.bodyText1.copyWith(
                        color: KColor.white, fontWeight: FontWeight.w500),
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
