import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
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
        length: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: KSize.getWidth(context, 350),
              color: KColor.white,
              child:const Column(
                children:  [
                  SizedBox(
                    height: 40,
                    child: TabBar(
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor: KColor.grey,
                      labelColor: KColor.black,
                      isScrollable: true,
                      tabs: [
                        Padding(
                          padding: EdgeInsets.only(right: 12.0, left: 12.0),
                          child: Tab(
                            text: 'Delivered',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 12.0, left: 12.0),
                          child: Tab(
                            text: 'Processing',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 12.0, left: 12.0),
                          child: Tab(
                            text: 'Canceled',
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
                  SpecificOrder(orderStatus: "Delivered"),
                  SpecificOrder(orderStatus: "Processing"),
                  SpecificOrder(orderStatus: "Canceled"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
