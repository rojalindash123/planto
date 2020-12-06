import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planto/geolocation.dart';
import 'package:planto/home.dart';
import 'package:planto/map.dart';
import 'package:planto/utils/mapUpdated.dart';
import 'package:planto/map2.dart';
import 'package:planto/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:planto/provider.dart';

class viewBuyer extends StatefulWidget {
  @override
  _viewBuyerState createState() => _viewBuyerState();
}

class _viewBuyerState extends State<viewBuyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: new Text('Order From'),
        backgroundColor: Colors.red,
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
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  height: 200,
                  child: Card(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 120, top: 30)),
                        Icon(
                          Icons.account_circle,
                          size: 100,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 20, top: 50)),
                    // new Text(
                    //   'Name : ',
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white,
                    //       fontSize: 15),
                    // ),
                    new Container(
                      child: Icon(Icons.person),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      snapshot.data.documents[0]['name'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 20, top: 30)),
                    new Container(
                      child: Icon(Icons.phone_android),
                    ),
                    // new Text(
                    //   'Mobile No : ',
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white,
                    //       fontSize: 12),
                    // ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      snapshot.data.documents[0]['mobile'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 20, top: 50)),
                    new Container(
                      child: Icon(Icons.location_city),
                    ),
                    // new Text(
                    //   'Address : ',
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white,
                    //       fontSize: 12),
                    // ),
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      snapshot.data.documents[0]['address'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  void NavigateToStock() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => stock()));
  }

  void NavigateToMap() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => mapupdate()));
  }

  Future<void> getUserDoc() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;
    FirebaseUser user = await _auth.currentUser();
    final uid = await Provider.of(context).auth.getCurrentUID();
    return uid;
  }
}
