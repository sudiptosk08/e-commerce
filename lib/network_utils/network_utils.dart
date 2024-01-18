// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:ecommerce_app/utils/colors/app_colors.dart';

import '../constant/shared_preference_constant.dart';
import 'api.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class Network {
  static String noInternetMessage = "Check your connection!";

  static getRequest(String endPoint,
      {bool requiretoken = true, bool nobaseUrl = false}) async {
    if (await isNetworkAvailable()) {
      Response response;
      var accesstoken = getStringAsync(token);
      var headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      if (requiretoken) {
        var header = {"Authorization": "Bearer $accesstoken"};
        headers.addAll(header);
      }

      print('\nURL: ${API.base}$endPoint');
      print("Headers: $headers\n");
      if (requiretoken) {
        response = await get(
            Uri.parse(nobaseUrl ? endPoint : '${API.base}$endPoint'),
            headers: headers);
      } else {
        response =
            await get(Uri.parse(nobaseUrl ? endPoint : '${API.base}$endPoint'));
      }

      return response;
    } else {
      throw noInternetMessage;
    }
  }

  static postRequest(String endPoint, body, {bool requiretoken = true}) async {
    if (await isNetworkAvailable()) {
      var accesstoken = getStringAsync(token);
      var headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      if (requiretoken) {
        var header = {"Authorization": "Bearer $accesstoken"};
        headers.addAll(header);
      }
      print('\nURL: ${API.base}$endPoint');
      print("Headers: $headers");
      print('Request Body: ${jsonEncode(body)}\n');

      Response response = await post(Uri.parse('${API.base}$endPoint'),
          body: jsonEncode(body), headers: headers);

      //print('Response: $response');
      return response;
    } else {
      throw noInternetMessage;
    }
  }
  static multiPartRequest(String endPoint, String methodName,
      {body, List<File>? files, String filedName = 'images'}) async {
    if (await isNetworkAvailable()) {
      var request = MultipartRequest(
        methodName.toUpperCase(),
        Uri.parse('${API.base}' + '$endPoint'),
      );
      print('URL: ${API.base}$endPoint');

      var accessToken = getStringAsync(token);

      Map<String, String> headers = {
        "Authorization": "Bearer $accessToken",
      };

      if (body != null) request.fields.addAll((body));
      if (files!.isNotEmpty) {
        files.forEach((file) async {
          request.files.add(await MultipartFile.fromPath(
            filedName,
            file.path,
            contentType: MediaType(
              mime(file.path)!.split('/')[0],
              mime(file.path)!.split('/')[1],
            ),
          ));
        });
      }
      print('Request Files: ${request.files}');

      request.headers.addAll(headers);

      print('Headers: ${request.headers}');
      print('Request Fields: ${request.fields}');
      StreamedResponse streamedResponse = await request.send();
      Response response = await Response.fromStream(streamedResponse);
      return response;
    } else {
      throw noInternetMessage;
    }
  }
  
  static multiPartRequestSingle(
    String endPoint,
    String methodName, {
    body,
    File? file,
    filename,
    fileFieldName,
    type,
    subType,
  }) async {
    if (await isNetworkAvailable()) {
      /// MultiPart request ///
      var request = MultipartRequest(
        methodName.toUpperCase(),
        Uri.parse(API.base + endPoint),
      );
      print('URL: ${API.base}$endPoint');

      var accesstoken = getStringAsync(token);

      Map<String, String> headers = {
        "Authorization": "Bearer $accesstoken",
      };

      if (file != null && filename != null) {
        request.files.add(
          MultipartFile(
            'file',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: filename,
            contentType: MediaType(type!, subType!),
          ),
        );
      }
      print('Request Files: ${request.files}');
      request.headers.addAll(headers);
      if (body != null) request.fields.addAll((body));

      print('Headers: ${request.headers}');
      print('Request: $request');
      StreamedResponse streamedResponse = await request.send();
      Response response = await Response.fromStream(streamedResponse);
      print('Response: ${response.statusCode} ${response.body}');
      return response;
    } else {
      throw noInternetMessage;
    }
  }

  static handleResponse(Response response) async {
    // print("response is : ${response.body}");
    if (!await isNetworkAvailable()) {
      toast('No network available');
    } else if (response.statusCode >= 200 && response.statusCode <= 210) {
      print('\nSuccessCode: ${response.statusCode}');
      print('SuccessResponse: ${response.body}\n');

      if (response.body.isNotEmpty) {
        return json.decode(response.body);
      } else {
        return response.body;
      }
    } else {
      print('\nErrorCode: ${response.statusCode}');
      print("ErrorResponse: ${response.body}\n");

      if (response.statusCode == 403) {
        /// Session expired
        toast(
          "${jsonDecode(response.body)['message']}",
          bgColor: KColor.red,
        );

        setValue(isLoggedIn, false);
      } else if (response.statusCode == 422) {
        /// Custom validation message
        toast(
          '${jsonDecode(response.body)['message']}',
          bgColor: KColor.red,
        );
      } else if (response.statusCode == 429) {
        /// Too many attempts message
        toast(
          '${jsonDecode(response.body)['message']}',
          bgColor: KColor.red,
        );
      } else if (response.statusCode == 402) {
        /// Custom validation message
        toast(
          '${jsonDecode(response.body)['messages']}',
          bgColor: KColor.red,
        );
      } else if (response.statusCode == 401 || response.statusCode == 404) {
        /// Custom message
        if (jsonDecode(response.body)['message'] == "Unauthenticated.") {
          toast('Login to continue...', bgColor: KColor.red);

          // setValue(LOGGED_IN, false);
          // NavigationService.navigateToReplacement(CupertinoPageRoute(builder: (_) => LoginScreen()));
        } else {
          toast('${jsonDecode(response.body)['message']}', bgColor: KColor.red);
        }
        if (jsonDecode(response.body)['unverified'] != null) {
          if (jsonDecode(response.body)['unverified']) {
            if (response.body.isNotEmpty) return json.decode(response.body);
          }
        }
      } else {
        toast('Something went wrong!', bgColor: KColor.red);
      }
    }
  }
}
