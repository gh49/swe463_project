import 'package:flutter/material.dart';
import 'package:swe463_project/modules/product/product.dart'; // Import your Product model

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(product.imageUrl),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                product.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(product.description),
            ),
            // Add more widgets as needed for displaying product details
          ],
        ),
      ),
    );
  }
}
