// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';

// import '../../../../../utils/colors/app_colors.dart';
// import '../../../../../utils/text_styles/text_styles.dart';
// import '../../../global_component/appBar/app_bar.dart';
// import '../component/stepper.dart';

// class TrackOrder extends StatefulWidget {
//   // final OrderData orderData;
//   const TrackOrder({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<TrackOrder> createState() => _TrackOrderState();
// }

// class _TrackOrderState extends State<TrackOrder> {
//   TextEditingController controller = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     print("in track");
//     //print(widget.orderData);
//     print("after track");
//   }

//   @override
//   Widget build(BuildContext context) {
//     // aftear track
//     return Scaffold(
//       backgroundColor: KColor.background,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(50),
//         child: KAppBar(
//           checkTitle: true,
//           title: 'Track Order',
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(Icons.arrow_back_ios)),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("ID: #OrId502 ", style: TextStyles.headline5),
//               const SizedBox(
//                 height: 4,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Placed on", style: TextStyles.subTitle1),
//                       const SizedBox(height: 8),
//                       Text(
//                           // "6 May",
//                           "06- 04 - 2023",
//                           style: TextStyles.bodyText1
//                               .copyWith(color: KColor.black54)),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Estimated Delivery", style: TextStyles.subTitle1),
//                       const SizedBox(height: 8),
//                       Text("6 May - 12 May",
//                           style: TextStyles.bodyText1
//                               .copyWith(color: KColor.black54)),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 15),
//               Text("Tracking Details", style: TextStyles.subTitle1),
//               const SizedBox(height: 16),
//               // const StepperComponent(),
//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
