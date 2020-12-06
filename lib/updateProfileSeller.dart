import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planto/crud.dart';

// class updateSeller extends StatefulWidget {
//   @override
//   _updateSellerState createState() => _updateSellerState();
// }

// class _updateSellerState extends State<updateSeller> {
//   String name;
//   String address;

//   var cars;

//   crudMethods crudObj=new crudMethods();

//   Future<bool> updateDialog(BuildContext context, selectedDoc) async {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Update Data', style: TextStyle(fontSize: 15.0)),
//             content: Container(
//               height: 125.0,
//               width: 150.0,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   TextField(
//                     decoration: InputDecoration(hintText: 'Enter Name'),
//                     onChanged: (value) {
//                       this.name = value;
//                     },
//                   ),
//                   SizedBox(height: 5.0),
//                   TextField(
//                     decoration: InputDecoration(hintText: 'Enter address'),
//                     onChanged: (value) {
//                       this.address = value;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('Update'),
//                 textColor: Colors.blue,
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   crudObj.updateProfileSeller(selectedDoc, {
//                     'name': this.name,
//                     'address': this.address
//                   }).then((result) {
//                      dialogTrigger(context);
//                   }).catchError((e) {
//                     print(e);
//                   });
//                 },
//               )
//             ],
//           );
//         });
//   }

//   Future<bool> dialogTrigger(BuildContext context) async {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Job updated', style: TextStyle(fontSize: 15.0)),
//             content: Text('Added'),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('Alright'),
//                 textColor: Colors.blue,
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }

//   @override
//   void initState() {
//     crudObj.getData().then((results) {
//       setState(() {
//         cars = results;
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: AppBar(
//           title: Text('Dashboard'),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 // updateDialog(context,selectedDoc);
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.refresh),
//               onPressed: () {
//                 crudObj.getData().then((results) {
//                   setState(() {
//                     cars = results;
//                   });
//                 });
//               },
//             )
//           ],
//         ),
//         body: Center());
//   }

//   Widget _carList() {
//     if (cars != null) {
//       return StreamBuilder(
//         stream: cars,
//         builder: (context, snapshot) {
//           if (snapshot.data != null) {
//             return ListView.builder(
//               itemCount: snapshot.data.documents.length,
//               padding: EdgeInsets.all(5.0),
//               itemBuilder: (context, i) {
//                 return new ListTile(
//                   title: Text(snapshot.data.documents[i].data['name']),
//                   subtitle: Text(snapshot.data.documents[i].data['address']),
//                   onTap: () {
//                     updateDialog(
//                         context, snapshot.data.documents[i].documentID);
//                   },
//                   // onLongPress: () {
//                   //   crudObj.deleteData(snapshot.data.documents[i].documentID);
//                   // },
//                 );
//               },
//             );
//           }
//         },
//       );
//     } else {
//       return Text('Loading, Please wait..');
//     }
//   }
// }

// class EditProfile extends StatefulWidget {
//   final String currentUserId;

//   EditProfile({this.currentUserId});

//   @override
//   _EditProfileState createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   TextEditingController displayNameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   bool isLoading = false;
//   User user;
//   bool _displayNameValid = true;
//   bool _addressValid = true;
//   final usersRef = Firestore.instance.collection('ProfileSeller');

//   @override
//   void initState() {
//     super.initState();
//     getUser();
//   }

//   getUser() async {
//     setState(() {
//       isLoading = true;
//     });
//     DocumentSnapshot doc = await usersRef.document(widget.currentUserId).get();
//     user = User.fromDocument(doc);
//     displayNameController.text = user.name;
//     addressController.text = user.address;
//     setState(() {
//       isLoading = false;
//     });
//   }

//   Column buildDisplayNameField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//             padding: EdgeInsets.only(top: 12.0),
//             child: Text(
//               "Display Name",
//               style: TextStyle(color: Colors.grey),
//             )),
//         TextField(
//           controller: displayNameController,
//           decoration: InputDecoration(
//             hintText: "Update Display Name",
//             errorText: _displayNameValid ? null : "Display Name too short",
//           ),
//         )
//       ],
//     );
//   }

//   Column buildBioField() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(top: 12.0),
//           child: Text(
//             "Address",
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//         TextField(
//           controller: addressController,
//           decoration: InputDecoration(
//             hintText: "Update address",
//             errorText: _addressValid ? null : "address too long",
//           ),
//         )
//       ],
//     );
//   }

//   updateProfileData() {
//     setState(() {
//       displayNameController.text.trim().length < 3 ||
//               displayNameController.text.isEmpty
//           ? _displayNameValid = false
//           : _displayNameValid = true;
//       addressController.text.trim().length > 100
//           ? _addressValid = false
//           : _addressValid = true;
//     });

//     if (_displayNameValid && _addressValid) {
//       usersRef.document(widget.currentUserId).updateData({
//         "name": displayNameController.text,
//         "address": addressController.text,
//       });
//       SnackBar snackbar = SnackBar(content: Text("Profile updated!"));
//       _scaffoldKey.currentState.showSnackBar(snackbar);
//     }
//   }

//   // logout() async {
//   //   await googleSignIn.signOut();
//   //   Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           "Edit Profile",
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: Icon(Icons.done, size: 30.0, color: Colors.green),
//           ),
//         ],
//       ),
//       body: isLoading
//           ? Text('Loading')
//           : ListView(
//               children: <Widget>[
//                 Container(
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.only(
//                           top: 16.0,
//                           bottom: 8.0,
//                         ),
//                         // child: CircleAvatar(
//                         //   radius: 50.0,
//                         //   backgroundImage:
//                         //       CachedNetworkImageProvider(user.photoUrl),
//                         // ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Column(
//                           children: <Widget>[
//                             buildDisplayNameField(),
//                             buildBioField(),
//                           ],
//                         ),
//                       ),
//                       RaisedButton(
//                         onPressed: updateProfileData,
//                         child: Text(
//                           "Update Profile",
//                           style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: FlatButton.icon(
//                           onPressed: () {},
//                           icon: Icon(Icons.cancel, color: Colors.red),
//                           label: Text(
//                             "Logout",
//                             style: TextStyle(color: Colors.red, fontSize: 20.0),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

// class User {
//   final String id;
//   final String name;
//   final String address;
//   // final String email;
//   // final String photoUrl;
//   // final String displayName;
//   // final String bio;

//   User({
//     this.id,
//     this.name,
//     this.address,
//     // this.photoUrl,
//     // this.displayName,
//     // this.bio,
//   });

//   factory User.fromDocument(DocumentSnapshot doc) {
//     return User(
//         id: doc['id'],
//         // email: doc['email'],
//         name: doc['name'],
//         address: doc['address']
//         // photoUrl: doc['photoUrl'],
//         // displayName: doc['displayName'],
//         // bio: doc['bio'],
//         );
//   }
// }

class User {
  String name;
  String address, mobile, altMobile;
  User(this.name, this.address, this.mobile, this.altMobile);
  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'mobile': mobile,
        'altMobile': altMobile
      };
}
