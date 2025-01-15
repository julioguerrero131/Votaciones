import 'dart:convert';
import 'package:http/http.dart' as http;

Future<UserData> fetchUsers() async {
  final response = await http
      .get(Uri.parse('https://api-observacion-electoral.frative.com/api/usuarios'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return UserData.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class UserData {
  final String cedula;
  final String user;
  final String nombres;
  final String apellidos;
  final String genero;
  final String direccion;
  final String telefono; 
  final String telefonoAux; 

  const UserData({
    required this.cedula,
    required this.user,
    required this.nombres,
    required this.apellidos,
    required this.genero, 
    required this.direccion,
    required this.telefono,
    required this.telefonoAux
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'cedula': String cedula,
        'user': String user,
        'nombres': String nombres,
        'apellidos': String apellidos,
        'genero': String genero,
        'direccion': String direccion,
        'telefono': String telefono,
        'telefono_aux': String telefonoAux,
      } =>
        UserData(
          cedula: cedula,
          user: user,
          nombres: nombres,
          apellidos: apellidos,
          genero: genero,
          direccion: direccion,
          telefono: telefono,
          telefonoAux: telefonoAux
        ),
      _ => throw const FormatException('Failed to load user data.'),
    };
  }
}