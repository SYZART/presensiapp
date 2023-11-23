import 'dart:convert';

import 'package:intl/intl.dart';

UsersModel usersModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  String message;
  List<DataUser> data;

  UsersModel({
    required this.message,
    required this.data,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        message: json["message"],
        data:
            List<DataUser>.from(json["data"].map((x) => DataUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataUser {
  String idUsers;
  String name;
  String password;
  String role;
  String gender;
  String jabatan;

  DataUser({
    required this.idUsers,
    required this.name,
    required this.password,
    required this.role,
    required this.gender,
    required this.jabatan,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        idUsers: json["id_users"],
        name: json["name"],
        password: json["password"],
        role: json["role"],
        gender: json["gender"],
        jabatan: json["jabatan"],
      );

  Map<String, dynamic> toJson() => {
        "id_users": idUsers,
        "name": name,
        "password": password,
        "role": role,
        "gender": gender,
        "jabatan": jabatan,
      };
}

class ID {
  static String idUser = '';
  static String dateNow = DateTime.now().toString().split(' ')[0];
  static String jamMasuk = DateFormat.Hm().format(DateTime.now());
}
