import 'package:flutter/material.dart';
import 'package:planto/profileSeller.dart';
import 'package:planto/crud.dart';
import 'package:planto/viewOrders.dart';

class stock extends StatefulWidget {
  @override
  _stockState createState() => _stockState();
}

class _stockState extends State<stock> {
  String plantName, piece, quality, price, description, type;
  crudMethods crudObj = new crudMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: NavigateToSellerProfile),
          IconButton(
            icon: Icon(Icons.new_releases),
            onPressed: NavigateToViewOrders,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Expanded(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Plant Name'),
                onChanged: (value) {
                  this.plantName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Piece'),
                onChanged: (value) {
                  this.piece = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Quality'),
                onChanged: (value) {
                  this.quality = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Price per piece'),
                onChanged: (value) {
                  this.price = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Add Description'),
                onChanged: (value) {
                  this.description = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Type of plant'),
                onChanged: (value) {
                  this.type = value;
                },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.teal,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                  crudObj.addStock({
                    'plantName': this.plantName,
                    'piece': this.piece,
                    'quality': this.quality,
                    'price': this.price,
                    'type': this.type,
                    'description': this.description,
                  });
                  crudObj.addType({'type': this.type}).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
                child: Text('Store'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void NavigateToSellerProfile() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => sellerProfile()));
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text('Successfully Stocked', style: TextStyle(fontSize: 15.0)),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Okay"))
            ],
          );
        });
  }

  void NavigateToViewOrders() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => viewOrders()));
  }
}
