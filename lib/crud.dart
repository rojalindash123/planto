import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class crudMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(profileSeller) async {
    if (isLoggedIn()) {
      Firestore.instance
          .collection('ProfileSeller')
          .add(profileSeller)
          .catchError((e) {
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
