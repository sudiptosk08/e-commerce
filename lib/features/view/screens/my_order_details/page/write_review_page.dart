// ignore_for_file: must_be_immutable, avoid_print

import 'dart:io';

import 'package:ecommerce_app/constant/asset_service.dart';
import 'package:ecommerce_app/features/view/global_component/text_field_container/k_text_field.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/controller/add_review_controller.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  XFile? image;

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
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('How is Your Order ?',
                          style: TextStyles.subTitle1.copyWith(
                              color: const Color(0xff1F3F77), fontSize: 16)),
                      Text('Your overall rating',
                          style: TextStyles.bodyText2
                              .copyWith(color: const Color(0xff495C95))),
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
                          size: 30,
                          rating: ratings,
                          borderColor: KColor.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.screenHeight * 0.01),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Write Detailed Review', style: TextStyles.subTitle1),
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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Upload Image :", style: TextStyles.subTitle1),
                        const SizedBox(height: 30),
                        Center(
                          child: InkWell(
                            onTap: () async {
                              var pickedfile =
                                  await AssetService.pickImageVideo(
                                      false, context, ImageSource.gallery);
                              image = pickedfile ?? image;
                              setState(() {});
                            },
                            child: image == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.cloud_upload_outlined,
                                        size: 24,
                                      ),
                                      const SizedBox(height: 8),
                                      Text('Click here to upload image',
                                          style: TextStyles.bodyText1),
                                    ],
                                  )
                                : Image.file(
                                    File(image!.path),
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                      ]),
                ),
                SizedBox(height: context.screenHeight * 0.05),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: KButton(
                          onPressedCallback: () {
                            ref.read(addReviewProvider.notifier).addReviews(
                                id: widget.id,
                                ratings: ratings.toInt(),
                                message: message.text,
                                image: image!.path);
                          },
                          title: 'Cancel',
                          color: Color(0xffF25674).withOpacity(0.2),
                          radius: 8,
                          borderColor: Color(0xffF25674),
                          isOutlineButton: true,
                          height: 46,
                          textStyle: TextStyles.bodyText1.copyWith(
                              color: Color(0xffF25674),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: KButton(
                          onPressedCallback: () {
                            ref.read(addReviewProvider.notifier).addReviews(
                                id: widget.id,
                                ratings: ratings.toInt(),
                                message: message.text,
                                image: image!.path);
                          },
                          title: 'Submit Review',
                          radius: 8,
                          height: 46,
                          textStyle: TextStyles.bodyText1.copyWith(
                              color: KColor.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
