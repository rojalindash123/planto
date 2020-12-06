import 'package:flutter/material.dart';
import 'package:planto/welcome.dart';

void main() => runApp(new myAppPlanto());

class myAppPlanto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome',
      theme: ThemeData(primarySwatch: Colors.red),
      home: welcome(),
    );
  }
}
