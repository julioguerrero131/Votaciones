class UsuarioJuntaData {
  final int id;
  final int juntaId;
  final int usuarioId;

  const UsuarioJuntaData({
    required this.id,
    required this.juntaId,
    required this.usuarioId
  });

  factory UsuarioJuntaData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'juntaId': int juntaId,
        'usuarioId': int usuarioId
      } =>
        UsuarioJuntaData(
          id: id,
          juntaId: juntaId,
          usuarioId: usuarioId
        ),
      _ => throw const FormatException('Failed to load juntas data.'),
    };
  }
}