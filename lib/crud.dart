import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  final String uid;
  crudMethods({this.uid});

  Future<void> getCurrentUID() async {
    // return (await FirebaseAuth.instance.currentUser()).uid;
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }

  Widget displayinfo(context, snapshot) {
    final user = snapshot.data;
    return user;
  }

  Future<void> addData(name) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('ProfileSeller').add(name).catchError((e) {
        print(e);
      });
    } else {
      print("Login first");
    }
  }

  Future<void> addProfileBuyer(profileBuyer) async {
    if (isLoggedIn()) {
      Firestore.instance
          .collection('ProfileBuyer')
          .add(profileBuyer)
          .catchError((e) {
        print(e);
      });
    } else {
      print(" You have to login first");
    }
  }

  Future<void> addStock(Stock) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('Stock').add(Stock).catchError((e) {
        print(e);
      });
    } else {
      print("Login first");
    }
  }

  Future<void> addType(Type) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('Type').add(Type).catchError((e) {
        print(e);
      });
    }
  }

  Future<void> Orders(Orders) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('Orders').add(Orders).catchError((e) {
        print(e);
      });
    }
  }

  Future<void> Address(Address) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('Address').add(Address).catchError((e) {
        print(e);
      });
    }
  }

  Future<void> addFeedback(Feedback) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('Feedback').add(Feedback).catchError((e) {
        print(e);
      });
    } else {
      print("Login first");
    }
  }

  Future<void> addWishlist(wishlist) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('wishlist').add(wishlist).catchError((e) {
        print(e);
      });
    } else {
      print("Login first");
    }
  }

  getData() async {
    return await Firestore.instance.collection('ProfileSeller').snapshots();
  }

  updateProfileSeller(selectedDoc, newValues) {
    Firestore.instance
        .collection('ProfileSeller')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteProfileSeller(docId) {
    Firestore.instance
        .collection('ProfileSeller')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}

class UserManagement {
  storeNewUser(user, context) {
    Firestore.instance
        .collection('/users')
        .add({'email': user.email, 'uid': user.uid}).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/home');
    }).catchError((e) {
      print(e);
    });
  }
}

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference newCollection =
      Firestore.instance.collection('ProfileSeller');
  Future updateUserData(String name, String mobile, String address) async {
    return await newCollection
        .document(uid)
        .setData({'name': name, 'mobile': mobile, 'address': address});
  }
}
