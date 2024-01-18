import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/auth/login/login_page.dart';
import 'package:ecommerce_app/features/view/screens/auth/registration/controller/registration_controller.dart';
import 'package:ecommerce_app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../../../utils/size/k_size.dart';
import '../../../global_component/buttons/custom_button.dart';
import '../../../global_component/text_field_container/text_field_container.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => Helper.dissmissKeyboard(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 50,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopify_rounded,
                    color: KColor.primary,
                    size: 90,
                  ),
                  Text(
                    "SIGN-UP",
                    style: TextStyles.headline1.copyWith(color: KColor.black54),
                  ),
                  const SizedBox(
                    height: 25,
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
                  const SizedBox(
                    height: 25,
                  ),
                  Consumer(builder: (context, ref, _) {
                    final authState = ref.watch(signupProvider);
                    return CustomButton(
                      textColor: KColor.white,
                      name: authState is LoadingState
                          ? 'Please wait...'
                          : 'Sign Up',
                      onTap: () {
                        if (password.text == confirmPassword.text) {
                          if (authState is! LoadingState) {
                            ref.read(signupProvider.notifier).register(
                                  first_Name: firstName.text,
                                  last_Name: lastName.text,
                                  phone: userPhone.text,
                                  password: password.text,
                                  confirmPassword: confirmPassword.text,
                                );
                          } else {
                            toast("Is not validate",
                                bgColor: KColor.errorRedText);
                          }
                        } else {
                          toast("Password is not match!",
                              bgColor: KColor.errorRedText);
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
                        'I have an account ?',
                        style: TextStyles.bodyText1
                            .copyWith(color: KColor.black54),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
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
      ),
    );
  }
}
