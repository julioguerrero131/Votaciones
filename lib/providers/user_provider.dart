import 'package:flutter/material.dart';
import 'package:votaciones_movil/models/users.dart';

class UserProvider with ChangeNotifier {
  UserData? _user;

  UserData? get user => _user;

  void setUser(UserData user) {
    _user = user;
    notifyListeners(); // Notifica a los widgets que algo cambió
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
