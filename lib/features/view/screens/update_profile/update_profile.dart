import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/global_component/appBar/app_bar.dart';
import 'package:ecommerce_app/features/view/global_component/buttons/Kdrop_down_field.dart';
import 'package:ecommerce_app/features/view/global_component/text_field_container/text_field_container.dart';
import 'package:ecommerce_app/features/view/screens/profile/controller/profile_controller.dart';
import 'package:ecommerce_app/features/view/screens/profile/state/user_profile_state.dart';
import 'package:ecommerce_app/features/view/screens/update_profile/controller/update_profile_controller.dart';
import 'package:ecommerce_app/utils/assets/app_assets.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:ecommerce_app/utils/size/k_size.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  TextEditingController phone = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final profileState = ref.watch(profileProvider);
      String? userFirstName = profileState is ProfileSuccessState
          ? profileState.profileModel!.data.firstName
          : ".....";
      String? userLastName = profileState is ProfileSuccessState
          ? profileState.profileModel!.data.lastName
          : ".....";
      String? userPhone = profileState is ProfileSuccessState
          ? profileState.profileModel!.data.phone
          : ".....";
      String? userEmail = profileState is ProfileSuccessState
          ? profileState.profileModel!.data.email
          : ".....";

      return Scaffold(
          backgroundColor: KColor.background,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: KAppBar(
              checkTitle: true,
              title: 'Update Profile',
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
                        color: KColor.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(KSize.getHeight(context, 10)),
                        child: Image.asset(
                          "assets/icons/user.png",
                          color: KColor.grey100,
                        ),
                      ),
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
                            hint: '',
                            label: '  First Name ',
                            keyboardType: TextInputType.name,
                            suffixIcon: Icon(
                              Icons.person,
                              color: KColor.black54,
                            ),
                            controller: firstName..text = userFirstName,
                          ),
                        ),
                        Expanded(
                          child: TextFieldContainer(
                            hint: '',
                            label: '  Last Name ',
                            keyboardType: TextInputType.name,
                            suffixIcon: Icon(
                              Icons.person,
                              color: KColor.black54,
                            ),
                            controller: lastName..text = userLastName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldContainer(
                      hint: '',
                      label: '  Phone ',
                      keyboardType: TextInputType.phone,
                      suffixIcon: Icon(
                        Icons.call,
                        color: KColor.black54,
                      ),
                      controller: phone..text = userPhone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldContainer(
                      hint: '',
                      label: '  Email ',
                      keyboardType: TextInputType.phone,
                      suffixIcon: Icon(
                        Icons.mail,
                        color: KColor.black54,
                      ),
                      controller: email..text = userEmail!,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldContainer(
                      hint: '',
                      label: '  New Password ',
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
                  ],
                ),
              ),
            ],
          ),
          bottomSheet: Consumer(builder: (context, ref, _) {
            final updateUserState = ref.watch(userProfileUpdateProvider);
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
                  if (updateUserState is! LoadingState) {
                    ref
                        .read(userProfileUpdateProvider.notifier)
                        .updateUserProfile(
                            firstName: firstName.text,
                            lastName: lastName.text,
                            email: email.text,
                            password: password.text,
                            phone: phone.text,
                            userName: firstName.text + lastName.text);
                  }
                },
                title: "Update Profile",
              ),
            );
          }));
    });
  }
}
