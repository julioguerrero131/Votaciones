import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:votaciones_movil/models/users_data.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<UserData>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => UserData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}
