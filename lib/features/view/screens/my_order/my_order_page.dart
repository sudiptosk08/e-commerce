import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../global_component/appBar/app_bar.dart';
import 'component/specific_order.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.background,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: KAppBar(
          checkTitle: true,
          title: 'My Orders',
        ),
      ),
      body: DefaultTabController(
        length: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              color: KColor.white,
              child: const Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: TabBar(
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor: KColor.grey,
                      labelColor: KColor.black,
                      isScrollable: true,
                      tabs: [
                        Padding(
                          padding: EdgeInsets.only(right: 5.0, left: 5.0),
                          child: Tab(
                            text: 'Pending',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5.0, left: 5.0),
                          child: Tab(
                            text: 'Processing',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5.0, left: 5.0),
                          child: Tab(
                            text: 'Shipping',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5.0, left: 5.0),
                          child: Tab(
                            text: 'Delivered',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5.0, left: 5.0),
                          child: Tab(
                            text: 'Cancelled',
                          ),
                        ),
                      ],
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.screenHeight * 0.01),
            const Expanded(
              child: TabBarView(
                children: [
                  SpecificOrder(orderStatus: "Pending"),
                  SpecificOrder(orderStatus: "Processing"),
                  SpecificOrder(orderStatus: "Shiping"),
                  SpecificOrder(orderStatus: "Delivered"),
                  SpecificOrder(orderStatus: "Cancelled"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
