import 'package:flutter/material.dart';

class viewProducts extends StatefulWidget {
  @override
  _viewProductsState createState() => _viewProductsState();
}

class _viewProductsState extends State<viewProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.red,
      title: new Text("product list"),
    ));
  }
}
