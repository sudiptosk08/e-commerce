import 'package:flutter/material.dart';
import 'my_order_card.dart';

class SpecificOrder extends StatefulWidget {
  final String orderStatus;
  const SpecificOrder({Key? key, required this.orderStatus}) : super(key: key);

  @override
  State<SpecificOrder> createState() => _SpecificOrderState();
}

class _SpecificOrderState extends State<SpecificOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) {
          // print(orderList[index]);
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                InkWell(
                    onTap: () {
                      // // Navigator.of(context).pushNamed('/orderDetails', arguments: orderList[index] );
                      // Navigator.of(context).push(
                      //     CupertinoPageRoute(
                      //         builder: (context) =>
                      //             OrderDetails(
                      //                 orderData:
                      //                     orderList[index])));
                    },
                    child: const MyOrderCard(
                        isChecked: true,
                        id: "1902541",
                        date: "30-03-2023",
                        userName: "Sudipto Sarker",
                        contract: "01758023652",
                        grandTotal: "1050",
                        paymentType: "Cash On Delivery",
                        status: "Delivered")),
              ],
            ),
          );
        },
      ),
    );
  }
}
