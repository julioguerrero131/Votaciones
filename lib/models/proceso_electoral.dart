class ProcesoElectoralData {
  final int id;
  final String nombre;
  final String fecha;

  const ProcesoElectoralData({
    required this.id,
    required this.nombre,
    required this.fecha
  });

  factory ProcesoElectoralData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nombre': String nombre,
        'fecha': String fecha
      } =>
        ProcesoElectoralData(
          id: id,
          nombre: nombre,
          fecha: fecha
        ),
      _ => throw const FormatException('Failed to load juntas data.'),
    };
  }
}