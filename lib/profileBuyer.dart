import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/services/base.dart';
import 'package:planto/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:planto/address.dart';
import 'package:planto/homeupdate.dart';
import 'package:planto/prof2.dart';
import 'package:planto/provider.dart';
import 'package:planto/viewBuyer.dart';
import 'package:planto/viewBuyerProfile.dart';

class profileBuyer extends StatefulWidget {
  @override
  _profileBuyerState createState() => _profileBuyerState();
}

class _profileBuyerState extends State<profileBuyer> {
  String name, mobile, address, bio;

  Location location = new Location();
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  File _image;

  crudMethods crudObj = new crudMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Profile"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            // onPressed: NavigateToViewProfileBuyer
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 28.0, right: 28.0),
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 90.0,
                          backgroundColor: Colors.red,
                          child: ClipOval(
                            child: SizedBox(
                              width: 170,
                              height: 170,
                              child: (_image != null)
                                  ? Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 120, left: 130),
                            child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () {
                                  // getImage();
                                }))
                      ],
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 28.0, right: 28.0),
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.5),
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: 'Full name',
                          icon: Icon(Icons.person),
                          border: InputBorder.none),
                      onSaved: (input) => name = input,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Name can not be blank";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              // TextField(
              //   decoration: InputDecoration(
              //       labelText: "Name", icon: Icon(Icons.person)),
              //   onChanged: (value) {
              //     this.name = value;
              //   },
              // ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 28.0, right: 28.0),
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.5),
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                          hintText: 'Address',
                          icon: Icon(Icons.person),
                          border: InputBorder.none),
                      onSaved: (input) => address = input,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Address can not be blank";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              // TextField(
              //   decoration: InputDecoration(
              //       hintText: "Address", icon: Icon(Icons.location_on)),
              //   onChanged: (value) {
              //     this.address = value;
              //   },
              // ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 28.0, right: 28.0),
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.5),
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextFormField(
                      controller: _mobileController,
                      decoration: InputDecoration(
                          hintText: 'Mobile number',
                          icon: Icon(Icons.phone_android),
                          border: InputBorder.none),
                      onSaved: (input) => name = input,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "mobile number can not be blank";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              // TextField(
              //   decoration: InputDecoration(
              //       hintText: "Mobile", icon: Icon(Icons.phone_android)),
              //   onChanged: (value) {
              //     this.mobile = value;
              //   },
              // ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 28.0, right: 28.0),
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.5),
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextFormField(
                      controller: _bioController,
                      decoration: InputDecoration(
                          hintText: 'Bio',
                          icon: Icon(Icons.description),
                          border: InputBorder.none),
                      onSaved: (input) => name = input,
                    ),
                  ),
                ),
              ),
              // TextField(
              //   decoration: InputDecoration(
              //       hintText: "Bio", icon: Icon(Icons.people_outline)),
              //   onChanged: (value) {
              //     this.mobile = value;
              //   },
              // ),
              new RaisedButton(
                onPressed: () async {
                  final documentId = await inputData();
                  return await Firestore.instance
                      .collection('ProfileSeller')
                      .document(documentId)
                      .setData({
                    "name": _nameController.text,
                    'address': _addressController.text,
                    'mobile': _mobileController.text,
                    'bio': _bioController.text
                  }).then((result) {
                    dialogTrigger(context);
                  });
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text("Set Profile"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.teal,
                textColor: Colors.white,
              ),
            ],
          ),
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

  // void NavigateToViewProfileBuyer() {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => viewBuyerProfile()));
  //   // Navigator.push(context, MaterialPageRoute(builder: (context) => prof2()));
  // }
}
