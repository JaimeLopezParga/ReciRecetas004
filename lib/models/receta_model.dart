

class RecetaModel {
  final String id;
  final String nombre;
  final String instrucciones;
  final String autor;
  final String categoria;
  final String foto;

  RecetaModel({
    required this.id,
    required this.nombre,
    required this.instrucciones,
    required this.autor,
    required this.categoria,
    required this.foto,
  });

  // Metodo para ordenar los atributos en un "map"
  factory RecetaModel.autoMapeoFirestore( Map<String, dynamic> data, String id) {
    return RecetaModel(
      id: id,
      nombre: data['nombre'],
      instrucciones: data['instrucciones'],
      autor: data['autor'],
      categoria: data['categoria'],
      foto: data['foto'],
      );
  }
}