import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future<bool> register(String name, String gender, String email, String password) async {
    late UserCredential credential;

    try{
      UserCredential credential = await
      FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: email, password: password);

      if(credential.user == null) {
        print("error: user not created");
        return false;
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference users = firestore.collection('users');

      users.doc(credential.user!.uid).set({
        "name": name,
        "gender": gender,
      }).then((value) => null).catchError((error) {
        print(error.toString());
      });

    }
    catch(error) {
      print(error.toString());
      return false;
    }

    return true;
  }
}