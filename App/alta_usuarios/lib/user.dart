class Usuario {
  Usuario({
    required this.nombre,
    required this.apellido,
    required this.id,
  });

  int id;
  String nombre;
  String apellido;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      id: json["id"], nombre: json["nombre"], apellido: json["apellido"]);
}
