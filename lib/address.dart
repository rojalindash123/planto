import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(child: Text('Set address')),
      ),
      body: new Column(children: <Widget>[
        new Card(
          child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    controller: _controller,
                    decoration:
                        new InputDecoration(hintText: "Enter deliver address"),
                  ),
                ),
                new IconButton(
                    icon: new Icon(Icons.restore), onPressed: () => search()),
              ],
            ),
          ),
        ),
        new Expanded(child: new AddressListView(this.isLoading, this.results)),
      ]),
    );
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

  List<Address> results = [];

  bool isLoading = false;

  Future search() async {
    this.setState(() {
      this.isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return new Column(children: <Widget>[
    // new Expanded(child: new AddressListView(this.isLoading, this.results)),
    // ]);
  }
}

class _MyAppState extends State<MyApp> {
  Geocoding geocoding = Geocoder.local;

  @override
  Widget build(BuildContext context) {
    return new AppState(
      mode: this.geocoding,
      child: new MaterialApp(
        home: new DefaultTabController(
          length: 2,
          child: new Scaffold(
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

class AddressTile extends StatefulWidget {
  final Address address;

  AddressTile(this.address);

  @override
  _AddressTileState createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // new Text(this.widget.address.coordinates.latitude.toString()),
          //   new Text(this.widget.address.coordinates.longitude.toString()),

          RaisedButton(
            onPressed: () async {
              await Firestore.instance.collection('location').add({
                'lat': this.widget.address.coordinates.latitude.toString(),
                'long': this.widget.address.coordinates.longitude.toString()
              }).then((result) => dialogTrigger(context));
            },
            child: Center(child: Text('Set address')),
          )
        ],
      ),
    );
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Your Order has been Placed',
                style: TextStyle(fontSize: 15.0)),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Alright"))
            ],
          );
        });
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
