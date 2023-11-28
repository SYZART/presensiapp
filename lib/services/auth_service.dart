import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:presensiapp/models/login_model.dart';
import 'package:presensiapp/models/user_model.dart';

class AuthServices {
  final baseUrl = 'https://be-copy.vercel.app';

  Future<LoginModel> login(String idUser, String password) async {
    var url = '$baseUrl/auth/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'id_user': idUser,
      'password': password,
    });
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      return LoginModel(
          message: 'Id Karyawan Belum terdaftar',
          data: Data(
              id: 0,
              password: password,
              name: '',
              gender: '',
              idUsers: '',
              jabatan: ''));
    } else if (response.statusCode == 401) {
      return LoginModel(
          message: 'Password salah',
          data: Data(
              id: 0,
              password: password,
              name: '',
              gender: '',
              idUsers: '',
              jabatan: ''));
    } else {
      throw Exception('Login failed !');
    }
  }

  Future<UsersModel> getMyProfile(String idUser) async {
    var urls = '$baseUrl/users/$idUser';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(urls), headers: headers);
    if (response.statusCode == 200) {
      return UsersModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Get users failed!');
    }
  }
}
