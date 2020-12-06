import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planto/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class viewProfileBuyer extends StatefulWidget {
  @override
  _viewProfileBuyerState createState() => _viewProfileBuyerState();
}

class _viewProfileBuyerState extends State<viewProfileBuyer> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  File _image;

  inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('View Profile'),
      ),
      body: Container(
        child: StreamBuilder(
            stream: getUsersTripsStreamSnapshots(context),
            builder: (context, snapshot) {
              // if (!snapshot.hasData) return const Text("Loading...");
              if (snapshot.hasData) {
                return new ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildTripCard(context, snapshot.data.documents[index]));
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    final documentId = await inputData();
    // final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('sellers')
        .document(documentId)
        .collection('ProfileSeller')
        .snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot buyerPro) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Container(
                    child: CircleAvatar(
                      radius: 90.0,
                      backgroundColor: Colors.redAccent,
                      child: ClipOval(
                        child: InkWell(
                          child: SizedBox(
                            width: 170,
                            height: 170,
                            child: (_image != null)
                                ? Image.file(
                                    _image,
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    "https://scontent.fbbi1-1.fna.fbcdn.net/v/t1.0-9/80737463_870772913325836_8833109640230207488_o.jpg?_nc_cat=106&ccb=2&_nc_sid=09cbfe&_nc_ohc=vza3WxEm6NAAX_FG56Q&_nc_ht=scontent.fbbi1-1.fna&oh=4414993b51f44d4a03ecd8b3189c3fea&oe=5FEC1BEF"),
                          ),
                          onTap: getImage,
                        ),
                      ),
                    ),
                  )),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                  Text(buyerPro['name'], style: new TextStyle(fontSize: 30.0)),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  Text(buyerPro['address'],
                      style: new TextStyle(fontSize: 30.0)),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.phone_android,
                    color: Colors.red,
                  ),
                  Text(buyerPro['mobile'],
                      style: new TextStyle(fontSize: 30.0)),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.description,
                    color: Colors.red,
                  ),
                  Text(buyerPro['bio'], style: new TextStyle(fontSize: 30.0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}
