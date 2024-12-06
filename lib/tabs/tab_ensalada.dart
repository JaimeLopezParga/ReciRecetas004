import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jlprecetas04/models/receta_model.dart';
import 'package:jlprecetas04/services/firebase_service.dart';

class TabEnsalada extends StatefulWidget {
  const TabEnsalada({super.key});

  @override
  State<TabEnsalada> createState() => _TabEnsaladaState();
}

class _TabEnsaladaState extends State<TabEnsalada> {

  // -- Variables de clase
  //List<RecetaModel> _lista_recetas = [];


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: StreamBuilder(
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
            final List<RecetaModel> _lista_filtrada = _lista_recetas.where( (receta) => receta.categoria == 'Ensalada' ).toList();

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
        ),
      ),
    );
  }
}