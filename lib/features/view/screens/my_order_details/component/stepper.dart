import 'package:dotted_line/dotted_line.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/assets/app_assets.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';

class KStepper extends StatefulWidget {
  final bool checkStepper;

  const KStepper({required this.checkStepper, Key? key}) : super(key: key);

  @override
  State<KStepper> createState() => _KStepperState();
}

class _KStepperState extends State<KStepper> {
  List<String> items = [
    "Your parcel has been picked .6 May,2021 16:34",
    "Your parcel has been packing for in transit",
    "Your parcel has been out for delivery.",
    "Your parcel has been delivered .9 May,2021 16:34",
  ];
  List<String> track = [
    "Picked",
    "In transit",
    "Out for delivery",
    "Delivered",
  ];
  List<String> checkout = [
    "Address",
    "Payment",
    "Preview",
  ];
  List<dynamic> trackIcons = [
    'assets/images/picked.png',
    'assets/images/inTransit.png',
    'assets/images/productDelivery.png',
    'assets/images/delivered.png',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            setState(() {
              currentIndex = index;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.bounceInOut,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _steps(index, context),
                const SizedBox(width: 18),
                _buildSteps(index),
                const SizedBox(width: 10),
                _stepsDescription(index),
              ],
            ),
          ),
        );
      },
    );
  }

  Container _steps(int index, BuildContext context) {
    return Container(
      //color: Colors.lightBlue,
      margin: const EdgeInsets.only(bottom: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            trackIcons[index],
            color: KColor.primary,
            height: 42,
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: context.screenWidth * 0.19,
            child: Text(
                textAlign: TextAlign.center,
                track[index],
                style: TextStyles.bodyText1.copyWith(color: KColor.black54)),
          ),
        ],
      ),
    );
  }

  Flexible _stepsDescription(int index) {
    return Flexible(
      child: Text(
          textAlign: TextAlign.left,
          items[index],
          style: TextStyles.bodyText1.copyWith(color: KColor.black54)),
    );
  }

  Column _buildSteps(int index) {
    return Column(
      children: [
        Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: KColor.background,
            ),
            child: currentIndex == index
                ? Image.asset(
                    AppAssets.check,
                    color: KColor.green,
                  )
                : Image.asset(
                    AppAssets.check,
                    color: KColor.errorRedText,
                  )),
        index == items.length - 1
            ? Container()
            : const SizedBox(
                width: 20,
                height: 92,
                child: Align(
                  alignment: Alignment.center,
                  child: DottedLine(
                    direction: Axis.vertical,
                    dashLength: 6.0,
                    dashColor: KColor.textgrey,
                    lineThickness: 1,
                    dashGapLength: 6.0,
                  ),
                ),
              )
      ],
    );
  }
}
