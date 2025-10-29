import 'package:ecommerce_app/features/view/global_component/shop_store/shop_store_card.dart';
import 'package:ecommerce_app/features/view/screens/shop_store_details/shop_store_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../global_component/appBar/app_bar.dart';
import '../../global_component/text_field_container/k_search_field.dart';

class ShopStorePage extends StatefulWidget {
  const ShopStorePage({Key? key}) : super(key: key);

  @override
  State<ShopStorePage> createState() => _ShopStorePageState();
}

class _ShopStorePageState extends State<ShopStorePage> {
  TextEditingController controller = TextEditingController();
  int pageNum = 1;
  bool isPageLoading = false;
  String query = "";
  List<dynamic> store = [
    {
      'id': 1,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/3670d41c-f083-4e87-81eb-1ec37dd27482?h=350&w=350",
      'shopName': "Diamond Plaza ",
      'ratingStar': 5,
    },
    {
      'id': 2,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/25185cbc-3340-40a9-8a77-7b7c57067130?h=350&w=350",
      'shopName': "Ajanta Shoes",
      'ratingStar': 3,
    },
    {
      'id': 3,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/7f4646c1-6e94-43ef-98d3-7def922409bc?h=350&w=350",
      'shopName': "Opera Mall",
      'ratingStar': 5,
    },
    {
      'id': 4,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/9f768178-4ede-40ed-b1ec-0244df11e5ea?h=350&w=350",
      'shopName': "Nutrinix for Food and Health",
      'ratingStar': 4.5,
    },
    {
      'id': 5,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/7343818c-4068-4787-9333-92ad5de0bab9?h=350&w=350",
      'shopName': "Transcom",
      'ratingStar': 4,
    },
    {
      'id': 6,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/c6f8a30f-6d26-43ec-9e82-05f90c16b367?h=350&w=350",
      'shopName': "Nestle",
      'ratingStar': 4,
    },
    {
      'id': 7,
      'imagePath':
          "https://media.e-valy.com/cms/brands/logo/bbe2d1fa-0bbb-4080-83d4-4f96cc5dec5d?h=350&w=350",
      'shopName': "Jamuna Electronics and Automobile",
      'ratingStar': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return Scaffold(
          backgroundColor: KColor.background,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: KAppBar(
              checkTitle: true,
              title: 'Shop & Store',
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  }),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchTextField(
                  callbackFunction: (query) {},
                  controller: controller,
                  readOnly: false,
                  hintText: 'Search here...',
                ),
                const SizedBox(height: 5),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Loading ...",
                    //       style: TextStyles.bodyText3
                    //           .copyWith(color: KColor.grey),
                    //     ),
                    //     const SizedBox(
                    //       height: 5,
                    //     ),
                    //     const CircularProgressIndicator(
                    //       color: KColor.grey,
                    //     )
                    //   ],
                    // ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(6),
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 3.0,
                            mainAxisSpacing: 2.0,
                            childAspectRatio: 8.5 / 10,
                          ),
                          itemCount: store.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return ShopStoreCard(
                              id: store[index]['id'].toString(),
                              imagePath: store[index]['imagePath'],
                              shopName: store[index]['shopName'],
                              ratingStar: 5,
                              tap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShopStoreDetailsPage(
                                              shopName: store[index]
                                                  ['shopName'],
                                              shopImage: store[index]
                                                  ['imagePath'],
                                              shopAddress:
                                                  "Dhaka,Banasress,Block J, Road 3",
                                            )));
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
