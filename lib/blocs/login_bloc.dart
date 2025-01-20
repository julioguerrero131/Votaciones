import 'package:votaciones_movil/models/users.dart';
import 'package:votaciones_movil/services/api_service.dart';

class LoginBloc {
  final ApiService apiService;

  LoginBloc(this.apiService);

  Future<UserData> login(String username, String password) async {
    try {
      final users = await apiService.fetchUsers();

      // Busca el usuario autenticado
    return users.firstWhere(
      (user) => user.cedula == username && user.cedula == password,
      orElse: () => UserData.empty,
    );
    } catch (e) {
      // Ocurrio un error
      print('Error during login: $e');
      return UserData.empty;
    }
  }
}
