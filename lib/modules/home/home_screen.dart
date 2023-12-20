import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swe463_project/modules/product/product.dart';

import '../product/product_details_page.dart';
// Define the Product model (assuming you have a product model like this)

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<Product> _products = [];
  final Set<String> _likedProducts = Set<String>();

  @override
  void initState() {
    super.initState();
    _products = generateSampleProducts(); // Initialize with sample products
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      var snapshot = await _firestore.collection('products').get();
      setState(() {
        _products = snapshot.docs
            .map((doc) =>
                Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
            .toList();
      });
    } catch (e) {
      print(e);
    }
  }

  void addToLiked(String productId) async {
    setState(() {
      if (_likedProducts.contains(productId)) {
        _likedProducts.remove(productId);
      } else {
        _likedProducts.add(productId);
      }
    });
    await _firestore
        .collection('products')
        .doc(productId)
        .update({'liked': _likedProducts.contains(productId)});
  }

  List<Product> generateSampleProducts() {
    return [
      Product(
        '1',
        19.99,
        imageUrl:
            'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/09bad9ff-b86e-443a-a6ab-e443ff5dd658/life-cable-knit-turtleneck-jumper-JrjblH.png',
        name: 'Product 1',
        description: 'Description of Product 1',
      ),
      Product(
        '2',
        29.99,
        imageUrl:
            'https://sa.cosstores.com/assets/styles/COS/412943/3818e34b317375d8378cd327cc8b314d66fa3fc5/1/image-thumb__543687__product_zoom_medium_606x504/3818e34b317375d8378cd327cc8b314d66fa3fc5_xxl-1.jpg',
        name: 'Product 2',
        description: 'Description of Product 2',
      ),
      Product(
        '3',
        39.99,
        imageUrl:
            'https://sa.cosstores.com/assets/styles/COS/407711/ad6a67fb302d5520ee7d4f408c05a98a2eb309d7/1/image-thumb__529517__product_zoom_medium_606x504/ad6a67fb302d5520ee7d4f408c05a98a2eb309d7_xxl-1.jpg',
        name: 'Product 3',
        description: 'Description of Product 3',
      ),
      // Add more products as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar and BottomNavigationBar are the same as before
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Product Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
              // Handle cart action
            },
          ),
          // Add more actions if needed
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(4),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: _products.length, // Use the length of the products list
        itemBuilder: (context, index) {
          final product = _products[index];
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
                      _likedProducts.contains(product.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      addToLiked(product.id);
                    },
                  ),
                ),
                // Optionally, add more UI elements to represent product details
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        // Handle navigation tap
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/favorites');
          } //TODO: if there isn't a profile page then, remove this part
          else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
    );
  }
}
