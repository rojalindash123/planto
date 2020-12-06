import 'package:firebase_database/firebase_database.dart';

// class UserServices {
//   FirebaseDatabase _database = FirebaseDatabase.instance;
//   String ref = "users";
//   createUser(Map value) {
//     _database
//         .reference()
//         .child(ref)
//         .push()
//         .set(value)
//         .catchError((e) => {print(e.toString())});
//   }
// }

class User {
  String name, address, mobile, altMobile;
  User(this.name, this.address, this.mobile, this.altMobile);
}
