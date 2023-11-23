import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) =>
    AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) =>
    json.encode(data.toJson());

class AttendanceModel {
  String message;
  List<Datum> data;

  AttendanceModel({
    required this.message,
    required this.data,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String idUser;
  DateTime date;
  String jamMasuk;
  String jamKeluar;
  String alamat;
  String status;

  Datum({
    required this.id,
    required this.idUser,
    required this.date,
    this.jamMasuk = '-',
    this.jamKeluar = '-',
    required this.alamat,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idUser: json["id_user"],
        date: DateTime.parse(json["date"]),
        jamMasuk: json["jam_masuk"],
        jamKeluar: json["jam_keluar"],
        alamat: json["alamat"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "jam_masuk": jamMasuk,
        "jam_keluar": jamKeluar,
        "alamat": alamat,
        "status": status,
      };
}

CreateAttendance createAttendanceFromJson(String str) =>
    CreateAttendance.fromJson(json.decode(str));

String createAttendanceToJson(CreateAttendance data) =>
    json.encode(data.toJson());

class CreateAttendance {
  String message;
  String data;

  CreateAttendance({
    required this.message,
    required this.data,
  });

  factory CreateAttendance.fromJson(Map<String, dynamic> json) =>
      CreateAttendance(
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
      };
}
