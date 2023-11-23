import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:presensiapp/models/schedule_model.dart';

class ScheduleServices {
  final baseUrl = 'https://be-copy.vercel.app';
  Future<ShceduleUserModel> getMySchedule(String idUser) async {
    var url = '$baseUrl/schedules/$idUser';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      return shceduleUserModelFromJson(response.body);
    } else if (response.statusCode == 408) {
      throw Exception('timeout');
    } else {
      throw Exception('Get My Schedule failed !');
    }
  }

  Future<ShceduleUserModel> getMyScheduleToday(
      String idUser, String date) async {
    var url = '$baseUrl/schedules/$idUser/$date';
    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      return shceduleUserModelFromJson(response.body);
    } else if (response.statusCode == 408) {
      throw Exception('timeout');
    } else {
      throw Exception('Get My Schedule failed !');
    }
  }
}
