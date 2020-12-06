import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:planto/products.dart';
import 'package:planto/utils/showWishlist.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carausel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/begonia.jpg'),
          AssetImage('images/cactus.jpg'),
          AssetImage('images/cannaLily.jpg'),
          AssetImage('images/dahlias.jpg'),
          AssetImage('images/cardinalClimber.jpg'),
          AssetImage('images/redRose.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 8.0,
        dotBgColor: Colors.transparent,
      ),
    );
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        title: Text('Shop'),
        actions: <Widget>[],
      ),
      endDrawer: SizedBox(
        width: 200,
        child: new Drawer(
          child: ListView(
            children: <Widget>[
              InkWell(
                child: new ListTile(
                    leading: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    title: new Text(
                      'Wishlist',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => showWishlist()));
                    }),
              ),
              InkWell(
                child: new ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: Colors.red,
                  ),
                  title: new Text(
                    'Profile',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          // image_carausel,
          // new Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: new Text('Catagories'),
          // ),
          // horizontalList(),
          // new Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: new Text('Recent products'),
          // ),
          Container(
            height: 550.0,
            child: products(),
          )
        ],
      ),
    );
  }
}
