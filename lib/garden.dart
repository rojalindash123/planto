import 'package:flutter/material.dart';
import 'package:planto/placeOrder.dart';
import 'package:planto/searchService.dart';

class garden extends StatefulWidget {
  @override
  _gardenState createState() => _gardenState();
}

class _gardenState extends State<garden> {
  final ScrollController controller = ScrollController();
  var queryResultSet = [];
  var tempSearchStore = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white70,
      appBar: AppBar(
        // title:new Text('Garden'),

        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.search),
        //      padding: TextField(onChanged: initiateSearch(value),)

        //   )
        // ],

        title: TextField(
          //  prefixIcon: Icon(Icons.search),
          onChanged: (value) {
            initiateSearch(value);
          },

          decoration: InputDecoration(
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        controller: controller,
        children: <Widget>[
          //  Padding(padding: EdgeInsets.only(top:10)),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: NavigateToPlaceOrder,
                  child: Container(
                      margin: EdgeInsets.only(left: 10, top: 20, bottom: 10),
                      child: Center(
                        child: Text(
                          'Red Rose',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      width: 200.0,
                      height: 180.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          'images/redRose.jpg',
                        ),
                      ))),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: NavigateToPlaceOrder,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Center(
                      child: Text(
                        'Cactus',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    width: 200.0,
                    height: 180.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'images/cactus.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: NavigateToPlaceOrder,
                  child: Container(
                      margin: EdgeInsets.only(left: 10, top: 20, bottom: 10),
                      child: Center(
                        child: Text(
                          'Canna Lily',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      width: 200.0,
                      height: 180.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          'images/cannaLily.jpg',
                        ),
                      ))),
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: InkWell(
                  onTap: NavigateToPlaceOrder,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Center(
                      child: Text(
                        'Red Rose',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    width: 200.0,
                    height: 180.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'images/redRose.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: NavigateToPlaceOrder,
                  child: Container(
                      margin: EdgeInsets.only(left: 10, top: 20, bottom: 10),
                      child: Center(
                        child: Text(
                          'Cardinal Climber',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      width: 200.0,
                      height: 180.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          'images/cardinalClimber.jpg',
                        ),
                      ))),
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: InkWell(
                  onTap: NavigateToPlaceOrder,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, top: 20, bottom: 10),
                    child: Center(
                      child: Text(
                        'Dahlias',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    width: 200.0,
                    height: 180.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'images/dahlias.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: NavigateToPlaceOrder,
                  child: Container(
                      margin: EdgeInsets.only(left: 10, top: 20, bottom: 10),
                      child: Center(
                        child: Text(
                          'Moth Orchid',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      width: 200.0,
                      height: 180.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          'images/mothOrchid.jpg',
                        ),
                      ))),
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: InkWell(
                  onTap: NavigateToPlaceOrder,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Center(
                      child: Text(
                        'Rose',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    width: 200.0,
                    height: 180.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'images/rose.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(height: 50),
            ],
          )
        ],
      ),
    );
  }

  void NavigateToPlaceOrder() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => placeOrder()));
  }

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['plantName'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }
}
