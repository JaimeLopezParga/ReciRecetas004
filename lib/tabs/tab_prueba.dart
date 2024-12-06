import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jlprecetas04/models/receta_model.dart';
import 'package:jlprecetas04/services/firebase_service.dart';

class TabPrueba extends StatefulWidget {
  const TabPrueba({super.key});

  @override
  State<TabPrueba> createState() => _TabPruebaState();
}

class _TabPruebaState extends State<TabPrueba> {

  // -- Variables de clase
  //List<RecetaModel> _lista_recetas = [];


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Prueba'),
      ),
    );
  }
}