import 'package:ecommerce_app/constant/shared_preference_constant.dart';
import 'package:ecommerce_app/features/view/screens/shipping_address/controller/add_new_shippingAddress.dart';
import 'package:ecommerce_app/utils/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
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
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController house = TextEditingController();
  int _selectedValue = 0;

  // Create a list of radio button values and labels
  final List radioOptions = [
    'Home Address',
    'Office Address',
  ];

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
                        'Delivery Addres Type',
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List<Widget>.generate(
                              radioOptions.length,
                              (int index) {
                                return Row(
                                  children: [
                                    Radio(
                                      value: index,
                                      activeColor: KColor.primary,
                                      groupValue: _selectedValue,
                                      onChanged: (int? value) {
                                        setState(() {
                                          _selectedValue = value!;
                                        });
                                      },
                                    ),
                                    Text(radioOptions[index].toString()),
                                  ],
                                );
                              },
                            ),
                          ),
                        )),
                    _editInformation(
                      'Phone',
                      KFillNormal(
                        inputType: TextInputType.phone,
                        controller: phone..text = getStringAsync(userContact),
                        hintText: 'Enter your phone here...',
                        label: '',
                        readOnly: false,
                      ),
                    ),
                    _editInformation(
                      'City',
                      KFillNormal(
                        inputType: TextInputType.streetAddress,
                        controller: city,
                        hintText: 'Enter your city here...',
                        label: '',
                        readOnly: false,
                      ),
                    ),
                    _editInformation(
                      'Region',
                      KFillNormal(
                        inputType: TextInputType.streetAddress,
                        controller: region,
                        hintText: 'Enter your region here...',
                        label: '',
                        readOnly: false,
                      ),
                    ),
                    _editInformation(
                      'Area',
                      KFillNormal(
                        inputType: TextInputType.streetAddress,
                        controller: area,
                        hintText: 'Enter your area here...',
                        label: '',
                        readOnly: false,
                      ),
                    ),
                    _editInformation(
                      'House / Street',
                      KFillNormal(
                        inputType: TextInputType.streetAddress,
                        controller: house,
                        hintText: 'Enter your house/street here...',
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
      bottomSheet: Consumer(builder: (context, ref, child) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: KButton(
            width: double.infinity,
            height: 40,
            isOutlineButton: false,
            radius: 8,
            color: KColor.primary,
            textStyle: TextStyles.bodyText1
                .copyWith(color: KColor.white, fontWeight: FontWeight.w500),
            onPressedCallback: () {
              ref.read(addShippingAddressProvider.notifier).addShippingAddress(
                  phone: phone.text,
                  deliveryAddressType: _selectedValue.toString(),
                  city: city.text,
                  region: region.text,
                  area: area.text,
                  house: house.text);
            },
            title: "Add Address",
          ),
        );
      }),
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
