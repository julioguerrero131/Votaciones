import 'package:votaciones_movil/models/juntas.dart';
import 'package:votaciones_movil/services/api_service.dart';

class ReporteBloc {
  final ApiService apiService;

  ReporteBloc(this.apiService);

  // Obtiene todas las juntas asociadas a un usuario por su ID.
  Future<List<JuntaData>> obtenerJuntasPorUsuario(int userId) async {
    try {
      return await apiService.fetchJuntasDelUsuarioById(userId);
    } catch (e) {
      print('Error al obtener juntas del usuario: $e');
      return [];
    }
  }

  Future<List<String>> obtenerNombresDeJuntasPorUsuario(int userId) async {
    try {
      // Obtener la lista de juntas
      final List<JuntaData> juntas =
          await apiService.fetchJuntasDelUsuarioById(userId);

      // Extraer los nombres de las juntas
      return juntas.map((junta) => junta.nombre).toList();
    } catch (e) {
      // Manejo de errores
      print('Error al obtener los nombres de las juntas del usuario: $e');
      return [];
    }
  }
}
