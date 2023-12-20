import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../modules/product/product.dart';

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

  Future<void> addToCart(Product product) async {
    String userId =
        FirebaseAuth.instance.currentUser!.uid; // Get current user's ID
    DocumentReference cartRef =
    FirebaseFirestore.instance.collection('carts').doc(userId);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(cartRef);

        if (!snapshot.exists) {
          // If the cart doesn't exist, create a new cart document
          transaction.set(cartRef, {
            'products': [product.id] // Start with the current product
          });
        } else {
          // If the cart exists, update the products array
          List<dynamic> products = snapshot.get('products');
          if (!products.contains(product.id)) {
            products.add(product.id);
            transaction.update(cartRef, {'products': products});
          }
          // If product already exists in cart, no action is taken.
        }
      });
    } catch (e) {
      print('Error adding product to cart: $e');
      // Handle errors (e.g., show a snackbar with the error message)
    }
  }

  static Future<List<Product>> getCart() async {
    String userId =
        FirebaseAuth.instance.currentUser!.uid; // Get current user's ID
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference cartRef = firestore.collection('carts').doc(userId);
    CollectionReference productRef = firestore.collection('products');
    List<Product> products = [];

    try {
      var cartDoc = await cartRef.get();
      var cart = cartDoc.get('products');

      for(String pid in cart) {
        var productDoc = await productRef.doc(pid).get();
        Product product = Product.fromMap(productDoc.data() as Map<String, dynamic>, pid);
        products.add(product);
      }

      return products;
    } catch (e) {
      print('Error getting cart: $e');
      return [];
      // Handle errors (e.g., show a snackbar with the error message)
    }
  }
}