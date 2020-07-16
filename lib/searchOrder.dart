import 'package:flutter/material.dart';
import 'package:planto/decoration.dart';
import 'package:planto/garden.dart';
import 'package:planto/herabal.dart';
import 'package:planto/profileBuyer.dart';

class searchOrder extends StatefulWidget {
  @override
  _searchOrderState createState() => _searchOrderState();
}

class _searchOrderState extends State<searchOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: NavigateToBuyerProfile)
        ],
      ),
      body: ListView(children: <Widget>[
        // Padding(padding: EdgeInsets.only(left:20,top: 20),
        //   child: Icon(Icons.search),),
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 180),
          child: RaisedButton(
            onPressed: NavigateToGarden,
            child: Text(
              'Indoor Plant',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 10, right: 180),
          child: RaisedButton(
            onPressed: NavigateToGarden,
            child: Text(
              'Outdoor Plant',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 10, right: 180),
          child: RaisedButton(
            onPressed: NavigateToGarden,
            child: Text(
              'Medicine',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 10, right: 180),
          child: RaisedButton(
            onPressed: NavigateToGarden,
            child: Text(
              'Underwater',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 10, right: 180),
          child: RaisedButton(
            onPressed: NavigateToGarden,
            child: Text(
              'Desert plant',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 10, right: 180),
          child: RaisedButton(
            onPressed: NavigateToGarden,
            child: Text(
              'Decoration',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 10, right: 180),
          child: RaisedButton(
            onPressed: NavigateToGarden,
            child: Text(
              'Herbal',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 10, right: 180),
          child: RaisedButton(
            onPressed: NavigateToGarden,
            child: Text(
              'Vegetable',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 10, right: 180),
          child: RaisedButton(
            onPressed: NavigateToGarden,
            child: Text(
              'Garden',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ]),
    );
  }

  void NavigateToBuyerProfile() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => profileBuyer()));
  }

  void NavigateToDecoration() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => decoration()));
  }

  void NavigateToHerbal() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => herbal()));
  }

  void NavigateToGarden() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => garden()));
  }
}
