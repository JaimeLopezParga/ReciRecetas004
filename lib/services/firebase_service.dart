import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {

  // Metodo para obtener recetas: Todas
  Stream<QuerySnapshot> recetasTodo() {
    return FirebaseFirestore.instance.collection('recetas').snapshots();
  }

  // Metodo para obtener categorias
  Stream<QuerySnapshot> mostrarCategorias() {
    return FirebaseFirestore.instance.collection('categorias').snapshots();
  }

  Future<List<String>> traerCategorias() async {
    final snapshot = await FirebaseFirestore.instance.collection('categorias').get();
    return snapshot.docs.map( (doc) => doc['nombre'].toString() ).toList();
  }

  // Metodo agregar receta
  Future<void> agregarReceta(String nombre, String instrucciones, String categoria, String autor, String foto) {
    return FirebaseFirestore.instance.collection('recetas').doc().set({
      'nombre': nombre,
      'instrucciones': instrucciones,
      'categoria': categoria,
      'autor': autor,
      'foto': foto,
    });
  }

  //Metodo para borrar receta
  Future<void> borrarProducto(String id) {
    return FirebaseFirestore.instance.collection('recetas').doc(id).delete();
  }

}