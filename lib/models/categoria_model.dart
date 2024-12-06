

class CategoriaModel {
  final String id;
  final String tipo;

  CategoriaModel({
    required this.id,
    required this.tipo,
  });

  // Metodo para ordenar los atributos en un "map"
  factory CategoriaModel.autoMapeoFirestore( Map<String, dynamic> data, String id) {
    return CategoriaModel(
      id: id,
      tipo: data['tipo'],
      );
  }
}