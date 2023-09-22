import 'dart:io';
import 'package:ecommerce_app/features/view/global_component/text_field_container/k_text_field.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/appBar/app_bar.dart';
import '../../../global_component/buttons/Kdrop_down_field.dart';

class WriteReview extends StatefulWidget {
  const WriteReview({Key? key}) : super(key: key);

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  TextEditingController message = TextEditingController();
  var rating = 0.0;
  int selectIndex = 0;
  int selectedRatting = 0;
  int maxLength = 200;
  File? image;
  File? video;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } catch (e) {
      return null;
    }
  }

  Future pickVideo(ImageSource source) async {
    try {
      final video = await ImagePicker()
          .pickVideo(source: source, maxDuration: const Duration(seconds: 10));
      if (video == null) return;
      final imageTemporary = File(video.path);
      setState(() {
        this.video = imageTemporary;
      });
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              //const ReviewCard(),
              SizedBox(height: context.screenHeight * 0.05),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('How much did you like the product?',
                        style: TextStyles.subTitle),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0, bottom: 12),
                      child: SmoothStarRating(
                        allowHalfRating: false,
                        color: KColor.yellow,
                        borderColor: KColor.yellow,
                      ),
                    ),
                    Text('Great!', style: TextStyles.bodyText1),
                  ],
                ),
              ),
              SizedBox(height: context.screenHeight * 0.04),

              const SizedBox(height: 16),
              // KDropdown(
              //   hint: 'The product was awesome!',
              //   selectedReason: _selectedReason,
              //   change: (e) {},
              //   data: const [],
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(32.0),
              //   child: TextDivider.horizontal(
              //     color: KColor.blackbg.withOpacity(0.2),
              //     thickness: 1,
              //     text: Text(
              //       'or',
              //       style: TextStyles.bodyText1.copyWith(
              //         color: KColor.blackbg.withOpacity(0.4),
              //       ),
              //     ),
              //   ),
              // ),
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
              Row(
                children: [
                  Text("Upload Image :", style: TextStyles.subTitle),
                  InkWell(
                    onTap: () => pickImage(ImageSource.camera),
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
              SizedBox(height: context.screenHeight * 0.05),
              KButton(
                title: 'Submit Review',
                radius: 8,
                height: 40,
                textStyle: TextStyles.bodyText1
                    .copyWith(color: KColor.white, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
