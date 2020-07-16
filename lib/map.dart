import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocation/geolocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';

class mapRo extends StatefulWidget {
  @override
  _mapRoState createState() => _mapRoState();
}

class _mapRoState extends State<mapRo> {
  @override
  MapController controller = new MapController();
  getPermission() async {
    final GeolocationResult result =
        await Geolocation.requestLocationPermission(
            permission: const LocationPermission(
                android: LocationPermissionAndroid.fine,
                ios: LocationPermissionIOS.always));
    return result;
  }

  getLocation() {
    return getPermission().then((result) async {
      if (result.isSuccessful) {
        final coords =
            await Geolocation.currentLocation(accuracy: LocationAccuracy.best);
        return coords;
      }
    });
  }

  buildMap() {
    getLocation().then((response) {
      response.listen((value) {
        if (value.isSuccessful) {
          controller.move(
              new LatLng(value.location.latitude, value.location.longitude),
              8.0);
        }
      });
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Location'),
          backgroundColor: Colors.teal,
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('ProfileSeller').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("loading...");
              return FlutterMap(
                  options: new MapOptions(
                      minZoom: 15.0, center: new LatLng(40.71, -74.00)),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    new MarkerLayerOptions(markers: [
                      new Marker(
                          width: 45.0,
                          height: 45.0,
                          point: new LatLng(40.71, -74.00),
                          builder: (context) => new Container(
                                child: IconButton(
                                  icon: Icon(Icons.location_on),
                                  color: Colors.red,
                                  iconSize: 45.0,
                                  onPressed: () {},
                                ),
                              )),
                    ]),
                  ]);
            }));
  }
}
