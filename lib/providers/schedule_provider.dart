import 'package:flutter/material.dart';
import 'package:presensiapp/models/schedule_model.dart';
import 'package:presensiapp/models/user_model.dart';
import 'package:presensiapp/services/schedule_service.dart';

enum ResultStateSchduleProvider {
  loading,
  hasData,
  noData,
  error,
  // loadingToday,
  // hasDataToday,
  // noDataToday,
  // errorToday
}

class ScheduleProvider with ChangeNotifier {
  ScheduleProvider() {
    getMySchedule(ID.idUser);
  }

  ResultStateSchduleProvider? _state;
  ResultStateSchduleProvider? get state => _state;
  late ShceduleUserModel _shceduleUserModel;
  ShceduleUserModel get scheduleUserModel => _shceduleUserModel;
  String _message = '';
  String get message => _message;

  final String _dateTimeNow = DateTime.now().toString().split(' ')[0];
  String get dateTimeNow => _dateTimeNow;
  Future<dynamic> getMySchedule(String idUser) async {
    try {
      _state = ResultStateSchduleProvider.loading;
      notifyListeners();

      ShceduleUserModel result = await ScheduleServices().getMySchedule(idUser);

      if (result.message.isNotEmpty) {
        _state = ResultStateSchduleProvider.hasData;
        notifyListeners();
        return _shceduleUserModel = result;
      } else {
        _state = ResultStateSchduleProvider.noData;
        notifyListeners();
        return _message = 'Belum ada jadwal';
      }
    } catch (e) {
      _state = ResultStateSchduleProvider.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

class ScheduleTodayProvider with ChangeNotifier {
  ScheduleTodayProvider() {
    getMyScheduleToday(ID.idUser, ID.dateNow);
  }

  ResultStateSchduleProvider? _stateToday;
  ResultStateSchduleProvider? get stateToday => _stateToday;

  late ShceduleUserModel _shceduleUserModelToday;
  ShceduleUserModel get scheduleUserModelToday => _shceduleUserModelToday;

  String _messageToday = '';
  String get messageToday => _messageToday;

  Future<dynamic> getMyScheduleToday(String idUser, String date) async {
    try {
      _stateToday = ResultStateSchduleProvider.loading;
      notifyListeners();

      ShceduleUserModel result =
          await ScheduleServices().getMyScheduleToday(idUser, date);

      if (result.data.isNotEmpty) {
        _stateToday = ResultStateSchduleProvider.hasData;
        notifyListeners();
        return _shceduleUserModelToday = result;
      } else if (result.data.isEmpty) {
        _stateToday = ResultStateSchduleProvider.noData;
        notifyListeners();
        return _messageToday = 'Belum ada jadwal';
      }
    } catch (e) {
      _stateToday = ResultStateSchduleProvider.error;
      notifyListeners();
      return _messageToday = 'Error --> $e';
    }
  }
}
