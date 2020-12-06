import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:planto/crud.dart';
import 'package:planto/provider.dart';
import 'package:planto/updateProfileSeller.dart';
import 'package:planto/db/sellerfunction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planto/viewProfileSeller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'db/product.dart';

class sellerProfile extends StatefulWidget {
  @override
  _sellerProfileState createState() => _sellerProfileState();
}

class _sellerProfileState extends State<sellerProfile> {
  String name, address, mobile, altMobile;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _mobTextController = TextEditingController();
  TextEditingController _altMobController = TextEditingController();
  sellerProfileServices sellerProService = sellerProfileServices();

  // crudMethods crudObj = new crudMethods();
  // final String uid;
  // sellerProfile({this.uid});
  File _image;
  bool isloading = false;

  final FirebaseAuth auth = FirebaseAuth.instance;

  inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: new Text("Profile"),
      ),
      body: SingleChildScrollView(
        // margin: EdgeInsets.only(top: 10),
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
                                getImage();
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
                    controller: _nameTextController,
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
            //   decoration:
            //       InputDecoration(icon: Icon(Icons.person), labelText: "Name"),
            //   onChanged: (value) {
            //     this.name = value;
            //   },
            // ),

            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 28.0, right: 28.0),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.5),
                elevation: 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: TextFormField(
                    controller: _addressTextController,
                    decoration: InputDecoration(
                        hintText: 'Address',
                        icon: Icon(Icons.location_searching),
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
            //       icon: Icon(Icons.location_on), hintText: "Address"),
            //   onChanged: (value) {
            //     this.address = value;
            //   },
            // ),

            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 28.0, right: 28.0),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.5),
                elevation: 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: TextFormField(
                    controller: _mobTextController,
                    decoration: InputDecoration(
                        hintText: 'Mobile number',
                        icon: Icon(Icons.phone_android),
                        border: InputBorder.none),
                    onSaved: (input) => mobile = input,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Mobile can not be blank";
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),

            // TextField(
            //   decoration: InputDecoration(
            //       icon: Icon(Icons.phone_android), hintText: "Mobile"),
            //   onChanged: (value) {
            //     this.mobile = value;
            //   },
            // ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 28.0, right: 28.0, bottom: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.5),
                elevation: 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: TextFormField(
                    controller: _altMobController,
                    decoration: InputDecoration(
                        hintText: 'Alternate Mobile number',
                        icon: Icon(Icons.phone_android),
                        border: InputBorder.none),
                    onSaved: (input) => altMobile = input,
                    // validator: (value) {
                    //   if (value.isEmpty) {
                    //     return "Mobile can not be blank";
                    //   }
                    //   return null;
                    // },
                  ),
                ),
              ),
            ),

            new RaisedButton(
              onPressed: () async {
                print('uid');
                print(inputData());
                final documentId = await inputData();
                return await Firestore.instance
                    .collection('sellers')
                    .document(documentId)
                    .collection('ProfileSeller')
                    .document(documentId)
                    // .document(getCurrentUID().toString())
                    .setData({
                  "name": _nameTextController.text,
                  'address': _addressTextController.text,
                  'mobile': _mobTextController.text,
                  'alternate mobile': _altMobController.text
                })

                    // crudObj.addData({
                    //   'name': _nameTextController.text,
                    //   'address': _addressTextController.text,
                    //   'mobile': _mobTextController.text,
                    //   'alternate mobile': _altMobController.text,
                    // })
                    .then((result) {
                  dialogTrigger(context);
                });
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => sellerfunction()));
              },
              child: Text("Set Profile"),
            ),
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
            title: Text('Profile created', style: TextStyle(fontSize: 15.0)),
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

  void _selectImage(Future<File> pickImage, int i) async {
    File tempImg = await pickImage;
    setState(() {
      _image = tempImg;
    });
  }

  _displayChild() {
    if (_image == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.camera_alt,
          color: Colors.grey,
        ),
      );
    } else {
      return Image.file(
        _image,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void uploadSeller() async {
    if (_formKey.currentState.validate()) {
      setState(() => isloading = true);
      if (_image != null) {
        String imageUrl1;

        final FirebaseStorage storage = FirebaseStorage.instance;
        final String picture1 =
            "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";

        StorageUploadTask task1 = storage.ref().child(picture1).putFile(_image);

        StorageTaskSnapshot snapshot1 =
            await task1.onComplete.then((snapshot) => snapshot);

        task1.onComplete.then((snapshot3) async {
          imageUrl1 = await snapshot1.ref.getDownloadURL();

          List<String> imageList = [imageUrl1];
          sellerProService.uploadSeller(
            sname: _nameTextController.text,
            address: _addressTextController.text,
            mobile: _mobTextController.text,
            altMobile: _altMobController.text,
            // images: imageList
          );
          _formKey.currentState.reset();
          setState(() {
            isloading = false;
          });
          Fluttertoast.showToast(msg: 'Products added');
          //  Navigator.pop(context);
        });
      } else {
        setState(() => isloading = false);
        Fluttertoast.showToast(msg: 'all the images must be provided');
      }
    }
  }

  // Future upload(BuildContext context) async {
  //   String filename = basename(_image.path);
  //   StorageReference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child(filename);
  //   StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
  //   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  //   setState(() {
  //     Scaffold.of(context).showSnackBar(SnackBar(
  //       content: Text('Profile updated'),
  //     ));
  //   });
  // }
}
