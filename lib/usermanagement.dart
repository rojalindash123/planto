import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/widgets.dart';
import 'package:planto/welcome.dart';

class UserManagement {
  storeNewUser(user, context) {
    Firestore.instance
        .collection('users')
        .add({'email': user.email, 'uid': user.uid}).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('welcome');
      // Navigator.push(context, MaterialPageRoute(builder: (context) => welcome()));
    }).catchError((e) {
      print(e);
    });
  }
}
