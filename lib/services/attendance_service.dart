import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:presensiapp/models/attendance_model.dart';

class AttendanceService {
  final baseUrl = 'https://be-copy.vercel.app';
  Future<CreateAttendance> createAttendance(Params params) async {
    var url = '$baseUrl/attendance/create-attendance';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'id_user': params.idUser,
      'date': params.dateTime,
      'jam_masuk': params.jamMasuk,
      'jam_keluar': params.jamKeluar,
      'alamat': params.alamat,
      'status': params.status
    });
    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200) {
      return createAttendanceFromJson(response.body);
    } else {
      throw Exception('Error');
    }
  }

  Future<CreateAttendance> updateAttendance(Params params) async {
    var url = '$baseUrl/attendance/update-attendance';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'id_user': params.idUser,
      'date': params.dateTime,
      'jam_keluar': params.jamKeluar,
    });
    debugPrint(body.toString());
    http.Response response =
        await http.patch(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200) {
      return createAttendanceFromJson(response.body);
    } else {
      throw Exception('Error');
    }
  }

  Future<AttendanceModel> getMyAttendance(String idUser) async {
    var url = '$baseUrl/attendance/$idUser';
    var headers = {'Content-Type': 'application/json'};

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return attendanceModelFromJson(response.body);
    } else {
      throw Exception('Error Get Attendance');
    }
  }

  Future<AttendanceModel> getMyAttendanceToday(
      String idUser, String date) async {
    var url = '$baseUrl/attendance/today/$idUser/$date';
    var headers = {'Content-Type': 'application/json'};

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return attendanceModelFromJson(response.body);
    } else {
      throw Exception('Error Get Attendance');
    }
  }
}

//  {required String idUser,
//       required DateTime dateTime,
//       required String jamMasuk,
//       required String alamat,
//       required String status
class Params {
  late String idUser;
  late String dateTime;
  late String jamMasuk;
  late String alamat;
  late String status;
  String jamKeluar = '23.59';
}
