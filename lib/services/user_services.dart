import 'dart:convert';

import 'package:presensiapp/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<UsersModel> getAll() async {
    var urls = 'https://be-copy.vercel.app/users';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(urls), headers: headers);
    if (response.statusCode == 200) {
      return UsersModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Get users failed!');
    }
  }
}
