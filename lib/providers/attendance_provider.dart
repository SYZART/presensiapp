import 'package:flutter/material.dart';
import 'package:presensiapp/models/attendance_model.dart';
import 'package:presensiapp/models/user_model.dart';
import 'package:presensiapp/services/attendance_service.dart';

enum ResultStateAttendanceProvider {
  loading,
  success,
  error,
  noData,
  outLoading,
  outSuccess,
  outError,
  getMyAttendanceLoading,
  getMyAttendanceHasData,
  getMyAttendanceEmpty,
  getMyAttendanceError,
}

class AttendanceProvider with ChangeNotifier {
  AttendanceProvider() {
    getMyAttendanceToday(ID.idUser, ID.dateNow);
  }
  String _signinValue = 'Masuk';
  String get signinValue => _signinValue;
  set signinValueSet(String val) {
    _signinValue = val;
    notifyListeners();
  }

  ResultStateAttendanceProvider? _stateCreateAttendance;
  ResultStateAttendanceProvider? get stateCreateAttendance =>
      _stateCreateAttendance;
  String _message = '';
  String get message => _message;

  CreateAttendance _createAttendanceModel =
      CreateAttendance(message: '', data: '-');
  CreateAttendance get createAttendanceModel => _createAttendanceModel;

  Future<dynamic> createAttendance(Params params) async {
    try {
      _stateCreateAttendance = ResultStateAttendanceProvider.loading;
      notifyListeners();
      CreateAttendance result =
          await AttendanceService().createAttendance(params);
      if (result.message.isNotEmpty) {
        _stateCreateAttendance = ResultStateAttendanceProvider.success;
        notifyListeners();
        return _createAttendanceModel = result;
      }
    } catch (e) {
      _stateCreateAttendance = ResultStateAttendanceProvider.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  ResultStateAttendanceProvider? _stateUpdateAttendance;
  ResultStateAttendanceProvider? get stateUpdateAttendance =>
      _stateUpdateAttendance;
  CreateAttendance _updateAttendanceModel =
      CreateAttendance(message: '', data: '-');
  CreateAttendance get updateAttendanceModel => _updateAttendanceModel;
  Future updateAttendance(Params params) async {
    try {
      _stateUpdateAttendance = ResultStateAttendanceProvider.outLoading;
      notifyListeners();
      CreateAttendance result =
          await AttendanceService().updateAttendance(params);
      if (result.message.isNotEmpty) {
        _stateUpdateAttendance = ResultStateAttendanceProvider.outSuccess;
        notifyListeners();
        return _updateAttendanceModel = result;
      }
    } catch (e) {
      _stateUpdateAttendance = ResultStateAttendanceProvider.outError;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  late AttendanceModel _attendanceModel;
  AttendanceModel get attendanceModel => _attendanceModel;
  ResultStateAttendanceProvider? _stateMyAttendance;
  ResultStateAttendanceProvider? get stateMyAttendance => _stateMyAttendance;
  Future getMyAttendance(String idUser) async {
    try {
      _stateMyAttendance = ResultStateAttendanceProvider.getMyAttendanceLoading;
      notifyListeners();
      AttendanceModel result =
          await AttendanceService().getMyAttendance(idUser);
      if (result.data.isNotEmpty) {
        _stateMyAttendance =
            ResultStateAttendanceProvider.getMyAttendanceHasData;
        notifyListeners();
        return _attendanceModel = result;
      } else if (result.data.isEmpty) {
        _stateMyAttendance = ResultStateAttendanceProvider.getMyAttendanceEmpty;
        notifyListeners();
        return;
      }
    } catch (e) {
      _stateMyAttendance = ResultStateAttendanceProvider.getMyAttendanceError;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  AttendanceModel _attendanceToday = AttendanceModel(message: '', data: [
    Datum(id: 0, idUser: '', date: DateTime.now(), alamat: '', status: '')
  ]);
  AttendanceModel get attendanceToday => _attendanceToday;
  ResultStateAttendanceProvider? _statAttendanceToday;
  ResultStateAttendanceProvider? get statAttendanceToday =>
      _statAttendanceToday;

  Future getMyAttendanceToday(String idUser, String date) async {
    try {
      _statAttendanceToday = ResultStateAttendanceProvider.loading;
      notifyListeners();
      AttendanceModel result =
          await AttendanceService().getMyAttendanceToday(idUser, date);
      debugPrint(result.data.isEmpty.toString());
      if (result.data.isEmpty) {
        _statAttendanceToday = ResultStateAttendanceProvider.noData;
        notifyListeners();
        return;
      } else if (result.data.isNotEmpty) {
        _statAttendanceToday = ResultStateAttendanceProvider.success;
        notifyListeners();
        return _attendanceToday = result;
      }
    } catch (e) {
      _statAttendanceToday = ResultStateAttendanceProvider.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

class AttendanceRange with ChangeNotifier {
  AttendanceRange() {
    getAttendanceRangeDate(ID.idUser, '2023-11');
  }
  AttendanceModel _attendanceRange = AttendanceModel(message: '', data: [
    Datum(id: 0, idUser: '', date: DateTime.now(), alamat: '', status: '')
  ]);
  AttendanceModel get attendanceRange => _attendanceRange;
  ResultStateAttendanceProvider? _statAttendanceRange;
  ResultStateAttendanceProvider? get statAttendanceRange =>
      _statAttendanceRange;
  Future getAttendanceRangeDate(String idUser, String date) async {
    try {
      _statAttendanceRange = ResultStateAttendanceProvider.loading;
      notifyListeners();
      AttendanceModel res =
          await AttendanceService().getAttendanceRangeDate(idUser, date);
      if (res.data.isEmpty) {
        _statAttendanceRange = ResultStateAttendanceProvider.noData;
        notifyListeners();
        return;
      } else {
        _statAttendanceRange = ResultStateAttendanceProvider.success;
        notifyListeners();
        _attendanceRange = res;
        notifyListeners();
      }
    } catch (e) {
      _statAttendanceRange = ResultStateAttendanceProvider.error;
      notifyListeners();
      return 'Error --> $e';
    }
  }
}
