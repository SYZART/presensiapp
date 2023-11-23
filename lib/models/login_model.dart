import 'dart:convert';

class LoginModel {
  String message;
  Data data;

  LoginModel({
    required this.message,
    required this.data,
  });

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String idUsers;
  String password;
  String name;
  String gender;
  String jabatan;

  Data({
    required this.idUsers,
    required this.password,
    required this.name,
    required this.gender,
    required this.jabatan,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idUsers: json["id_users"],
        password: json["password"],
        name: json["name"],
        gender: json["gender"],
        jabatan: json["jabatan"],
      );

  Map<String, dynamic> toJson() => {
        "id_users": idUsers,
        "password": password,
        "name": name,
        "gender": gender,
        "jabatan": jabatan,
      };
}
