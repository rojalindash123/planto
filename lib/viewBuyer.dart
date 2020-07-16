import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planto/geolocation.dart';
import 'package:planto/home.dart';
import 'package:planto/map.dart';
import 'package:planto/map2.dart';

class viewBuyer extends StatefulWidget {
  @override
  _viewBuyerState createState() => _viewBuyerState();
}

class _viewBuyerState extends State<viewBuyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: new Text('Order From'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.location_searching), onPressed: NavigateToMap)
        ],
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('ProfileBuyer').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading..');
            return Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 120, top: 30)),
                    Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.white,
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 80, top: 30)),
                    new Text(
                      'Name : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Text(
                      snapshot.data.documents[0]['name'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 100, top: 30)),
                    new Text(
                      'Address : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Text(
                      snapshot.data.documents[0]['address'],
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
                      'Mobile No : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Text(
                      snapshot.data.documents[0]['mobile'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 120, top: 80)),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      // color: Colors.teal,
                      // textColor: Colors.white,
                      child: Text('Confirm Order'),
                      onPressed: NavigateToStock,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // RaisedButton(
                    //   child: Text('view location'),
                    //   onPressed: NavigateToMap,
                    // )
                  ],
                )
              ],
            );
          }),
    );
  }

  void NavigateToStock() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => stock()));
  }

  void NavigateToMap() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => mapRo2()));
  }
}
