import 'package:flutter/material.dart';
import 'package:presensiapp/models/login_model.dart';
import 'package:presensiapp/models/user_model.dart';
import 'package:presensiapp/providers/attendance_provider.dart';
import 'package:presensiapp/services/auth_service.dart';
import 'package:presensiapp/user_info.dart';

enum ResultStateAuthProvider {
  loading,
  success,
  unregisterId,
  error,
  wrongPassword,
  profileLoading,
  profileNotfound,
  profileSuccess,
  profileError
}

class AuthProvider with ChangeNotifier {
  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  void checkRememberMe() {
    _rememberMe = !rememberMe;
    notifyListeners();
  }

  bool _showPassword = true;
  bool get showPassword => _showPassword;

  void showHidePassword() {
    _showPassword = !showPassword;
    notifyListeners();
  }

  ResultStateAuthProvider? _state;

  String _message = '';

  ResultStateAuthProvider? get state => _state;

  String get message => _message;

  late LoginModel _loginModel;

  LoginModel get result => _loginModel;

  Future<dynamic> login(String idUser, String password) async {
    try {
      _state = ResultStateAuthProvider.loading;
      notifyListeners();

      LoginModel res = await AuthServices().login(idUser, password);

      if (res.message == "Id Karyawan Belum terdaftar") {
        _state = ResultStateAuthProvider.unregisterId;
        notifyListeners();
        return _message = res.message;
      } else if (res.message == 'Password salah') {
        _state = ResultStateAuthProvider.wrongPassword;
        notifyListeners();
        return _message = res.message;
      } else {
        if (_rememberMe) {
          await UsersInfo()
              .setIdUser(res.data.idUsers)
              .then((value) => ID.idUser = res.data.idUsers)
              .then((value) => getMyProfile(res.data.idUsers));
          _state = ResultStateAuthProvider.success;
          notifyListeners();
          return;
        }
        _state = ResultStateAuthProvider.success;
        ID.idUser = res.data.idUsers;
        await getMyProfile(ID.idUser);
        notifyListeners();

        return _loginModel = res;
      }
    } catch (e) {
      _state = ResultStateAuthProvider.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  ResultStateAuthProvider? _stateProfile;

  ResultStateAuthProvider? get stateProfile => _stateProfile;

  late UsersModel _usersModel;

  UsersModel get usersModel => _usersModel;

  Future<dynamic> getMyProfile(String idUser) async {
    try {
      _stateProfile = ResultStateAuthProvider.profileLoading;
      notifyListeners();

      UsersModel res = await AuthServices().getMyProfile(idUser);
      if (res.data.isNotEmpty) {
        _stateProfile = ResultStateAuthProvider.profileSuccess;
        notifyListeners();
        return _usersModel = res;
      } else if (res.data.isEmpty) {
        _stateProfile = ResultStateAuthProvider.profileNotfound;
        notifyListeners();
        return;
      }
    } catch (e) {
      _stateProfile = ResultStateAuthProvider.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
