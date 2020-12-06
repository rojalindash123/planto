import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class productServices {
  final String uid;
  productServices({this.uid});
  Firestore _firestore = Firestore.instance;
  String ref = 'products';
  void uploadProduct(
      {String productName,
      String type,
      String category,
      int quantity,
      List sizes,
      List images,
      double price}) {
    var id = Uuid();
    String productId = id.v1();
    _firestore
        .collection('sellers')
        .document(uid)
        .collection(ref)
        .document(productId)
        .setData({
      'name': productName,
      'id': productId,
      'type': type,
      'category': category,
      'quantity': quantity
    });
  }
}

class sellerProfileServices {
  Firestore _firestore = Firestore.instance;
  String ref = 'ProfileSeller';
  void uploadSeller({
    String sname,
    String address,
    String mobile,
    String altMobile,
    List images,
  }) {
    var id = Uuid();
    String sellerId = id.v1();
    _firestore.collection(ref).document(sellerId).setData({
      'name': sname,
      'id': sellerId,
      'address': address,
      'mobile': mobile,
      'altMobile': altMobile
    });
  }
}
