import 'package:flutter/material.dart';

class showWishlist extends StatefulWidget {
  @override
  _showWishlistState createState() => _showWishlistState();
}

class _showWishlistState extends State<showWishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Wishlist"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
