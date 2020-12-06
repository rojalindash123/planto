import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planto/db/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'db/users.dart';

class viewProfileSeller extends StatefulWidget {
  @override
  _viewProfileSellerState createState() => _viewProfileSellerState();
}

class _viewProfileSellerState extends State<viewProfileSeller> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController addresscontroller = new TextEditingController();
  TextEditingController mobilecontroller = new TextEditingController();
  TextEditingController altmobcontroller = new TextEditingController();
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

    yield* Firestore.instance
        .collection('sellers')
        .document(documentId)
        .collection('ProfileSeller')
        .snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot sellerPro) {
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
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.red,
                    ),
                    Text(sellerPro['name'],
                        style: new TextStyle(fontSize: 15.0)),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.location_on, color: Colors.red),
                  Text(sellerPro['address'],
                      style: new TextStyle(fontSize: 15.0)),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.phone_android,
                    color: Colors.red,
                  ),
                  Text(
                    sellerPro['mobile'],
                    style: new TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.phone_forwarded,
                    color: Colors.red,
                  ),
                  Text(sellerPro['alternate mobile'],
                      style: new TextStyle(fontSize: 15.0)),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              RaisedButton(
                onPressed: () {
                  UserUpdate(context);
                },
                child: new Text(
                  'Update Profile',
                ),
                textColor: Colors.white,
                color: Colors.red,
              )
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

  void UserUpdate(BuildContext context) {
    userEditBottomSheet(context);
  }

  void userEditBottomSheet(BuildContext context) {
    inputData() async {
      final FirebaseUser user = await auth.currentUser();
      final uid = user.uid;
      return uid;
    }

    User user1 = new User("", "", "", "");
    showBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .60,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Update Profile"),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.red,
                      iconSize: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 25),
                      child: TextField(
                        controller: namecontroller,
                        decoration: InputDecoration(helperText: 'Name'),
                      ),
                    ))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 25),
                      child: TextField(
                        controller: addresscontroller,
                        decoration: InputDecoration(helperText: 'Address'),
                      ),
                    ))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 25.0, left: 25),
                      child: TextField(
                        controller: mobilecontroller,
                        decoration: InputDecoration(helperText: 'Mobile no'),
                      ),
                    ))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 25),
                      child: TextField(
                        controller: altmobcontroller,
                        decoration:
                            InputDecoration(helperText: 'Alternate mobile no'),
                      ),
                    ))
                  ],
                ),
                RaisedButton(
                    onPressed: () async {
                      final documentId = await inputData();
                      return await Firestore.instance
                          .collection('sellers')
                          .document(documentId)
                          .collection('ProfileSeller')
                          .document(documentId)
                          .updateData({
                        "name": namecontroller.text,
                        "address": addresscontroller.text,
                        "mobile": mobilecontroller.text,
                        "alternate mobile": altmobcontroller.text,
                      });

                      Navigator.of(context).pop();
                    },
                    textColor: Colors.white,
                    child: Text('Save'),
                    color: Colors.green)
              ],
            ),
          );
        });
  }
}
