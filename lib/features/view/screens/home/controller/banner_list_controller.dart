// ignore_for_file: avoid_print

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/home/model/banner_list_model.dart';
import 'package:ecommerce_app/features/view/screens/home/state/banner_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../network_utils/network_utils.dart';

/// Providers
final sliderProvider = StateNotifierProvider<SliderController, BaseState>(
  (ref) => SliderController(ref: ref),
);

/// Controllers
class SliderController extends StateNotifier<BaseState> {
  final Ref? ref;
  SliderController({this.ref}) : super(const InitialState());
  BannerListModel? homeSliderModel;

  Future fetchSliderDetails() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody =
          await Network.handleResponse(await Network.getRequest(API.banner));
      if (responseBody != null) {
        homeSliderModel = BannerListModel.fromJson(responseBody);
        state = BannerSuccessState(homeSliderModel);
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
