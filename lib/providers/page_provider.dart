import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  int _index = 0;
  int get index => _index;
  set index(int idx) {
    _index = idx;
    notifyListeners();
  }
}
