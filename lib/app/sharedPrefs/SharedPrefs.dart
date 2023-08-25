import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefss {

  addStringToSF(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  removeValues(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey(key);
    if(checkValue == true){
      prefs.remove(key);

    }else{
      debugPrint("Value not present in Shared Prefs");
    }
  }

  Future<String?> getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(key);
    return stringValue;
  }
}