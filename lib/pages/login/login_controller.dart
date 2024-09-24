import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        _isLoading = false;
        notifyListeners();
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      _user = userCredential.user;

      // Guardar datos adicionales en Firestore
      await _firestore.collection('users').doc(_user!.uid).set({
        'email': _user!.email,
        'name': _user!.displayName,
        'photoURL': _user!.photoURL,
        // Aquí puedes añadir más campos si lo necesitas
      }, SetOptions(merge: true)); // Usa merge: true para no sobrescribir datos existentes

      return userCredential;
    } catch (e) {
      _errorMessage = 'Error during sign-in: ${e.toString()}';
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  // Facebook Sign-In
  Future<UserCredential?> signInWithFacebook() async {
    _isLoading = true;
    notifyListeners();

    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;

        if (accessToken != null) {
          // Usa accessToken.token para obtener el token como string
          final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString);

          final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
          _user = userCredential.user;

          // Guardar datos adicionales en Firestore
          await _firestore.collection('users').doc(_user!.uid).set({
            'email': _user!.email,
            'name': _user!.displayName,
            'photoURL': _user!.photoURL,
            // Aquí puedes añadir más campos si lo necesitas
          }, SetOptions(merge: true)); // Usa merge: true para no sobrescribir datos existentes


          return userCredential;
        } else {
          _errorMessage = 'Failed to get access token';
          return null;
        }
      } else {
        _errorMessage = 'Facebook sign-in failed: ${result.message}';
        return null;
      }
    } catch (e) {
      _errorMessage = 'Error during Facebook sign-in: $e';
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}
