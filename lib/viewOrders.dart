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
      backgroundColor: Colors.white,
      appBar:
          AppBar(title: new Text('View Orders'), backgroundColor: Colors.red),
      body: StreamBuilder(
          stream: Firestore.instance.collection('Orders').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading..');
            return Column(children: <Widget>[
              // for (var i = 0; i < 10; i++){

              Padding(padding: EdgeInsets.only(top: 20)),
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 110, top: 200)),
                  Icon(Icons.add_shopping_cart, color: Colors.red, size: 120)
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 20, top: 30)),
                  new Text(
                    'Product name: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15),
                  ),
                  Text(
                    snapshot.data.documents[0]['product name'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 20, top: 30)),
                  new Text(
                    'Piece Required: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                  Text(
                    snapshot.data.documents[0]['Piece'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 20, top: 30)),
                  new Text(
                    'Price: ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                  Text(
                    snapshot.data.documents[0]['price'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                ],
              ),
              // }
              // ]);
              Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 120, top: 30, bottom: 30)),
                  RaisedButton(
                    child: Text(
                      'View Details',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    // color: Colors.teal,
                    // textColor: Colors.white,
                    onPressed: NavigateToViewBuyer,
                  )
                ],
              )
            ]);
          }),
    );
  }

  void NavigateToViewBuyer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => viewBuyer()));
  }
}
