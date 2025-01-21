import 'package:votaciones_movil/models/proceso_electoral.dart';
import 'package:votaciones_movil/services/api_service.dart';

class ActasBloc {
  final ApiService apiService;

  ActasBloc(this.apiService);

  // Obtiene todas las juntas asociadas a un usuario por su ID.
  Future<List<ProcesoElectoralData>> obtenerProcesosElectoralesVigentes() async {
    try {
      return await apiService.fetchProcesosElectoralesVigentes();
    } catch (e) {
      print('Error al obtener juntas del usuario: $e');
      return [];
    }
  }
}
