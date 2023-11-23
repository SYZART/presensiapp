// import 'package:flutter/material.dart';
// import 'package:presensiapp/models/user_model.dart';
// import 'package:presensiapp/services/user_services.dart';

// enum ResultStateUser { loading, hasData, error, noData }

// class UserProvider with ChangeNotifier {
//   ResultStateUser? _state;

//   String _message = '';

//   ResultStateUser? get state => _state;

//   String get message => _message;
//   late UsersModel _usersModel;

//   UsersModel get result => _usersModel;

//   Future<dynamic> getAll() async {
//     try {
//       _state = ResultStateUser.loading;
//       notifyListeners();

//       UsersModel res = await UserService().getAll();
//       print('-');
//       if (res.data.isEmpty) {
//         _state = ResultStateUser.noData;
//         notifyListeners();
//         return _message = 'Tidak ada data';
//       } else {
//         _state = ResultStateUser.hasData;
//         notifyListeners();
//         return _usersModel = res;
//       }
//     } catch (e) {
//       _state = ResultStateUser.error;
//       notifyListeners();
//       return _message = 'Error --> $e';
//     }
//   }
// }
