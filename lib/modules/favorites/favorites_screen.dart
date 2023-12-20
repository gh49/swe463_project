import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swe463_project/modules/product/product.dart';
import 'package:swe463_project/modules/profile/profile_screen.dart';
import 'package:swe463_project/shared/networking.dart';
import '../product/product_details_page.dart';

// Global cart items list
List<Product> globalCartItems = [];

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<Product> _likedProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchLikedProducts();
  }

  Future<void> _fetchLikedProducts() async {
    _likedProducts = await NetworkFunctions.getLikedProducts();
    setState(() {

    });
  }

  void toggleLiked(Product product) async {
    await NetworkFunctions.toggleLiked(product);
    await _fetchLikedProducts();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.all(4),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: _likedProducts.length,
        itemBuilder: (context, index) {
          final product = _likedProducts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(product: product),
                ),
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      toggleLiked(product);
                    },
                  ),
                ),
                // Add to Cart Button
                Positioned(
                  top: 2,
                  right: 2,
                  child: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      NetworkFunctions.addToCart(product);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
  }
}