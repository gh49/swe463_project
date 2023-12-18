import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swe463_project/modules/product/product.dart'; // Import your Product model

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage({required this.product});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle cart action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(product.imageUrl),
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey[100], // Light grey background for details
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 16),
                  Text(
                    product.description,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        addToCart(product);
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        child:
                            Text('Add to Cart', style: TextStyle(fontSize: 18)),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[800], // Dark grey button
                        onPrimary: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
