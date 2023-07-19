import 'package:ecommerce_app/features/view/global_component/dialog/k_confirm_dialog.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CartItemList extends StatelessWidget {
  const CartItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 4,
          itemBuilder: (context, index) => Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            dragStartBehavior: DragStartBehavior.start,
            movementDuration: const Duration(milliseconds: 200),
            resizeDuration: const Duration(milliseconds: 1000),
            onDismissed: (direction) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return KConfirmDialog(
                      message: 'Delete product',
                      subMessage: 'Are you sure you want to remove this item?"',
                      onCancel: () {
                        //widget.cancel
                      },
                      onDelete: () {
                        //widget.delete,
                      });
                },
              );
            },
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: const BoxDecoration(
                color: KColor.errorRedText,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Icon(Icons.delete)],
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: KColor.textgrey.withOpacity(0.4)),
                    color: KColor.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          width: KSize.getWidth(context, 125),
                          height: KSize.getHeight(context, 102),
                          decoration: BoxDecoration(
                            color: KColor.grey200!.withOpacity(1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7)),
                          ),
                          child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                    AppAssets.shoe3,
                                  )))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: SizedBox(
                          width: context.screenWidth * 0.50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("YunKeliu Men Blazer Coat Peheli Nazar Mein",
                                  style: TextStyles.bodyText1),
                              SizedBox(height: KSize.getHeight(context, 3)),
                              Text(
                                "Group : Shirt    Size : XL",
                                style: TextStyles.bodyText1
                                    .copyWith(color: KColor.grey),
                              ),
                              SizedBox(height: KSize.getHeight(context, 6)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "৳20.12",
                                    style: TextStyles.subTitle
                                        .copyWith(color: KColor.errorRedText),
                                  ),
                                  Container(
                                    width: 115,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 0.9, color: KColor.gray)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                border: Border(
                                              right: BorderSide(
                                                  width: 0.9,
                                                  color: KColor.gray),
                                            )),
                                            width: 35,
                                            height: 35,
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              Icons.remove,
                                              size: 18,
                                              color: KColor.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          alignment: Alignment.center,
                                          width: 37,
                                          child: Text(
                                            "1",
                                            style: TextStyles.bodyText1,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      width: 0.9,
                                                      color: KColor.gray)),
                                            ),
                                            alignment: Alignment.center,
                                            width: 35,
                                            height: 35,
                                            child: const Icon(
                                              Icons.add,
                                              size: 18,
                                              color: KColor.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
