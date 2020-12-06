import 'package:flutter/material.dart';
import 'package:planto/address.dart';
// import 'package:main.dart';
import 'package:planto/products.dart';
import 'package:planto/homeupdate.dart';
import 'dart:io';
import 'crud.dart';

class productDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_old_price;
  final product_detail_picture;

  productDetails(
      {this.product_detail_name,
      this.product_detail_new_price,
      this.product_detail_old_price,
      this.product_detail_picture});

  @override
  _productDetailsState createState() => _productDetailsState();
}

class _productDetailsState extends State<productDetails> {
  String qty;
  crudMethods crudObj = new crudMethods();
  TextEditingController _qtyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        title: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new HomePage()));
            },
            child: Text('Shop')),
      ),
      body: new ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
                child: Container(
                  color: Colors.white,
                  child: Image.asset(widget.product_detail_picture),
                ),
                footer: new Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: new Text(
                      widget.product_detail_name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    title: new Row(
                      children: <Widget>[
                        Expanded(
                            child: new Text(
                          "\$${widget.product_detail_old_price}",
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        )),
                        Expanded(
                            child: new Text(
                          "\$${widget.product_detail_new_price}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        )),
                      ],
                    ),
                  ),
                )),
          ),
          //1st row

          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: TextFormField(
              controller: _qtyController,
              decoration: InputDecoration(
                  hintText: 'Enter required pieces',
                  icon: Icon(Icons.add_to_queue),
                  border: InputBorder.none),
              onSaved: (input) => qty = input,
            ),
          ),

          // 2nd row

          Divider(),
          new ListTile(
            title: new Text("Product details"),
            subtitle: new Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged"),
          ),
          Divider(),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Product name",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text(widget.product_detail_name),
              )
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Product brand",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text("Brand x"),
              )
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Product condition",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text('New'),
              )
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: MaterialButton(
                      onPressed: () {
                        crudObj.Orders({
                          'Piece': _qtyController.text,
                          'product name': widget.product_detail_name,
                          'price': widget.product_detail_new_price,
                          'picture': widget.product_detail_picture
                        }).then((result) {
                          // dialogTrigger(context);
                          NavigateToUpdateAddress();
                        }).catchError((e) {
                          print(e);
                        });
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      elevation: 0.2,
                      child: new Text("Buy Now"))),
              new IconButton(
                icon: Icon(
                  Icons.chat,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
              new IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    {
                      Navigator.of(context).pop();
                      crudObj.addWishlist({
                        'Piece': _qtyController.text,
                        'product name': widget.product_detail_name,
                        'price': widget.product_detail_new_price,
                        'picture': widget.product_detail_picture
                      }).then((result) {
                        dialogTrigger(context);
                        // NavigateToUpdateAddress;
                      }).catchError((e) {
                        print(e);
                      });
                    }
                    ;
                  })
            ],
          ),

          // similar product sectio
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

  Future<bool> wishlistTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Added to wishlist', style: TextStyle(fontSize: 15.0)),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Okay"))
            ],
          );
        });
  }

  void NavigateToUpdateAddress() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }
}
