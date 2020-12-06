import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planto/about.dart';
import 'package:planto/feedback.dart';
import 'package:planto/loginSeller.dart';
import 'package:planto/loginuser.dart';
import 'package:carousel_pro/carousel_pro.dart';

class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
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
        backgroundColor: Colors.teal,
        appBar: AppBar(
          title: Text("welcome"),
          backgroundColor: Colors.teal,
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new DrawerHeader(
                child: new Text('header'),
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('images/planto1.jpg')),
                  color: Colors.green,
                  // AssetImage assetImage=AssetImage('images/planto1.jpg'),
                ),
              ),
              new ListTile(
                leading: Icon(Icons.account_circle),
                title: new Text(
                  'Seller',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: NavigateToSignInSeller,
              ),
              new ListTile(
                leading: Icon(Icons.account_circle),
                title: new Text(
                  'Buyer',
                  style: TextStyle(fontSize: 18),
                ),
                // onTap: NavigateToSignInBuyer,
                onTap: Navigatetologin,
              ),
              new ListTile(
                leading: Icon(Icons.info),
                title: new Text(
                  'About',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: NavigateToAbout,
              ),
              new ListTile(
                leading: Icon(Icons.feedback),
                title: new Text(
                  'Feedback',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: NavigateToFeedback,
              ),
              new ListTile(
                leading: Icon(
                  Icons.transit_enterexit,
                ),
                title: new Text(
                  'Logout',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pop(context);
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => loginuser()));
                  });
                },
              )
            ],
          ),
        ),
        body: new ListView(
          children: <Widget>[image_carausel],
        ));
  }

  void NavigateToSignInSeller() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => loginseller()));
  }

  void NavigateToSignInBuyer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => loginuser()));
  }

  void Navigatetologin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => loginuser()));
  }

  void NavigateToAbout() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => about()));
  }

  void NavigateToFeedback() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => feedback()));
  }
}
