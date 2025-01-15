import 'dart:convert';
import 'package:http/http.dart' as http;

Future<ProvinciaData> fetchProvincias() async {
  final response = await http
      .get(Uri.parse('https://api-observacion-electoral.frative.com/api/provincias'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ProvinciaData.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class ProvinciaData {
  final int id;
  final String nombre;

  const ProvinciaData({
    required this.id,
    required this.nombre
  });

  factory ProvinciaData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nombre': String nombre
      } =>
        ProvinciaData(
          id: id,
          nombre: nombre
        ),
      _ => throw const FormatException('Failed to load provincia data.'),
    };
  }
}