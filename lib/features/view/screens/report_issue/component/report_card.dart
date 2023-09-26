// ignore_for_file: library_private_types_in_public_api

import 'package:ecommerce_app/utils/helper/helper.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/size/k_size.dart';
import '../../../../../utils/text_styles/text_styles.dart';

// ignore: must_be_immutable
class ReportViewCard extends StatefulWidget {
  String orderId;
  String? date;
  String? reason;
  String? image;
  final String? detailstxt;

  ReportViewCard(
      {Key? key,
      required this.orderId,
      this.detailstxt,
      this.reason,
      this.date,
      this.image})
      : super(key: key);

  @override
  _ReportViewCardState createState() => _ReportViewCardState();
}

class _ReportViewCardState extends State<ReportViewCard> {
  int secondaryIndex = -1;
  int primaryIndex = 0;

  void changeIndex(int index) {
    setState(() {
      secondaryIndex = index;
    });
  }

  void changePrimaryIndex(int index) {
    setState(() {
      primaryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: myEdgeInsets,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (secondaryIndex == -1) {
              secondaryIndex = 0;
            } else {
              setState(() {
                secondaryIndex = -1;
              });
            }
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: myEdgeInsets,
              decoration: BoxDecoration(
                  color: KColor.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      width: 1, color: KColor.textgrey.withOpacity(0.4))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "#OrId${widget.orderId}",
                                      textAlign: TextAlign.justify,
                                      style: TextStyles.bodyText1
                                          .copyWith(color: KColor.black),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Date: ",
                                      textAlign: TextAlign.justify,
                                      style: TextStyles.bodyText1
                                          .copyWith(color: KColor.black54),
                                    ),
                                    Text(
                                      " ${widget.date}",
                                      textAlign: TextAlign.justify,
                                      style: TextStyles.bodyText2
                                          .copyWith(color: KColor.black54),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Reason: ",
                                      textAlign: TextAlign.justify,
                                      style: TextStyles.bodyText1
                                          .copyWith(color: KColor.black54),
                                    ),
                                    Text(
                                      " ${widget.reason}",
                                      textAlign: TextAlign.justify,
                                      style: TextStyles.bodyText2
                                          .copyWith(color: KColor.black54),
                                      maxLines: 2,
                                    ),
                                  ],
                                )
                              ]),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                          )
                        ]),
                  ),
                  if (secondaryIndex == 0)
                    SizedBox(height: KSize.getHeight(context, 7)),
                  if (secondaryIndex == 0)
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            width: 75,
                            height: 85,
                            decoration: BoxDecoration(
                              color: KColor.textgrey,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: AssetImage(widget.image.toString())),
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: Text(
                              widget.detailstxt!,
                              textAlign: TextAlign.justify,
                              style: TextStyles.bodyText3
                                  .copyWith(color: KColor.black54),
                              maxLines: 6,
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
