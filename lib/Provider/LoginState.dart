// ignore: file_names
import 'package:flutter/cupertino.dart';

class LoginState extends ChangeNotifier {
  bool _isLoggedIn = false;
  late Map _user = {};

  bool get isLoggedIn => _isLoggedIn;
  Map get user => _user;

  void login(Map user) {
    _user = user;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _user = {};
    _isLoggedIn = false;
    notifyListeners();
  }
}
