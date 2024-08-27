// ignore_for_file: avoid_print

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/navigation_bar.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final userProfileUpdateProvider =
    StateNotifierProvider<UserProfileUpdateController, BaseState>(
  (ref) => UserProfileUpdateController(ref: ref),
);

/// Controllers
class UserProfileUpdateController extends StateNotifier<BaseState> {
  final Ref? ref;

  UserProfileUpdateController({this.ref}) : super(const InitialState());

  Future updateUserProfile( {
    required String firstName,
    required String lastName,
    required String userName,
    required String phone,
    required String email,
    required String password,
  }) async {
    state = const LoadingState();
    dynamic responseBody;
    var requestBody = {
      'first_name': firstName,
      'last_name': lastName,
      'username': userName,
      'phone': phone,
      'email': email,
      'password': password,
    };
    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.userProfileUpdate, requestBody),
      );
      if (responseBody != null) {
        toast("${responseBody['message']}", bgColor: KColor.green);

        NavigationService.navigateToReplacement(
          CupertinoPageRoute(
            builder: (context) => const NavigationBarScreen(
              page: '3',
            ),
          ),
        );
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = const ErrorState();
    }
  }
}
