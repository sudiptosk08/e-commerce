// import 'package:dotted_line/dotted_line.dart';
// import 'package:ecommerce_app/utils/extension/extension.dart';
// import 'package:flutter/material.dart';

// import '../../../../../utils/assets/app_assets.dart';
// import '../../../../../utils/colors/app_colors.dart';
// import '../../../../../utils/text_styles/text_styles.dart';

// class KStepper extends StatefulWidget {
//   final bool checkStepper;

//   const KStepper({required this.checkStepper, Key? key}) : super(key: key);

//   @override
//   State<KStepper> createState() => _KStepperState();
// }

// class _KStepperState extends State<KStepper> {
//   List<String> items = [
//     "Your parcel has been picked .6 May,2021 16:34",
//     "Your parcel has been packing for in transit",
//     "Your parcel has been out for delivery.",
//     "Your parcel has been delivered .9 May,2021 16:34",
//   ];
//   List<String> track = [
//     "Picked",
//     "In transit",
//     "Out for delivery",
//     "Delivered",
//   ];
//   List<String> checkout = [
//     "Address",
//     "Payment",
//     "Preview",
//   ];
//   List<dynamic> trackIcons = [
//     'assets/images/picked.png',
//     'assets/images/inTransit.png',
//     'assets/images/productDelivery.png',
//     'assets/images/delivered.png',
//   ];

//   int currentIndex = 0;
//   String processing = "Processing";
//   String shipping = "Shiping";
//   String deliverd = "Delivered";

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: items.length,
//       itemBuilder: (BuildContext context, int index) {
//         return InkWell(
//           onTap: () {
//             setState(() {
//               currentIndex = index;
//             });
//           },
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 1000),
//             curve: Curves.bounceInOut,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _steps(index, context),
//                 const SizedBox(width: 18),
//                 _buildSteps(index),
//                 const SizedBox(width: 10),
//                 _stepsDescription(index),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Container _steps(int index, BuildContext context) {
//     return Container(
//       //color: Colors.lightBlue,
//       margin: const EdgeInsets.only(bottom: 25.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             children: [
//               Image.asset(
//                 trackIcons[index],
//                 color: KColor.primary,
//                 height: 42,
//               ),
//               const SizedBox(height: 4),
//               SizedBox(
//                 width: context.screenWidth * 0.19,
//                 child: Text(
//                     textAlign: TextAlign.center,
//                     track[index],
//                     style:
//                         TextStyles.bodyText1.copyWith(color: KColor.black54)),
//                ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Flexible _stepsDescription(int index) {
//     return Flexible(
//       child: Text(
//           textAlign: TextAlign.left,
//           items[index],
//           style: TextStyles.bodyText1.copyWith(color: KColor.black54)),
//     );
//   }

//   Column _buildSteps(int index) {
//     return Column(
//       children: [
//         Container(
//             height: 25,
//             width: 25,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: KColor.background,
//             ),
//             child: currentIndex == index
//                 ? Image.asset(
//                     AppAssets.check,
//                     color: KColor.green,
//                   )
//                 : Image.asset(
//                     AppAssets.check,
//                     color: KColor.errorRedText,
//                   )),
//         index == items.length - 1
//             ? Container()
//             : const SizedBox(
//                 width: 20,
//                 height: 92,
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: DottedLine(
//                     direction: Axis.vertical,
//                     dashLength: 6.0,
//                     dashColor: KColor.textgrey,
//                     lineThickness: 1,
//                     dashGapLength: 6.0,
//                   ),
//                 ),
//               )
//       ],
//     );
//   }
// }
// // import 'package:ecommerce_app/utils/colors/app_colors.dart';
// // import 'package:flutter/material.dart';

// // class StepperComponent extends StatelessWidget {
// //   const StepperComponent({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.stretch,
// //         children: [
// //           Row(
// //             children: [
// //               Container(
// //                 width: 20,
// //                 height: 20,
// //                 decoration:
// //                     BoxDecoration(
// //                       color: KColor.green,
// //                       borderRadius: BorderRadius.circular(100)),
// //               ),
// //               Expanded(child: Container(
// //                 height: 2,color: KColor.seenGreen,
// //               ))
// //             ],
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class KStepper extends StatefulWidget {
  const KStepper({super.key});

  @override
  State<KStepper> createState() => _KStepperState();
}

class _KStepperState extends State<KStepper> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: KSize.getWidth(context, 370),
      height: KSize.getHeight(context, 90),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              StepperComponent(
                currentIndex: _currentIndex,
                index: 0,
                status: "Order Placed ",
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              StepperComponent(
                currentIndex: _currentIndex,
                status: "In Progress",
                index: 1,
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              StepperComponent(
                currentIndex: _currentIndex,
                status: "  Shipped",
                index: 2,
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              StepperComponent(
                currentIndex: _currentIndex,
                status: "Delivered",
                index: 3,
                isLast: true,
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
            ],
          ),
          // Expanded(
          //     child: PageView.builder(
          //   itemCount: 4,
          //   itemBuilder: (context, index) {
          //     return Center(
          //       child: Text('Page ${index}'),
          //     );
          //   },
          // ))
        ],
      ),
    );
  }
}

class StepperComponent extends StatelessWidget {
  int index;
  int currentIndex;
  String status;
  VoidCallback onTap;
  bool isLast;
  StepperComponent(
      {required this.index,
      required this.currentIndex,
      required this.status,
      required this.onTap,
      this.isLast = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return isLast
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: DottedBorder(
                    dashPattern: currentIndex >= index ? [8, 4] : [12, 1],
                    strokeWidth: currentIndex >= index ? 0.8 : 2,
                    strokeCap: StrokeCap.round,
                    borderType: BorderType.RRect,
                    color: currentIndex >= index
                        ? KColor.primary
                        : const Color(0xffD2D2D2),
                    radius: const Radius.circular(100),
                    borderPadding: const EdgeInsets.all(1.5),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: currentIndex >= index
                            ? const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment(0.9, 0.1),
                                colors: [
                                    Color(0xffABE6C9),
                                    Color.fromARGB(255, 133, 227, 182)
                                  ])
                            : const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment(0.9, 0.1),
                                colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)]),
                      ),
                      child: currentIndex >= index
                          ? Icon(
                              Icons.done_all_outlined,
                              color: KColor.white,
                              size: 18,
                            )
                          : Icon(
                              Icons.brightness_1,
                              color: KColor.grey350,
                              size: 18,
                            ),
                    ),
                  ),
                ),
                // DottedLine(
                //   dashColor:
                //       currentIndex >= index + 1 ? KColor.primary : KColor.grey,
                // ),
              ]),
              Text(
                status,
                style: TextStyles.bodyText2,
              ),
            ],
          )
        : Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: DottedBorder(
                      dashPattern: currentIndex >= index ? [8, 4] : [12, 1],
                      strokeWidth: currentIndex >= index ? 0.8 : 2,
                      strokeCap: StrokeCap.round,
                      borderType: BorderType.RRect,
                      color: currentIndex >= index
                          ? KColor.primary
                          : const Color(0xffD2D2D2),
                      radius: const Radius.circular(100),
                      borderPadding: const EdgeInsets.all(1.5),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: currentIndex >= index
                              ? LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment(0.9, 0.1),
                                  colors: [
                                      Color(0xffABE6C9),
                                      Color.fromARGB(255, 133, 227, 182)
                                    ])
                              : LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment(0.9, 0.1),
                                  colors: [
                                      Color(0xffFFFFFF),
                                      Color(0xffFFFFFF)
                                    ]),
                        ),
                        // color: currentIndex >= index
                        //     ? Color(0xffABE6C9)
                        //     : ,
                        child: currentIndex >= index
                            ? Icon(
                                Icons.done_all_outlined,
                                color: KColor.white,
                                size: 18,
                              )
                            : Icon(
                                Icons.brightness_1,
                                color: KColor.grey350,
                                size: 18,
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DottedLine(
                      dashColor: currentIndex >= index + 1
                          ? KColor.primary
                          : KColor.grey,
                    ),
                  ),
                ]),
                Text(
                  status,
                  style: TextStyles.bodyText2,
                ),
              ],
            ),
          );
  }
}
