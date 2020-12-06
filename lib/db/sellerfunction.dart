import 'package:flutter/material.dart';
import 'package:planto/db/category.dart';
import 'package:planto/db/users.dart';
import 'package:planto/db/add_product.dart';
import 'package:planto/db/category.dart';
import 'package:planto/db/type.dart';
import 'package:planto/viewProfileSeller.dart';
import 'package:planto/viewOrders.dart';
import 'package:planto/map2.dart';
import 'package:planto/utils/mapUpdated.dart';
import 'package:planto/db/view_products.dart';

// import 'package:fluttertoast/fluttertoast.dart';

class sellerfunction extends StatefulWidget {
  @override
  _sellerfunctionState createState() => _sellerfunctionState();
}

class _sellerfunctionState extends State<sellerfunction> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  GlobalKey<FormState> _categoryformkey = GlobalKey();
  GlobalKey<FormState> _typeformkey = GlobalKey();
  categoryService _categoryservice = categoryService();
  typeService _typeservice = typeService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(''),
      ),
      body: GridView(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              child: ListTile(
                title: FlatButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AddProduct()));
                    },
                    icon: Icon(
                      Icons.add,
                      size: 65.0,
                      color: Colors.red,
                    ),
                    label: Text('')),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 25.0),
                  child: Text(
                    'Add product',
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              child: ListTile(
                title: FlatButton.icon(
                    onPressed: NavigateToViewProduct,
                    icon: Icon(
                      Icons.change_history,
                      size: 60.0,
                      color: Colors.red,
                    ),
                    label: Text('')),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 25.0),
                  child: Text(
                    'Product list',
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              child: ListTile(
                title: FlatButton.icon(
                    onPressed: () {
                      _catagoryAlert();
                    },
                    icon: Icon(
                      Icons.add_circle,
                      size: 60.0,
                      color: Colors.red,
                    ),
                    label: Text('')),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 25.0),
                  child: Text(
                    'Add catagory',
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              child: ListTile(
                title: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.category,
                      size: 60.0,
                      color: Colors.red,
                    ),
                    label: Text('')),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 25.0),
                  child: Text(
                    'Catagory list',
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              child: ListTile(
                title: FlatButton.icon(
                    onPressed: () {
                      _typeAlert();
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      size: 60.0,
                      color: Colors.red,
                    ),
                    label: Text('')),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 25.0),
                  child: Text(
                    'Add Type',
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              child: ListTile(
                title: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.assessment,
                      size: 60.0,
                      color: Colors.red,
                    ),
                    label: Text('')),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 25.0),
                  child: Text(
                    'Type list',
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              child: ListTile(
                title: FlatButton.icon(
                    onPressed: () {
                      NavigateToViewSeller();
                      // NavigateToMapUpdated();
                    },
                    icon: Icon(
                      Icons.verified_user,
                      size: 60.0,
                      color: Colors.red,
                    ),
                    label: Text('')),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 25.0),
                  child: Text(
                    'My Profile',
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              child: ListTile(
                title: FlatButton.icon(
                    onPressed: () {
                      NavigateToViewOrders();
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 60.0,
                      color: Colors.red,
                    ),
                    label: Text('')),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 25.0),
                  child: Text(
                    'View Orders ',
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _catagoryAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryformkey,
        child: TextFormField(
          controller: categoryController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Catagoty can not be empty';
            }
          },
          decoration: InputDecoration(hintText: "add catagory"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (categoryController.text != null) {
                _categoryservice.createCategory(categoryController.text);
              }
              // Fluttertoast.showToast(msg: 'Catagory created');
              Navigator.pop(context);
            },
            child: Text('Add')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'))
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _typeAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _typeformkey,
        child: TextFormField(
          controller: typeController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Type can not be empty';
            }
          },
          decoration: InputDecoration(hintText: "add type"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (typeController.text != null) {
                _typeservice.createType(typeController.text);
              }
              // Fluttertoast.showToast(msg: 'Catagory created');
              Navigator.pop(context);
            },
            child: Text('Add')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'))
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void NavigateToViewSeller() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => viewProfileSeller()));
  }

  void NavigateToViewOrders() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => viewOrders()));
  }

  void NavigateToMapUpdated() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => mapRo2()));
  }

  void NavigateToViewProduct() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => viewproducts()));
  }
}
