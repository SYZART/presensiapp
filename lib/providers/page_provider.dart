import 'package:flutter/material.dart';
import 'package:presensiapp/models/user_model.dart';

class PageProvider with ChangeNotifier {
  int _index = 0;
  int get index => _index;
  set index(int idx) {
    _index = idx;
    notifyListeners();
  }

  logout(UniqueKey idx) {
    Log.key = UniqueKey();

    notifyListeners();
  }
}
