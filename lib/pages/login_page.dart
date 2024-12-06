import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jlprecetas04/pages/main_page.dart';
import 'package:jlprecetas04/pages/start_page.dart';
import 'package:jlprecetas04/services/google_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //Variables en clases
  final _auth = GoogleService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorText = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      //BODY
      body: Container(
        padding: EdgeInsets.all(20),

        child: Container(
          margin: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Form(
            child: Container(
              child: ListView(

                children: [
                  // //e1 -- Titulo login
                  // Container(
                  //   child: Text('Reci Recetas'),
                  // ),

                  // //e2 -- Ingreso de correo
                  // Container(
                  //   child: TextFormField(
                  //     controller: emailController,
                  //     keyboardType: TextInputType.emailAddress,
                  //     decoration: InputDecoration(labelText: 'Correo'),
                  //   ),
                  // ),

                  // //e3 -- Ingreso contraseña
                  // Container(
                  //   child: TextFormField(
                  //     controller: passwordController,
                  //     obscureText: true,
                  //     decoration: InputDecoration(labelText: 'Contraseña'),
                  //   ),
                  // ),

                  // //e4 -- Botón de ingreso
                  // Container(
                  //   child: FilledButton(
                  //     child: Text('Iniciar sesión'),
                  //     onPressed: () async {
                  //       try {
                  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
                  //           email: emailController.text.trim(),
                  //           password: passwordController.text.trim(),
                  //         );
                  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
                  //       } on FirebaseAuthException catch (error) {
                  //         setState(
                  //           () {
                  //             switch (error.code) {
                  //               case 'channel-error':
                  //                 errorText = 'Ingrese sus credenciales';
                  //                 break;
                  //               case 'invalid-email':
                  //                 errorText = 'Email no válido';
                  //                 break;
                  //               case 'invalid-credential':
                  //                 errorText = 'Credenciales no válidas';
                  //                 break;
                  //               case 'user-disabled':
                  //                 errorText = 'Usuario deshabilitado';
                  //                 break;
                  //               default:
                  //                 errorText = 'Error desconocido';
                  //             }
                  //           },
                  //         );
                  //       }
                  //     },
                  //   ),
                  // ),

                  //e5 -- Botón Google
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await _auth.loginWithGoogle();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartPage()));
                      } catch (e) {
                        print( e.toString() );
                      }

                    },
                    child: Text('Ingreso con Google'),
                  ),

                ],

              ),
            ),
          ),
        ),
      ),

    );
  }
}