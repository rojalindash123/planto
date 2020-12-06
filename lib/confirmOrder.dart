import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planto/crud.dart';

class confirmOrder extends StatefulWidget {
  @override
  _confirmOrderState createState() => _confirmOrderState();
}

class _confirmOrderState extends State<confirmOrder> {
  String plantName, piece, purpose;
  crudMethods crudObj = new crudMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text('Confirm Order'), backgroundColor: Colors.teal),
        body: StreamBuilder(
            stream: Firestore.instance.collection('ProfileSeller').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('Loading..');
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage("images/back2.jpg"), // <-- BACKGROUND IMAGE
                    fit: BoxFit.cover,
                  ),
                ),
                // margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(
                  left: 50,
                  right: 40,
                  top: 80,
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Piece Required",
                          // prefixIcon: Icon(Icons.),
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0))),
                      onChanged: (value) {
                        this.piece = value;
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Purpose",
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0))),
                      onChanged: (value) {
                        this.purpose = value;
                      },
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.teal,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                        crudObj.Orders({
                          'Piece Required': this.piece,
                          'Purpose': this.purpose,
                        }).then((result) {
                          dialogTrigger(context);
                        }).catchError((e) {
                          print(e);
                        });
                      },
                      child: Text('Confirm order'),
                    )
                  ],
                ),
              );
            }));
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Your Order has been Placed',
                style: TextStyle(fontSize: 15.0)),
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
}
