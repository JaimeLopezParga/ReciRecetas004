import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jlprecetas04/models/categoria_model.dart';
import 'package:jlprecetas04/services/firebase_service.dart';
import 'package:jlprecetas04/services/google_service.dart';

class AgregarOptPage extends StatefulWidget {
  const AgregarOptPage({super.key});

  @override
  State<AgregarOptPage> createState() => _AgregarOptPageState();
}

class _AgregarOptPageState extends State<AgregarOptPage> {

  //------ Variables
  final formKey = GlobalKey<FormState>();

  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController instruccionesCtrl = TextEditingController();
  //TextEditingController categoriaCtrl = TextEditingController();
  // TextEditingController imagenCtrl = TextEditingController();
  TextEditingController autorCtrl = TextEditingController();

  String? _selCategoria;
  final List<String> _opc_categorias = ['Ensalada', 'Postre','Bebida','Sopa'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //APPBAR
      appBar: AppBar(
        title: Text('Nueva receta'),
      ),

      //BODY
      body: Container(
        child: Form(
          key: formKey,
          child: ListView(
            children: [

              //cLiVi 1.-
              //  Ingreso de nombre
              Container(
                child: TextFormField(
                  controller: nombreCtrl,
                  decoration: InputDecoration(labelText: 'Nombre de Platillo'),
                  validator: (nombre) {
                      if (nombre!.isEmpty) {
                        return 'Ingrese nombre';
                      }
                      return null;
                    },
                ),
              ),

              //cLiVi 2.-
              //  Escoger Categoria
              Container(
                child: DropdownButtonFormField<String>(
                  value: _selCategoria,
                  decoration: InputDecoration(
                    label: Text('Escoger categoria'),
                  ),
                  items: _opc_categorias.map<DropdownMenuItem<String>>( (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },).toList(),
                  onChanged: (escogido) {
                    setState(() {
                      _selCategoria = escogido;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Por favor selecciona una opción';
                    }
                    return null;
                  },
                  ),
              ),

              //cLiVi 3.-
              //  Ingreso de instrucciones
              Container(
                child: TextFormField(
                  controller: instruccionesCtrl,
                  decoration: InputDecoration(labelText: 'Su receta'),
                  validator: (instrucciones) {
                      if (instrucciones!.isEmpty) {
                        return 'Ingrese instrucciones';
                      }
                      return null;
                    },
                ),
              ),

              //cLiVi 4.-
              //  Boton a agregar
              Container(
                child: FutureBuilder(
                  future: GoogleService().currentUser(),
                  builder: (context, AsyncSnapshot<User?> snapshot) {
                    return FilledButton(
                      child: Text('Agregar receta'),
                      onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FirebaseService().agregarReceta(
                              nombreCtrl.text,
                              instruccionesCtrl.text,
                              _selCategoria!,
                              snapshot.data!.email!,
                              'imagen_prueba',
                            );
                            
                            setState(() {
                               nombreCtrl.clear();
                               instruccionesCtrl.clear();
                               _selCategoria = 'Ensalada';
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Receta agregada exitosamente')),
                              );

                          }
                        },
                    );
                  }
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}