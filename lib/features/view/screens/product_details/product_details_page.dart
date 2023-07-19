import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import '../../global_component/appBar/app_bar.dart';
import 'component/product_info.dart';

class ProductDetailsPage extends StatefulWidget {
  final String? productName;
  final String? productGroup;
  final String? price;
  final String? description;
  final int? id;

  const ProductDetailsPage({
    this.productName,
    this.productGroup,
    this.price,
    this.description,
    this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // List<String> items = ["Variations", "Descriptions", "Reviews"];
  int currentIndex = 0;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.white,
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
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: () {
                  setState(() {});
                },
                child: const CircleAvatar(
                  backgroundColor: KColor.gray,
                  child: Icon(
                    Icons.favorite,
                    color: KColor.errorRedText,
                    size: 22,
                  ),
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
                productName: widget.productName,
                productGroup: widget.productGroup,
                price: widget.price,
                description: widget.description,
                id: widget.id.toString(),
                userId: "12",
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
                color: KColor.primary, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_checkout_outlined,
                  color: KColor.black54,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Add to cart',
                  style: TextStyles.subTitle.copyWith(color: KColor.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
