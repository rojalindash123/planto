import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/services/base.dart';
import 'package:planto/crud.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class AppState extends InheritedWidget {
  const AppState({
    Key key,
    this.mode,
    Widget child,
  })  : assert(mode != null),
        assert(child != null),
        super(key: key, child: child);

  final Geocoding mode;

  static AppState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppState);
  }

  @override
  bool updateShouldNotify(AppState old) => mode != old.mode;
}

class GeocodeView extends StatefulWidget {
  GeocodeView();

  @override
  _GeocodeViewState createState() => new _GeocodeViewState();
}

class _GeocodeViewState extends State<GeocodeView> {
  _GeocodeViewState();

  final TextEditingController _controller = new TextEditingController();

  List<Address> results = [];

  bool isLoading = false;

  Future search() async {
    this.setState(() {
      this.isLoading = true;
    });

    try {
      var geocoding = AppState.of(context).mode;
      var results = await geocoding.findAddressesFromQuery(_controller.text);
      this.setState(() {
        this.results = results;
      });
    } catch (e) {
      print("Error occured: $e");
    } finally {
      this.setState(() {
        this.isLoading = false;
      });
    }
  }

  crudMethods crudObj = new crudMethods();
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new Card(
        child: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  controller: _controller,
                  decoration: new InputDecoration(hintText: "Enter an address"),
                ),
              ),
              new IconButton(
                  icon: new Icon(Icons.search), onPressed: () => search()),
              new IconButton(icon: Icon(Icons.done), onPressed: () {})
            ],
          ),
        ),
      ),
      new Expanded(child: new AddressListView(this.isLoading, this.results)),
    ]);
  }
}

class ReverseGeocodeView extends StatefulWidget {
  ReverseGeocodeView();

  @override
  _ReverseGeocodeViewState createState() => new _ReverseGeocodeViewState();
}

class _ReverseGeocodeViewState extends State<ReverseGeocodeView> {
  final TextEditingController _controllerLongitude =
      new TextEditingController();
  final TextEditingController _controllerLatitude = new TextEditingController();

  _ReverseGeocodeViewState();

  List<Address> results = [];

  bool isLoading = false;

  Future search() async {
    this.setState(() {
      this.isLoading = true;
    });

    try {
      var geocoding = AppState.of(context).mode;
      var longitude = double.parse(_controllerLongitude.text);
      var latitude = double.parse(_controllerLatitude.text);
      var results = await geocoding
          .findAddressesFromCoordinates(new Coordinates(latitude, longitude));
      this.setState(() {
        this.results = results;
      });
    } catch (e) {
      print("Error occured: $e");
    } finally {
      this.setState(() {
        this.isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new Expanded(child: new AddressListView(this.isLoading, this.results)),
    ]);
  }
}

class _MyAppState extends State<MyApp> {
  Geocoding geocoding = Geocoder.local;
  crudMethods crudObj = new crudMethods();

  final Map<String, Geocoding> modes = {
    "Local": Geocoder.local,
    "Google (distant)": Geocoder.google("<API-KEY>"),
  };

  void _changeMode(Geocoding mode) {
    this.setState(() {
      geocoding = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new AppState(
      mode: this.geocoding,
      child: new MaterialApp(
        home: new DefaultTabController(
          length: 2,
          child: new Scaffold(
            appBar: new AppBar(
              title: new Text('Geocoder'),
              actions: <Widget>[
                new PopupMenuButton<Geocoding>(
                  // overflow menu
                  onSelected: _changeMode,
                  itemBuilder: (BuildContext context) {
                    return modes.keys.map((String mode) {
                      return new CheckedPopupMenuItem<Geocoding>(
                        checked: modes[mode] == this.geocoding,
                        value: modes[mode],
                        child: new Text(mode),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            body: Container(
              child: new TabBarView(children: <Widget>[
                new GeocodeView(),
                new ReverseGeocodeView(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  final Address address;

  AddressTile(this.address);

  final titleStyle =
      const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new ErrorLabel(
            "feature name",
            this.address.featureName,
            fontSize: 15.0,
            isBold: true,
          ),
          new ErrorLabel("address lines", this.address.addressLine),
          new ErrorLabel("country name", this.address.countryName),
          new ErrorLabel("locality", this.address.locality),
          new ErrorLabel("sub-locality", this.address.subLocality),
          new ErrorLabel("admin-area", this.address.adminArea),
          new ErrorLabel("sub-admin-area", this.address.subAdminArea),
          new ErrorLabel("thoroughfare", this.address.thoroughfare),
          new ErrorLabel("sub-thoroughfare", this.address.subThoroughfare),
          new ErrorLabel("postal code", this.address.postalCode),
          this.address.coordinates != null
              ? new ErrorLabel("", this.address.coordinates.toString())
              : new ErrorLabel("coordinates", null),
        ],
      ),
    );
  }
}

class AddressListView extends StatelessWidget {
  final List<Address> addresses;

  final bool isLoading;

  AddressListView(this.isLoading, this.addresses);

  @override
  Widget build(BuildContext context) {
    if (this.isLoading) {
      return new Center(child: new CircularProgressIndicator());
    }

    return new ListView.builder(
      itemCount: this.addresses.length,
      itemBuilder: (c, i) => new AddressTile(this.addresses[i]),
    );
  }
}

class ErrorLabel extends StatelessWidget {
  final String name, text;

  final TextStyle descriptionStyle;

  ErrorLabel(this.name, String text,
      {double fontSize = 9.0, bool isBold = false})
      : this.text = text ?? "Unknown $name",
        this.descriptionStyle = new TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: text == null ? Colors.red : Colors.black);

  @override
  Widget build(BuildContext context) {
    return new Text(this.text, style: descriptionStyle);
  }
}
