import 'package:flutter/material.dart';
import 'package:planto/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:planto/address.dart';
import 'package:planto/viewBuyer.dart';

class profileBuyer extends StatefulWidget {
  @override
  _profileBuyerState createState() => _profileBuyerState();
}

class _profileBuyerState extends State<profileBuyer> {
  String name, mobile, address;
  double latitude, longitude;
  Location location = new Location();

  crudMethods crudObj = new crudMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Profile"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: NavigateToViewProfileBuyer)
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Name"),
              onChanged: (value) {
                this.name = value;
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: "Address"),
              onChanged: (value) {
                this.address = value;
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: "Mobile"),
              onChanged: (value) {
                this.mobile = value;
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: "Latitude"),
              onChanged: (value) {
                this.latitude = double.parse(value);
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: "Longitude"),
              onChanged: (value) {
                this.longitude = double.parse(value);
              },
            ),
            new RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();

                crudObj.addProfileBuyer({
                  'name': this.name,
                  'address': this.address,
                  'mobile': this.mobile,
                  'latitude': this.latitude,
                  'longitude': this.longitude
                }).then((result) {
                  dialogTrigger(context);
                }).catchError((e) {
                  print(e);
                });
              },
              child: Text("Set Profile"),
            ),
            InkWell(
                child: Text("Get Your Location Details"),
                onTap: NavigateToAddress),
          ],
        ),
      ),
    );
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Done', style: TextStyle(fontSize: 15.0)),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Alright"))
            ],
          );
        });
  }

  void NavigateToAddress() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  void NavigateToViewProfileBuyer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => viewBuyer()));
  }
}
