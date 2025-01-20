class ProcesoDignidadData {
  final int id;
  final int procesoElectoralId;
  final int dignidadId;
  final int tipoDignidadId;

  const ProcesoDignidadData({
    required this.id,
    required this.procesoElectoralId,
    required this.dignidadId,
    required this.tipoDignidadId
  });

  factory ProcesoDignidadData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'procesoElectoralId': int procesoElectoralId,
        'dignidadId': int dignidadId,
        'tipoDignidadId': int tipoDignidadId
      } =>
        ProcesoDignidadData(
          id: id,
          procesoElectoralId: procesoElectoralId,
          dignidadId: dignidadId,
          tipoDignidadId: tipoDignidadId
        ),
      _ => throw const FormatException('Failed to load user data.'),
    };
  }
}