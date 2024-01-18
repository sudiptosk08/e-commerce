// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/auth/login/controller/login_controller.dart';
import 'package:ecommerce_app/features/view/screens/auth/registration/registration_page.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../../../utils/size/k_size.dart';
import '../../../global_component/buttons/custom_button.dart';
import '../../../global_component/gray_handle/gray_handle.dart';
import '../../../global_component/show_sheet/show_sheet.dart';
import '../../../global_component/text_field_container/text_field_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var value = true;

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => Helper.dissmissKeyboard(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopify_rounded,
                  color: KColor.primary,
                  size: 90,
                ),
                Text(
                  "LOG-IN",
                  style: TextStyles.headline2.copyWith(color: KColor.black54),
                ),
                const SizedBox(
                  height: 25,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFieldContainer(
                        hint: 'phone',
                        label: 'phone',
                        keyboardType: TextInputType.phone,
                        suffixIcon: Icon(
                          Icons.phone,
                          color: KColor.black54,
                        ),
                        controller: phoneController,
                        padding: 10,
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
                                value = !value;
                              });
                            },
                            icon: value
                                ? Icon(
                                    Icons.visibility_off_outlined,
                                    color: KColor.black54,
                                  )
                                : Icon(
                                    Icons.visibility_outlined,
                                    color: KColor.black54,
                                  )),
                        obscureText: value,
                        controller: passwordController,
                      ),
                      TextButton(
                        onPressed: () =>
                            forgotPasswordBottomSheet(context, phoneController),
                        child: Text(
                          'Forgot password ! ',
                          style: TextStyles.bodyText1
                              .copyWith(color: KColor.black54),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Consumer(builder: (context, ref, _) {
                  final authState = ref.watch(loginProvider);
                  return CustomButton(
                    textColor: KColor.white,
                    name:
                        authState is LoadingState ? 'Please wait...' : 'Login',
                    onTap: () {
                      if (authState is! LoadingState) {
                        if (_formKey.currentState!.validate()) {
                          ref.read(loginProvider.notifier).login(
                                phone: phoneController.text,
                                password: passwordController.text,
                              );
                        }
                      }
                    },
                    width: KSize.getWidth(context, 180),
                    height: KSize.getHeight(context, 45),
                    color: KColor.primary,
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style:
                          TextStyles.bodyText1.copyWith(color: KColor.black54),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ));
                      },
                      child: Text(
                        'Create An Account',
                        style: TextStyles.bodyText1
                            .copyWith(color: KColor.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

forgotPasswordBottomSheet(
    BuildContext context, TextEditingController emailController) {
  showSheet(
    context,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GrayHandle(),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Forgot password',
            // style: TextStyles.mediumPoppins24Black24,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Enter your email for the verification proccesss, we will send 4 digits code to your email.',
            // style: TextStyles.regularRubik14Gray94,
          ),
          const SizedBox(
            height: 35,
          ),
          TextFieldContainer(
            hint: 'Email',
            label: 'example@example.com',
            padding: 0,
            controller: emailController,
          ),
          const SizedBox(
            height: 35,
          ),
          Center(
            child: CustomButton(
              onTap: () {
                Navigator.pop(context);
                verificationBottomSheet(context);
              },
              name: 'Continue',
              width: KSize.getWidth(context, 95),
              height: KSize.getHeight(context, 45),
              color: KColor.secondary,
              textColor: KColor.white,
            ),
          ),
        ],
      ),
    ),
  );
}

verificationBottomSheet(BuildContext context) {
  showSheet(
    context,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GrayHandle(),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Enter 4 Digits Code',
            // style: TextStyles.mediumPoppins24Black24,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Enter the 4 digits code that you received on your email.',
            // style: TextStyles.regularRubik14Gray94,
          ),
          const SizedBox(
            height: 35,
          ),
          //Pin code,
          PinCodeTextField(
            appContext: context,
            length: 4,
            onChanged: (value) {},
            onCompleted: (value) {
              Navigator.pop(context);
            },
            obscureText: false,
            animationType: AnimationType.fade,
            // textStyle: TextStyles.boldPTSans26Green7F,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(8),
              fieldHeight: 65,
              fieldWidth: 65,
              activeFillColor: KColor.primary,
              inactiveColor: KColor.black54,
              selectedColor: KColor.black54,
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Center(
            child: CustomButton(
              onTap: () {
                Navigator.pop(context);
                resetPasswordBottomSheet(context);
              },
              name: 'Continue',
              width: KSize.getWidth(context, 100),
              height: KSize.getHeight(context, 45),
              color: KColor.secondary,
              textColor: KColor.white,
            ),
          ),
        ],
      ),
    ),
  );
}

resetPasswordBottomSheet(BuildContext context) {
  var value;
  showSheet(
    context,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GrayHandle(),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Reset password',
            // style: TextStyles.mediumPoppins24Black24,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Set the new password for your account so you can login and access all the features.',
            // style: TextStyles.regularRubik14Gray94,
          ),
          const SizedBox(
            height: 35,
          ),
          TextFieldContainer(
            hint: 'New password',
            label: 'New password',
            suffixIcon: IconButton(
                onPressed: () {
                  value = value;
                },
                icon: value
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined)),
            obscureText: value,
            controller: TextEditingController(),
            padding: 0,
          ),
          const SizedBox(
            height: 35,
          ),
          TextFieldContainer(
            hint: 'Re-enter password',
            label: 'Re-enter password',
            suffixIcon: IconButton(
                onPressed: () {},
                icon: value
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined)),
            obscureText: value,
            padding: 0,
            controller: TextEditingController(),
          ),
          const SizedBox(
            height: 35,
          ),
          Center(
            child: CustomButton(
              onTap: () {
                Navigator.pop(context);
              },
              name: 'Update Password',
              width: KSize.getWidth(context, 60),
              height: KSize.getHeight(context, 30),
              color: KColor.secondary,
              textColor: KColor.white,
            ),
          ),
        ],
      ),
    ),
  );
}
