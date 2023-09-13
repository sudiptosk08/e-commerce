import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';

class SelectedItems extends StatefulWidget {
  const SelectedItems({Key? key}) : super(key: key);

  @override
  State<SelectedItems> createState() => _SelectedItemsState();
}

class _SelectedItemsState extends State<SelectedItems> {
  List<dynamic> list = [
    {
      'productName': "Black Conton Shirt",
    },
    {
      'productName': "Geans Blue Pant",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: KColor.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Info',
                    style: TextStyles.subTitle.copyWith(color: KColor.black),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: context.screenWidth * .50,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "${list[index]['productName']}",
                              style: TextStyles.bodyText1.copyWith(
                                  color: KColor.black.withOpacity(0.6)),
                            ),
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            '(x2)',
                            style: TextStyles.bodyText1
                                .copyWith(color: KColor.black.withOpacity(0.6)),
                          ),
                          Text(
                            '৳1050',
                            style: TextStyles.bodyText1
                                .copyWith(color: KColor.black.withOpacity(0.6)),
                          ),
                        ],
                      ),
                    );
                  }),
            ]));
  }
}
