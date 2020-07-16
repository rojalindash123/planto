import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocation/geolocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:planto/home.dart';

class mapRo2 extends StatefulWidget {
  @override
  _mapRo2State createState() => _mapRo2State();
}

class _mapRo2State extends State<mapRo2> {
  @override
  MapController controller = new MapController();
  String addr;

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Location'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.done), onPressed: NavigateToHome)
          ],
          backgroundColor: Colors.teal,
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('ProfileBuyer').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("loading...");
              // addr = snapshot.data.documents[0]['address'] ;
              addr = snapshot.data.documents[0]['address'];

              var lat = snapshot.data.documents[0]['latitude'];
              var lng = snapshot.data.documents[0]['longitude'];

              return FlutterMap(
                  options: new MapOptions(
                      minZoom: 15.0, center: new LatLng(lat, lng)
                      // center: new LatLang(snapshot.data.documents[0]['address'].geometry.lat)
                      ),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    new MarkerLayerOptions(markers: [
                      new Marker(
                          width: 45.0,
                          height: 45.0,
                          // point: new LatLng(40.71, -74.00),
                          point: new LatLng(lat, lng),
                          builder: (context) => new Container(
                                child: IconButton(
                                  icon: Icon(Icons.location_on),
                                  color: Colors.teal,
                                  iconSize: 60.0,
                                  onPressed: () {},
                                ),
                              ))
                    ]),
                  ]);
            }));
  }

  void NavigateToHome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => stock()));
  }
}
