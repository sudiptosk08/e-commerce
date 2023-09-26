// ignore_for_file: must_be_immutable, avoid_print

import 'dart:io';

import 'package:ecommerce_app/features/view/global_component/text_field_container/k_text_field.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/controller/add_review_controller.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/appBar/app_bar.dart';
import '../../../global_component/buttons/Kdrop_down_field.dart';

class WriteReview extends StatefulWidget {
  int id;
  WriteReview({required this.id, Key? key}) : super(key: key);

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  TextEditingController message = TextEditingController();
  var ratings = 0.0;
  int selectIndex = 0;
  int selectedRatting = 0;
  int maxLength = 200;

  final ImagePicker imagePicker = ImagePicker();

  List<XFile> imageFilelist = [];

  void selectImages() async {
    final pickedImages = await imagePicker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      imageFilelist.addAll(pickedImages);
      print("ImageFile List : $pickedImages");
    }
    setState(() {
      imageFilelist.addAll(pickedImages.map((pickedImage) => pickedImage));
      print("Bogar $imageFilelist");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        backgroundColor: KColor.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: KAppBar(
            checkTitle: true,
            title: 'Write Review',
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('How much did you like the product?',
                          style: TextStyles.subTitle),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                        child: SmoothStarRating(
                          allowHalfRating: false,
                          color: KColor.yellow,
                          onRatingChanged: (rating) {
                            setState(() {
                              ratings = rating;
                            });
                          },
                          rating: ratings,
                          borderColor: KColor.yellow,
                        ),
                      ),
                      Text('Great!', style: TextStyles.bodyText1),
                    ],
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.01),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Write a review', style: TextStyles.subTitle),
                    Text('(${message.text.length}/$maxLength)',
                        style: TextStyles.bodyText1),
                  ],
                ),
                const SizedBox(height: 16),
                KFillNormal(
                  controller: message,
                  readOnly: false,
                  hintText: 'Write here...',
                  maxline: 7,
                  minline: 7,
                  inputType: TextInputType.text,
                  label: '',
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 240,
                  child: Center(
                    child: Column(children: [
                      Row(
                        children: [
                          Text("Upload Image :", style: TextStyles.subTitle),
                          InkWell(
                            onTap: () => selectImages(),
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: KColor.background,
                              ),
                              child: SvgPicture.asset(
                                AppAssets.camera,
                                color: KColor.black54,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          itemCount: imageFilelist.length,
                          itemBuilder: (context, index) {
                            return Image.file(
                              File(imageFilelist[index].path),
                              fit: BoxFit.cover,
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 4),
                        ),
                      )),
                      const SizedBox(
                        height: 5.0,
                      ),
                    ]),
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.05),
                KButton(
                  onPressedCallback: () {
                    ref.read(addReviewProvider.notifier).addReview(
                          widget.id,
                          ratings.toInt(),
                          message.text,
                          imageFilelist,
                        );
                  },
                  title: 'Submit Review',
                  radius: 8,
                  height: 40,
                  textStyle: TextStyles.bodyText1.copyWith(
                      color: KColor.white, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
    });
  }
}
