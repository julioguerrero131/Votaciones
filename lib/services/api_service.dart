import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:votaciones_movil/models/juntas_data.dart';
import 'package:votaciones_movil/models/users_data.dart';
import 'package:votaciones_movil/models/users_juntas_data.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  // Usuarios
  Future<List<UserData>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => UserData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  Future<List<UserData>> fetchUserById(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => UserData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  // Juntas
  Future<List<JuntaData>> fetchJuntas() async {
    final response = await http.get(
        Uri.parse('$baseUrl/juntas'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => JuntaData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  Future<List<UsuarioJuntaData>> fetchUsuariosJuntas() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/juntas-usuario'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => UsuarioJuntaData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  Future<List<JuntaData>> fetchJuntaById(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/juntas/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => JuntaData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  Future<List<JuntaData>> fetchJuntasDelUsuarioById(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/juntas/usuario/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => JuntaData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  } 
}