import 'package:flutter/material.dart';
import 'package:jlprecetas04/pages/login_page.dart';
import 'package:jlprecetas04/services/google_service.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    //Variables dentro de la funcion
    final _auth = GoogleService();

    return Container(
        child: Center(
            child: ElevatedButton(
              onPressed: () async {
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
              child: Text('Cerrar Sesión'),
            ),
        ),
    );
  }
}