// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:nb_utils/nb_utils.dart';

class SharedPreferencesHelper {
  var contactValue;
  

  contact(String contact) async {
    SharedPreferences.getInstance().then(
      (pref) {
        pref.setString('contact', contact);
        contactValue = pref.getString("contact") ?? "";
      },
    );
  }

 

  Future<bool> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("token", token);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? '';
  }

}
