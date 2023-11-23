import 'dart:convert';

ShceduleUserModel shceduleUserModelFromJson(String str) =>
    ShceduleUserModel.fromJson(json.decode(str));

String shceduleUserModelToJson(ShceduleUserModel data) =>
    json.encode(data.toJson());

class ShceduleUserModel {
  String message;
  List<DataSchedule> data;

  ShceduleUserModel({
    required this.message,
    required this.data,
  });

  factory ShceduleUserModel.fromJson(Map<String, dynamic> json) =>
      ShceduleUserModel(
        message: json["message"],
        data: List<DataSchedule>.from(
            json["data"].map((x) => DataSchedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataSchedule {
  int id;
  String idUser;
  DateTime date;
  int shiftId;

  DataSchedule({
    required this.id,
    required this.idUser,
    required this.date,
    required this.shiftId,
  });

  factory DataSchedule.fromJson(Map<String, dynamic> json) => DataSchedule(
        id: json["id"],
        idUser: json["id_user"],
        date: DateTime.parse(json["date"]),
        shiftId: json["shift_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "shift_id": shiftId,
      };
}
