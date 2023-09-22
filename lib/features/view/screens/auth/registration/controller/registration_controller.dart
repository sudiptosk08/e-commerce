// ignore_for_file: avoid_print

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/constant/shared_preference_constant.dart';
import 'package:ecommerce_app/features/view/screens/auth/login/model/user_model.dart';
import 'package:ecommerce_app/features/view/screens/auth/registration/state/registration_state.dart';
import 'package:ecommerce_app/navigation_bar.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final signupProvider = StateNotifierProvider<SignupController, BaseState>(
  (ref) => SignupController(ref: ref),
);

/// Controllers
class SignupController extends StateNotifier<BaseState> {
  final Ref? ref;

  SignupController({this.ref}) : super(const InitialState());
  UserModel? userModel;

  Future register({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'phone': phone,
      'password_confirmation': confirmPassword
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.signup, requestBody),
      );
      print(requestBody);
      if (responseBody != null) {
        if (responseBody['data']['token'] != null) {
          userModel = UserModel.fromJson(responseBody);

          state = SignupSuccessState(userModel);

          toast("${responseBody['message']}", bgColor: KColor.green);
          setValue(isLoggedIn, true);
          setValue(token, userModel!.data.token);
          setValue(rememberToken, userModel!.data.token);
          setValue(userId, userModel!.data.user.id);
          setValue(firstName, userModel!.data.user.firstName);
          setValue(firstName, userModel!.data.user.lastName);
          setValue(userContact, userModel!.data.user.phone);

          NavigationService.navigateToReplacement(FadeRoute(
              page: const NavigationBarScreen(
            page: "0",
          )));
        }
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ErrorState();
      print("Error ResponseBody = $responseBody");
    }
  }
}
