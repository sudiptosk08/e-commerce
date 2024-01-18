// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/constant/navigation_service.dart';
import 'package:ecommerce_app/constant/shared_preference_constant.dart';
import 'package:ecommerce_app/features/view/screens/my_order_details/my_order_details_page.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/utils/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

/// Providers
final addReviewProvider =
    StateNotifierProvider<AddReviewsController, BaseState>(
  (ref) => AddReviewsController(ref: ref),
);

/// Controllers
class AddReviewsController extends StateNotifier<BaseState> {
  final Ref? ref;

  AddReviewsController({this.ref}) : super(const InitialState());

  Future addReviews({
    ratings,
    message,
    id,
    image,
  }) async {
    state = const LoadingState();
    var accesstoken = getStringAsync(token);

    Map<String, String> requestBody = {
      'product_id': id.toString(),
      'rating': ratings.toString(),
      'review': message,
    };
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${API.base}' '${API.reviews}'),
      )
        ..fields.addAll(requestBody)
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken'
        })
        ..files.add(await http.MultipartFile.fromPath("gallery[]", image));
      var response = await request.send();
      var jsonData = await http.Response.fromStream(response);
      log(jsonData.statusCode.toString());
      log(jsonData.body);
      log("Status Code");
      log(response.statusCode.toString());
      log(jsonData.body.toString());
      if (response.statusCode >= 200 && response.statusCode <= 290) {
        final responseBody = jsonDecode(jsonData.body);

        toast(responseBody['message'], bgColor: KColor.green);
        state = const SuccessState();
        NavigationService.navigateToReplacement(
            CupertinoPageRoute(builder: (context) => const OrderDetailsPage()));
        return responseBody;
      } else if (response.statusCode >= 400 && response.statusCode <= 490) {
        var msg = jsonDecode(jsonData.body);
        toast(msg['message'].toString(), bgColor: KColor.red);
        return null;
      } else {
        return null;
      }
    } on http.ClientException catch (err, stackrace) {
      log(stackrace.toString());
      return null;
    } catch (e) {
      return null;
    }
  }
}
