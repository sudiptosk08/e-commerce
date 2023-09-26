// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

/// Providers
final addReviewProvider =
    StateNotifierProvider<AddReviewsController, BaseState>(
  (ref) => AddReviewsController(ref: ref),
);

/// Controllers
class AddReviewsController extends StateNotifier<BaseState> {
  final Ref? ref;

  AddReviewsController({this.ref}) : super(const InitialState());

  Future addReview(
    id,
    ratings,
    reviews,
    images,
  ) async {
    // if (images != null) files.add({'value': images});
    var responseBody;
    print("Images :$images");
    Map<String, String> requestBody;

    // SocialAccounts social = SocialAccounts(facebook: facebook, twitter: twitter, instragram: instra, discord: discord);

    requestBody = {
      'product_id': id.toString(),
      'review': reviews.toString(),
      'rating': ratings.toString(),
    };

    if (id == "") {
      toast("Enter Product Id ", bgColor: KColor.red);
    } else if (reviews == "") {
      toast("Enter some reviews description", bgColor: KColor.red);
    } else if (ratings == "") {
      toast("Add Rating", bgColor: KColor.red);
    } else {
      try {
        responseBody = await Network.handleResponse(
          await Network.multiPartRequest(API.reviews, 'POST',
              body: requestBody, files: images),
        );
        if (responseBody != null) {
          toast("${responseBody['message']}", bgColor: KColor.green);
          NavigationService.popNavigate();
        } else {
          state = const ErrorState();
        }
      } catch (error) {
        state = const ErrorState();
      }
    }
  }
}
