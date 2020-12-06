import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class mapupdate extends StatefulWidget {
  @override
  _mapupdateState createState() => _mapupdateState();
}

class _mapupdateState extends State<mapupdate> {
  List<Marker> allMarkers = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
  inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   allMarkers.add(Marker(
  //       markerId: MarkerId("myMarker"),
  //       draggable: true,
  //       position: LatLng(40.128, -74.0060)));
  // }

  GoogleMapController mapController;
  // static const _initialPosition = LatLng(40.128, -74.0060);
  // LatLng _lastPosition = _initialPosition;
  // final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('location').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text("loading...");

          var lat = double.parse(snapshot.data.documents[0]['lat']);
          var lng = double.parse(snapshot.data.documents[0]['long']);
          return Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: LatLng(lat, lng), zoom: 10.0),
                myLocationEnabled: true,
                mapType: MapType.normal,
                compassEnabled: true,
                // markers: Set.from(allMarkers),
                //               allMarkers.add(
                //     Marker(
                //     markerId: MarkerId('SomeId'),
                //     position: LatLng(38.123,35.123),
                //     infoWindow: InfoWindow(
                //     title: 'The title of the marker'
                //     )
                //    )
                //  );
              )
            ],
          );
        },
      ),
    );
  }
}
