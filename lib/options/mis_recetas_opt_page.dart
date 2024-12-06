import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jlprecetas04/models/receta_model.dart';
import 'package:jlprecetas04/services/firebase_service.dart';
import 'package:jlprecetas04/services/google_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MisRecetasOptPage extends StatefulWidget {
  const MisRecetasOptPage({super.key});

  @override
  State<MisRecetasOptPage> createState() => _MisRecetasOptPageState();
}

class _MisRecetasOptPageState extends State<MisRecetasOptPage> {

  //--Variables
  bool _confirmacion = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
          future: GoogleService().currentUser(),
          builder: (context, AsyncSnapshot<User?> snapshot2) {
            return StreamBuilder(
              stream: FirebaseService().recetasTodo(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            
                //  Verificar conexion
                if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                  }
            
                // Mapeo de datos
                final List<RecetaModel> _lista_recetas = snapshot.data!.docs.map( (doc) {
                  final data = doc.data();
                  if (data is Map<String, dynamic>) {
                    return RecetaModel.autoMapeoFirestore(data, doc.id);
                  } else {
                    throw Exception('El documento no tiene el formato esperado');
                  }
                } ).toList();
                String us_actual = snapshot2.data!.email!;
                final List<RecetaModel> _lista_filtrada = _lista_recetas.where( (receta) => receta.autor == us_actual ).toList();
            
                //  Cargar Widget resultante
                return SingleChildScrollView(
                  child: ExpansionPanelList.radio(
                    initialOpenPanelValue: null,
                    children: _lista_filtrada.map<ExpansionPanelRadio> ( (RecetaModel receta) {
            
                      
                      
                      return ExpansionPanelRadio(
                        value: receta.id,
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(receta.nombre),
                            subtitle: Text(receta.autor),
                            trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Aviso'),
                                      content: Text('¿Desea borrar la receta?'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            _confirmacion = true;
                                            FirebaseService().borrarProducto(receta.id);
                                            print(receta.id);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Receta borrada')),
                                              );
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Sí'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            _confirmacion = false;
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('No'),
                                        ),
                                      ],
                                    );
                                    },
                                  );
                              },
                              icon: Icon(MdiIcons.trashCan),
                            ),
                          );
                        },
                        body: ListTile(
                          title: Text(receta.instrucciones),
                          leading: Text(receta.categoria),
                          trailing: Image(image: AssetImage('assets/images/'+receta.categoria+'.png')),
                        ),
                      );
                      // ------ fin ExpansionPanelRadio   ---
            
                    } ).toList(),
                  ),
                );
            
              },
            );
          }
        ),
      ),
    );
  }
}