class JuntaData {
  final int id;
  final String nombre;

  const JuntaData({
    required this.id,
    required this.nombre
  });

  factory JuntaData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'nombre': String nombre
      } =>
        JuntaData(
          id: id,
          nombre: nombre
        ),
      _ => throw const FormatException('Failed to load juntas data.'),
    };
  }
}