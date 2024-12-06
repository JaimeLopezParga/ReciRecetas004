

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {

    final _auth = FirebaseAuth.instance;

    // Método para iniciar sesión
    Future<UserCredential?> loginWithGoogle() async {
        try {
            final googleUser = await GoogleSignIn().signIn();
            final googleAuth = await googleUser?.authentication;
            final credencialUs = GoogleAuthProvider.credential(
                idToken: googleAuth?.idToken,
                accessToken: googleAuth?.accessToken,
            );
            // -- Asegurarse de poner '?' para la clase de googleAuth, porque tienen la posibilidad de se null
            return await _auth.signInWithCredential(credencialUs);
        } catch (e) {
            print( e.toString() );
            print("FLAG: google_service 01");
        }
        return null;
    }


    // Método para cerrar sesión
    Future<void> signOutGoogle() async {
        try {
            await _auth.signOut();
            await GoogleSignIn().signOut();
        } catch (e) {
            print( e.toString() );
            print("FLAG: google_service 02");
        }
        return null;
    }


    // Metodo para obtener usuario
    Future<User?> currentUser() async {
        return FirebaseAuth.instance.currentUser;
    }

}