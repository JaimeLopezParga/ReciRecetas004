import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jlprecetas04/options/agregar_opt_page.dart';
import 'package:jlprecetas04/options/mis_recetas_opt_page.dart';
import 'package:jlprecetas04/options/recetas_opt_page.dart';
import 'package:jlprecetas04/pages/login_page.dart';
import 'package:jlprecetas04/services/google_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  // ### Variables globales para StartPage
  List listaOptBody = [RecetasOptPage(),AgregarOptPage(), MisRecetasOptPage(),];
  int paginaSeleccionada = 0;
  final _auth = GoogleService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //-----AppBar------
      appBar: AppBar(
        title: Text('Reci-Recetas'),
      ),

      //--------BODY----------
      body: listaOptBody[paginaSeleccionada],

      //-----------EndDrawer----------
      endDrawer: Drawer(
        child: Column(
          children: [

            // ##HEADER##
            DrawerHeader(
              child: FutureBuilder(
                future: GoogleService().currentUser(),
                builder: (context, AsyncSnapshot<User?> snapshot) {
                if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Cargando usuario...', style: TextStyle(color: Colors.black));
                }
                return Text(snapshot.data!.email!, style: TextStyle(color: Colors.black));
                },
              ),
            ),

            Spacer(),

            //eDra 1.-
            //  #### - Opcion Recetas -
            ListTile(
              title: Text('Recetas'),
              onTap: () {
                setState( () {
                  paginaSeleccionada = 0;
                });
                this._restablecer(context);
              },
            ),


            //eDra 2.-
            //  #### - Opcion Agregar -
            ListTile(
              title: Text('Agregar'),
              onTap: () {
                setState( () {
                  paginaSeleccionada = 1;
                });
                this._restablecer(context);
              },
            ),


            //eDra 3.-
            //  #### - Mis Recetas -
            ListTile(
              title: Text('Mis Recetas'),
              onTap: () {
                setState( () {
                  paginaSeleccionada = 2;
                });
                this._restablecer(context);
              },
            ),

            Spacer(),

            //eDra 4.-
            //  #### - Opcion Salir -
            ListTile(
              title: Text('Cerrar Sesión'),
              onTap: () async {
                try {
                  await _auth.signOutGoogle();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                } catch (e) {
                  print( e.toString() );
                  print("FLAG: main_page 01");
                }
              },
            ),

          ],
        ),
      ),

    );
  }
  //Fin clase

  //### Funciones
  void _restablecer(BuildContext context) {
    Navigator.pop(context);
  }

}