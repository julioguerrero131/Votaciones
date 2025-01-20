class DignidadData {
  final int id;
  final String nombre;
  final String identificacion;

  const DignidadData({
    required this.id,
    required this.nombre,
    required this.identificacion
  });

  factory DignidadData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nombre': String nombre,
        'identificacion': String identificacion
      } =>
        DignidadData(
          id: id,
          nombre: nombre,
          identificacion: identificacion
        ),
      _ => throw const FormatException('Failed to load user data.'),
    };
  }
}