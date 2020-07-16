import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planto/crud.dart';
import 'package:planto/confirmOrder.dart';

class placeOrder extends StatefulWidget {
  @override
  _placeOrderState createState() => _placeOrderState();
}

class _placeOrderState extends State<placeOrder> {
  String piece;
  crudMethods crudObj = new crudMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar:
          AppBar(title: Text('Item Description'), backgroundColor: Colors.teal),
      body: StreamBuilder(
          stream: Firestore.instance.collection('Stock').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading..');
            return Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Container(
                      // width: 200,
                      // height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Image.asset(
                        'images/item.jpg',
                        width: 320,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 80, top: 30)),
                    new Text(
                      'Plant Name : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Text(
                      snapshot.data.documents[0]['plantName'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 80, top: 30)),
                    new Text(
                      'Price per piece : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Text(
                      snapshot.data.documents[0]['price'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 80, top: 30)),
                    new Text(
                      'Available Piece: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Text(
                      snapshot.data.documents[0]['piece'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 120, top: 10),
                    ),
                    RaisedButton(
                        child: Text('next'), onPressed: NavigateToConfirmOrder)
                  ],
                ),
              ],
            );
          }),
    );
  }

  void NavigateToConfirmOrder() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => confirmOrder()));
  }
}
