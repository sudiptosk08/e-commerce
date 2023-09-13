import 'dart:io';

import 'package:ecommerce_app/features/view/screens/report_issue/page/view_report_list.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/text_styles/text_styles.dart';
import '../../global_component/appBar/app_bar.dart';
import '../../global_component/buttons/Kdrop_down_field.dart';
import '../../global_component/text_field_container/k_text_field.dart';

class ReportIssue extends StatefulWidget {
  const ReportIssue({Key? key}) : super(key: key);

  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  TextEditingController reason = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController description = TextEditingController();
  File? image;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: KAppBar(
          checkTitle: true,
          title: 'Report Issue',
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
              Text(
                'Select Reason*',
                style: TextStyles.subTitle.copyWith(
                  color: KColor.black,
                ),
              ),
              const SizedBox(height: 8),
              //const KDropdown(hint: 'Select a reason'),
              KFillNormal(
                controller: reason,
                readOnly: false,
                label: '',
                hintText: 'Reason',
              ),
              const SizedBox(height: 12),
              Text(
                'Order ID*',
                style: TextStyles.subTitle.copyWith(
                  color: KColor.black,
                ),
              ),
              const SizedBox(height: 8),
              KFillNormal(
                controller: id,
                readOnly: false,
                label: '',
                hintText: 'Order ID',
              ),
              const SizedBox(height: 12),
              Text(
                'Description*',
                style: TextStyles.subTitle.copyWith(
                  color: KColor.black,
                ),
              ),
              const SizedBox(height: 8),
              KFillNormal(
                controller: description,
                readOnly: false,
                label: '',
                hintText: 'Description',
                maxline: 7,
                minline: 7,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  pickImage(ImageSource.camera);
                },
                child: Container(
                  width: context.screenWidth,
                  height: 175,
                  decoration: BoxDecoration(
                    color: KColor.background.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload_outlined,
                              size: 24,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Click or drag files here to upload',
                              style: TextStyles.bodyText1.copyWith(
                                color: KColor.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        )
                      : Image.file(
                          image!,
                          height: 175,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: context.screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KButton(
                    title: 'Add Reports',
                    textColor: KColor.white,
                    onPressedCallback: () {},
                    width: context.screenWidth * 0.45,
                    height: 40,
                  ),
                  const SizedBox(height: 16),
                  KButton(
                    title: 'View Report List',
                    textColor: KColor.black,
                    onPressedCallback: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReportList()));
                    },
                    width: context.screenWidth * 0.45,
                    height: 40,
                  ),
                ],
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
