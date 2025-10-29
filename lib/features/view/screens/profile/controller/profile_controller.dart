// ignore_for_file: avoid_print

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/profile/model/profile_model.dart';
import 'package:ecommerce_app/features/view/screens/profile/state/user_profile_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Providers
final profileProvider =
    StateNotifierProvider<ProfileController, BaseState>(
  (ref) => ProfileController(ref: ref),
);

class ProfileController extends StateNotifier<BaseState> {
  final Ref? ref;

  ProfileController({this.ref}) : super(const InitialState());
  ProfileModel? profileModel;


  Future getProfile() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.userProfile),
      );
      if (responseBody != null) {
        profileModel = ProfileModel.fromJson(responseBody);
        print("User Profile ========= $responseBody");
      
        state = ProfileSuccessState(profileModel!);
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }

 
}
