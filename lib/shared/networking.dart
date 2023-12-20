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

  static Future<void> addToCart(Product product) async {
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

            products.add(product.id);
            transaction.update(cartRef, {'products': products});

        }
      });
    } catch (e) {
      print('Error adding product to cart: $e');
      // Handle errors (e.g., show a snackbar with the error message)
    }
  }

  static Future<void> removeFromCart(Product product) async {
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

          products.remove(product.id);
          transaction.update(cartRef, {'products': products});

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

  static Future<List<Product>> getLikedProducts() async {
    String userId =
        FirebaseAuth.instance.currentUser!.uid; // Get current user's ID
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference likedRef = firestore.collection('liked').doc(userId);
    CollectionReference productRef = firestore.collection('products');
    List<Product> products = [];

    try {
      var likedDoc = await likedRef.get();
      var liked = likedDoc.get('products');

      for(String pid in liked) {
        var productDoc = await productRef.doc(pid).get();
        Product product = Product.fromMap(productDoc.data() as Map<String, dynamic>, pid);
        if(!products.contains(product)) {
          products.add(product);
        }
      }

      return products;
    } catch (e) {
      print('Error getting liked products: $e');
      return [];
      // Handle errors (e.g., show a snackbar with the error message)
    }
  }

  static Future<bool> isLiked(Product product) async {
    String userId =
        FirebaseAuth.instance.currentUser!.uid; // Get current user's ID
    DocumentReference likedRef =
    FirebaseFirestore.instance.collection('liked').doc(userId);

    try {
      var likedDoc = await likedRef.get();
      var liked = likedDoc.get('products');

      for(String pid in liked) {
        if(pid == product.id) {
          return true;
        }
      }

      return false;
    } catch (e) {
      print('Error adding product to cart: $e');
      // Handle errors (e.g., show a snackbar with the error message)
      return false;
    }
  }

  static Future<void> toggleLiked(Product product) async {
    String userId =
        FirebaseAuth.instance.currentUser!.uid; // Get current user's ID
    DocumentReference likedRef =
    FirebaseFirestore.instance.collection('liked').doc(userId);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(likedRef);

        if (!snapshot.exists) {
          // If the liked products doesn't exist, create a new liked products document
          transaction.set(likedRef, {
            'products': [product.id] // Start with the current product
          });
        } else {
          // If the liked products exists, update the products array
          List<dynamic> products = snapshot.get('products');

          bool liked = await isLiked(product);

          if(liked) {
            products.remove(product.id);
          } else {
            products.add(product.id);
          }
          transaction.update(likedRef, {'products': products});
        }
      });
    } catch (e) {
      print('Error adding product to cart: $e');
      // Handle errors (e.g., show a snackbar with the error message)
    }
  }
}