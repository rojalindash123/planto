import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class typeService {
  Firestore _firestore = Firestore.instance;
  String ref = 'types';
  void createType(String name) {
    var id = Uuid();
    String typeId = id.v1();
    _firestore.collection(ref).document(typeId).setData({'type': name});
  }

  Future<List<DocumentSnapshot>> gettypes() =>
      _firestore.collection(ref).getDocuments().then((snaps) {
        return snaps.documents;
      });

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) => _firestore
          .collection(ref)
          .where('type', isEqualTo: suggestion)
          .getDocuments()
          .then((snaps) {
        return snaps.documents;
      });
}
