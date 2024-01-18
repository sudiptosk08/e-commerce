import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/global_component/appBar/app_bar.dart';
import 'package:ecommerce_app/features/view/global_component/buttons/Kdrop_down_field.dart';
import 'package:ecommerce_app/features/view/global_component/text_field_container/text_field_container.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var passValue = true;
  var confirmPassValue = true;

  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController userPhone = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: KAppBar(
          checkTitle: true,
          title: 'Profile',
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: KSize.getWidth(context, 140),
                  height: KSize.getHeight(context, 140),
                  decoration: BoxDecoration(
                      color: KColor.white,
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                          image: AssetImage(AppAssets.product1))),
                ),
                Positioned(
                  right: 20,
                  bottom: 2,
                  child: CircleAvatar(
                      radius: 14,
                      backgroundColor: KColor.primary,
                      child: Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: KColor.white,
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFieldContainer(
                        hint: 'First Name',
                        label: 'first name',
                        keyboardType: TextInputType.name,
                        suffixIcon: Icon(
                          Icons.person,
                          color: KColor.black54,
                        ),
                        controller: firstName,
                      ),
                    ),
                    Expanded(
                      child: TextFieldContainer(
                        hint: 'Last Name',
                        label: 'last name',
                        keyboardType: TextInputType.name,
                        suffixIcon: Icon(
                          Icons.person,
                          color: KColor.black54,
                        ),
                        controller: lastName,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldContainer(
                  hint: 'phone',
                  label: 'phone',
                  keyboardType: TextInputType.phone,
                  suffixIcon: Icon(
                    Icons.call,
                    color: KColor.black54,
                  ),
                  controller: userPhone,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldContainer(
                  hint: 'email',
                  label: 'email',
                  keyboardType: TextInputType.phone,
                  suffixIcon: Icon(
                    Icons.mail,
                    color: KColor.black54,
                  ),
                  controller: userPhone,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldContainer(
                  hint: 'password',
                  label: 'password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passValue = !passValue;
                        });
                      },
                      icon: passValue
                          ? Icon(
                              Icons.visibility_off_outlined,
                              color: KColor.black54,
                            )
                          : Icon(
                              Icons.visibility_outlined,
                              color: KColor.black54,
                            )),
                  obscureText: passValue,
                  controller: password,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldContainer(
                  hint: 'confirm passwrod',
                  label: 'confirm password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          confirmPassValue = !confirmPassValue;
                        });
                      },
                      icon: confirmPassValue
                          ? Icon(
                              Icons.visibility_off_outlined,
                              color: KColor.black54,
                            )
                          : Icon(
                              Icons.visibility_outlined,
                              color: KColor.black54,
                            )),
                  obscureText: confirmPassValue,
                  controller: confirmPassword,
                ),
              ],
            ),
          ),
        ],
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
          title: "Place to Order",
        ),
      ),
    );
  }
}
