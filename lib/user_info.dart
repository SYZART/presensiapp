import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class UsersInfo {
  Future setIdUser(String? value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString('idUser', value!);
  }

  Future<String?> getIdUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("idUser");
  }

  Future logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
