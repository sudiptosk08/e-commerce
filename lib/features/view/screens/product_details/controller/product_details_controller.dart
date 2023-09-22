import 'package:ecommerce_app/constant/base_state.dart';
import 'package:ecommerce_app/features/view/screens/product_details/model/product_details_model.dart';
import 'package:ecommerce_app/features/view/screens/product_details/state/product_details_state.dart';
import 'package:ecommerce_app/network_utils/api.dart';
import 'package:ecommerce_app/network_utils/network_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Providers
final productDetailsProvider =
    StateNotifierProvider<ProductDetailsController, BaseState>(
  (ref) => ProductDetailsController(ref: ref),
);

class ProductDetailsController extends StateNotifier<BaseState> {
  final Ref? ref;

  ProductDetailsController({this.ref}) : super(const InitialState());
  ProductDetailsModel? productDetailsModel;
  late int quantity;
   var size = "";
   var color = "";
   var colorId = 0;
   var sizeId = 0;
  List<Map<String, dynamic>> attributeList = [];
  var totalPrice = 0;
  var sizeAdditionalPrice = 0;
  var colorAdditionalPrice = 0;
  var typeAdditionalPrice = 0;

  Future fetchProductsDetails(slug) async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.productDetails(slug: slug)),
      );
      if (responseBody != null) {
        productDetailsModel = ProductDetailsModel.fromJson(responseBody);
        print("ProductDetailsBody ========= $responseBody");
        getAttributes(responseBody);
        state = ProductDetailsSuccessState(productDetailsModel);
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }

  getAttributes(responsebody) {
    Map<String, dynamic> jsonData = responsebody;
// Get the "attributes" dictionary from the JSON data
    Map<String, dynamic> attributes = jsonData["data"]["variants"];

// Find the length of the "attributes" dictionary
    int attributesLength = attributes.length;

// Generate a list of attributes from the "attributes" dictionary

    attributes.forEach((key, value) {
      attributeList.add({
        "attributeName": key,
        "attributeValues": List<Map<String, dynamic>>.from(value),
      });
    });

// Print the length and the list of attributes
    print('Attributes Length: $attributesLength');
    print('List of Attributes: $attributeList');
    print('List of Size: ${attributeList[0]}');
    print('List of Color: ${attributeList[1]}');
  }
}
