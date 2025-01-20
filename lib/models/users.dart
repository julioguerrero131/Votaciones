class UserData {
  final int id;
  final String cedula;
  final String nombres;
  final String apellidos;
  final String genero;
  final String direccion;
  final String telefono; 
  final String telefonoAux; 

  const UserData({
    required this.id,
    required this.cedula,
    required this.nombres,
    required this.apellidos,
    required this.genero, 
    required this.direccion,
    required this.telefono,
    required this.telefonoAux
  });

  static const UserData empty = UserData(
    id: 0,
    cedula: '',
    nombres: '',
    apellidos: '',
    genero: '',
    direccion: '',
    telefono: '',
    telefonoAux: '',
  );

  factory UserData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'identificacion': String cedula,
        'nombres': String nombres,
        'apellidos': String apellidos,
        'genero': String genero,
        'direccion': String direccion,
        'telefono': String telefono,
        'telefono_aux': String telefonoAux,
      } =>
        UserData(
          id: id,
          cedula: cedula,
          nombres: nombres,
          apellidos: apellidos,
          genero: genero,
          direccion: direccion,
          telefono: telefono,
          telefonoAux: telefonoAux
        ),
      _ => throw const FormatException('Failed to load user data.'),
    };
  }

  bool get isEmpty => cedula.isEmpty;
  bool get isNotEmpty => !isEmpty;
}