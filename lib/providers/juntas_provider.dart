import 'package:flutter/material.dart';
import 'package:votaciones_movil/models/juntas_data.dart';

class JuntaProvider with ChangeNotifier {
  JuntaData? _junta;

  JuntaData? get junta => _junta;

  void setJunta(JuntaData junta) {
    _junta = junta;
    notifyListeners(); // Notifica a los widgets que algo cambió
  }

  void clearJunta() {
    _junta = null;
    notifyListeners();
  }
}
