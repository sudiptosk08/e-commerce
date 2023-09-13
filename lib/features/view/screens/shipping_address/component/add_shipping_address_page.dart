import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/text_styles/text_styles.dart';
import '../../../global_component/appBar/app_bar.dart';
import '../../../global_component/buttons/Kdrop_down_field.dart';
import '../../../global_component/text_field_container/k_text_field.dart';

class AddShippingAddressPage extends StatefulWidget {
  const AddShippingAddressPage({Key? key}) : super(key: key);

  @override
  State<AddShippingAddressPage> createState() => AddShippingAddressPageState();
}

class AddShippingAddressPageState extends State<AddShippingAddressPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: KAppBar(
          checkTitle: true,
          title: "Add  Address",
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _editInformation(
                      'Name',
                      KFillNormal(
                        controller: name,
                        hintText: 'Enter your name here...',
                        label: '',
                        readOnly: false,
                      ),
                    ),
                    _editInformation(
                      'Email',
                      KFillNormal(
                        controller: email,
                        hintText: 'Enter your email here...',
                        label: '',
                        readOnly: false,
                      ),
                    ),
                    _editInformation(
                      'Phone Number',
                      KFillNormal(
                        controller: phone,
                        hintText: 'Enter your phone number here...',
                        label: '',
                        readOnly: true,
                      ),
                    ),
                    _editInformation(
                      'Address',
                      KFillNormal(
                        controller: address,
                        hintText: 'Enter your address here...',
                        label: '',
                        readOnly: false,
                      ),
                    ),
                    _editInformation(
                      'City',
                      KFillNormal(
                        controller: address,
                        hintText: 'Enter your address here...',
                        label: '',
                        readOnly: false,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.screenHeight * 0.05),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(12.0),
        child: KButton(
          width: double.infinity,
          height: 40,
          isOutlineButton: false,
          radius: 8,
          color: KColor.primary,
          textStyle: TextStyles.bodyText1
              .copyWith(color: KColor.white, fontWeight: FontWeight.w500),
          onPressedCallback: () {},
          title: "Add Address",
        ),
      ),
    );
  }

  Column _editInformation(String title, Widget field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.bodyText1.copyWith(color: KColor.black),
        ),
        const SizedBox(height: 12),
        field,
        const SizedBox(height: 12),
      ],
    );
  }
}
