import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:planto/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class viewproducts extends StatefulWidget {
  @override
  _viewproductsState createState() => _viewproductsState();
}

class _viewproductsState extends State<viewproducts> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('View Products'),
      ),
      body: StreamBuilder(
          stream: getUsersTripsStreamSnapshots(context),
          builder: (context, snapshot) {
            // if (!snapshot.hasData) return const Text("Loading...");
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildTripCard(context, snapshot.data.documents[index]));
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    final documentId = await inputData();
    // final uid = await Provider.of(context).auth.getCurrentUID();
    print("uid");
    print(documentId);
    yield* Firestore.instance
        .collection('sellers')
        .document(documentId)
        .collection('products')
        .snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot sellerPro) {
    return new Container(
        child: Card(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Row(children: <Widget>[
                      Text(
                        sellerPro['pname'],
                        style: new TextStyle(fontSize: 30.0),
                      ),
                      Spacer(),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Row(children: <Widget>[
//                     final ref = FirebaseStorage.instance.ref().child();
// // no need of the file extension, the name will do fine.
// var url = await ref.getDownloadURL();
// print(url);
                      Spacer(),
                    ]),
                  ),
                ]))));
  }
}
