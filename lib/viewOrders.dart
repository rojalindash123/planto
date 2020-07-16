import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planto/viewBuyer.dart';

class viewOrders extends StatefulWidget {
  @override
  _viewOrdersState createState() => _viewOrdersState();
}

class _viewOrdersState extends State<viewOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar:
          AppBar(title: new Text('View Orders'), backgroundColor: Colors.teal),
      body: StreamBuilder(
          stream: Firestore.instance.collection('Orders').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading..');
            return Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 140, top: 30)),
                    Icon(Icons.shopping_cart, color: Colors.white60, size: 80)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 100, top: 30)),
                    new Text(
                      'Piece Required: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Text(
                      snapshot.data.documents[0]['Piece Required'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 120, top: 30)),
                    new Text(
                      'Purpose: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Text(
                      snapshot.data.documents[0]['Purpose'],
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
                        padding:
                            EdgeInsets.only(left: 120, top: 30, bottom: 30)),
                    RaisedButton(
                      child: Text('View Details'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      // color: Colors.teal,
                      // textColor: Colors.white,
                      onPressed: NavigateToViewBuyer,
                    )
                  ],
                )
              ],
            );
          }),
    );
  }

  void NavigateToViewBuyer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => viewBuyer()));
  }
}
