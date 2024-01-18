// ignore_for_file: must_be_immutable

import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/dialog/k_confirm_dialog.dart';

class NotificationCard extends StatefulWidget {
  final String? msg;
  final String? date;
  final String? title;
  String? seen;
  final VoidCallback? cancel;
  final VoidCallback? delete;
  NotificationCard({
    this.title,
    this.cancel,
    this.delete,
    this.seen,
    Key? key,
    this.msg,
    this.date,
  }) : super(key: key);

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool isSwapToLeft = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.seen = "0";
        });
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 80,
        width: context.screenWidth,
        decoration: BoxDecoration(
            color: KColor.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12.0, right: 12, top: 16),
                    child: CircleAvatar(
                      backgroundColor: KColor.primary,
                      radius: 18,
                      child: Icon(
                        Icons.delivery_dining_outlined,
                        color: KColor.white,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title.toString(),
                          style: TextStyles.subTitle1,
                        ),
                        Text(
                          widget.date.toString(),
                          style: TextStyles.bodyText3
                              .copyWith(color: KColor.black54),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(
                            widget.msg.toString(),
                            style: widget.seen.toString() == "0"
                                ? TextStyles.bodyText2
                                    .copyWith(color: KColor.black54)
                                : TextStyles.bodyText1
                                    .copyWith(color: KColor.black54),
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(Icons.delete_forever_outlined,
                  size: 25, color: KColor.textgrey),
            )
          ],
        ),
      ),
    );
  }

  Container _startToEndBackground() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
      margin: const EdgeInsets.only(top: 4, bottom: 4, left: 2, right: 2),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.0),
          bottomLeft: Radius.circular(4.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AppAssets.check,
            height: 23,
          ),
        ],
      ),
    );
  }

  Container _endToStartBackground() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
      margin: const EdgeInsets.only(top: 4, bottom: 4, left: 2, right: 2),
      decoration: BoxDecoration(
        color: KColor.red,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(4.0),
          bottomRight: Radius.circular(4.0),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Icon(Icons.delete)],
      ),
    );
  }
}
