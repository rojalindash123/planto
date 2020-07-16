import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class geolocation extends StatefulWidget {
  @override
  _geolocationState createState() => _geolocationState();
}

class _geolocationState extends State<geolocation> {
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
          // Marker marker = Marker(
          //   builder: (context) => new Container(
          //     child: IconButton(
          //       icon: Icon(Icons.location_on),
          //       color: Colors.red,
          //       iconSize: 50.0,
          //       onPressed: () {},
          //     ),
          //   ),
          //   point:
          //       new LatLng(value.location.latitude, value.location.longitude),
          // );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('geolocation'),
      ),
      body: new FlutterMap(
          mapController: controller,
          options: new MapOptions(center: buildMap(), minZoom: 10.0),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            new MarkerLayerOptions(markers: [
              new Marker(
                  width: 45.0,
                  height: 45.0,
                  point: new LatLng(40.71, -74.00),
                  // point: buildMap(),
                  builder: (context) => new Container(
                        child: IconButton(
                          icon: Icon(Icons.location_on),
                          color: Colors.red,
                          iconSize: 50.0,
                          onPressed: () {},
                        ),
                      ))
            ]),
          ]),
    );
  }
}
