import 'package:firebase_auth/firebase_auth.dart';

class NetworkFunctions {

  static Future<bool> login(String email, String password) async {
    late UserCredential credential;

    try{
      credential = await
      FirebaseAuth.instance.
      signInWithEmailAndPassword(email: email, password: password);
    }
    catch(error) {
      return false;
    }

    if(credential.user == null) {
      return false;
    }
    else {
      return true;
    }
  }

  static Future<bool> register(String name, bool gender, String email, String password) async {
    late UserCredential credential;

    try{
      credential = await
      FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: email, password: password);
    }
    catch(error) {
      print(error.toString());
      return false;
    }

    if(credential.user == null) {
      return false;
    }
    else {
      return true;
    }
  }
}