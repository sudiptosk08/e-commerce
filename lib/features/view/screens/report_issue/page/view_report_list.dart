import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/colors/app_colors.dart';
import '../../../global_component/appBar/app_bar.dart';
import '../component/report_card.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        // final reportState = ref.watch(reportProvider);
        return Scaffold(
          backgroundColor: KColor.background,
          appBar: PreferredSize(
            preferredSize:const Size.fromHeight(50),
            child: KAppBar(
              checkTitle: true,
              title: 'Report List',
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                      5,
                      (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReportViewCard(
                                  image: AppAssets.shoe1,
                                  orderId: "5",
                                  reason: "Wrong Product Delivery",
                                  date: "2023-04-06",
                                  detailstxt:
                                      "Amar Product o Problem ache . Ami order korchilam M size.Ami order korchilam M size. Delivery kora oiche L size shirt . Ekhon amar ki karoni bhai . Amar tak a back de re bhai lkasldkfjlkj.",
                                ),
                              ]))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String createDate(String? date, int? index) {
    List dates = date!.split(" ");
    return dates[index!];
  }

  String imageData(String? image, int? index) {
    index = image?.indexOf(":");
    List data = [
      image?.substring(0, index).trim(),
      image?.substring(index! + 1).trim()
    ];
    print(data[0]);
    print(data[1]);
    return data[index!];
  }
}
