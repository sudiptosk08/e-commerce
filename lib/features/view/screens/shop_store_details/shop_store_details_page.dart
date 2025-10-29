import 'package:ecommerce_app/features/view/screens/shop_store_details/tab_view/store_categories_page.dart';
import 'package:ecommerce_app/features/view/screens/shop_store_details/tab_view/store_profile_page.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ShopStoreDetailsPage extends StatefulWidget {
  const ShopStoreDetailsPage(
      {Key? key,
      required this.shopName,
      required this.shopImage,
      required this.shopAddress})
      : super(key: key);
  final String shopName;
  final String shopAddress;
  final String shopImage;

  @override
  State<ShopStoreDetailsPage> createState() => _ShopStoreDetailsPageState();
}

class _ShopStoreDetailsPageState extends State<ShopStoreDetailsPage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  var ratings = 0.0;
  List categories = [
    "Product",
    "Profile",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.background,
      body: SafeArea(
        child: DefaultTabController(
          length: categories.length,
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: context.screenWidth * 1,
                        height: context.screenHeight * 0.3,
                        child: Stack(
                          children: [
                            Image.asset(
                              "assets/images/shopStore.png",
                              fit: BoxFit.fill,
                              height: KSize.getHeight(context, 130),
                              width: context.screenWidth * 1,
                            ),
                            Positioned(
                              bottom: 0,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: KSize.getHeight(context, 122),
                                    height: KSize.getHeight(context, 135),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image: NetworkImage(
                                            widget.shopImage,
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  SizedBox(
                                    height: 140,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          " ${widget.shopName}",
                                          style: TextStyles.subTitle1,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.location_on_outlined,
                                                size: 20,
                                                color: KColor.black54),
                                            Text(
                                              widget.shopAddress,
                                              maxLines: 2,
                                              style: TextStyles.bodyText1
                                                  .copyWith(
                                                      color: KColor.black54),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.delivery_dining,
                                                size: 20,
                                                color: KColor.black54),
                                            Text(
                                              "Delivery In 1 To 5 Days",
                                              maxLines: 2,
                                              style: TextStyles.bodyText1
                                                  .copyWith(
                                                      color: KColor.black54),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SmoothStarRating(
                                              color: KColor.yellow,
                                              borderColor: KColor.yellow800,
                                              size: 20,
                                              rating: ratings,
                                              onRatingChanged: (rating) {
                                                setState(() {
                                                  ratings = rating;
                                                });
                                              },
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xff5C6BE9),
                                                      border: Border.all(
                                                          color:
                                                              KColor.secondary,
                                                          width: 0.6),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  margin:
                                                      const EdgeInsets.all(2),
                                                  child: Icon(
                                                    Icons.chat_rounded,
                                                    color: KColor.white,
                                                    size: 17,
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: KColor.primary,
                                                      border: Border.all(
                                                          color: KColor.primary,
                                                          width: 0.6),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  margin:
                                                      const EdgeInsets.all(2),
                                                  child: Icon(
                                                    Icons.call,
                                                    color: KColor.white,
                                                    size: 17,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
                SliverAppBar(
                  backgroundColor: KColor.white,
                  expandedHeight: KSize.getHeight(context, 40),
                  pinned: true,
                  floating: true,
                  // toolbarHeight: KSize.getHeight(context, 200),
                  // leadingWidth: 130,
                  // leading:
                  // titleSpacing: 2.0,
                  // title:
                  // actions: [
                  //   Padding(
                  //     padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 90.0),
                  //     child: InkWell(
                  //       onTap: () {
                  //         Navigator.pop(context);
                  //       },
                  //       child: Container(
                  //         height: 30,
                  //         width: 30,
                  //         decoration: BoxDecoration(
                  //             border: Border.all(color: KColor.white),
                  //             color: Colors.transparent,
                  //             borderRadius: BorderRadius.circular(30)),
                  //         padding: const EdgeInsets.all(5),
                  //         margin: const EdgeInsets.all(2),
                  //         child: const Icon(
                  //           Icons.close,
                  //           size: 22,
                  //           color: KColor.black,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ],
                  // flexibleSpace:
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(48),
                    child: Container(
                      color: KColor.white,
                      child: TabBar(
                        indicatorColor: KColor.black,
                        unselectedLabelColor: KColor.grey,
                        labelColor: KColor.black,
                        isScrollable: false,
                        tabs: [
                          ...List.generate(
                            categories.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.only(right: 4.0, left: 4.0),
                              child: Tab(
                                text: categories[index],
                              ),
                            ),
                          ),
                        ],
                        indicatorSize: TabBarIndicatorSize.tab,
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: const TabBarView(
              children: [StoreCategoriesPage(), StoreProfilePage()],
            ),
          ),
        ),
      ),
    );
  }
}
