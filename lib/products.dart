import 'package:flutter/material.dart';
import 'package:planto/product_details.dart';

class products extends StatefulWidget {
  @override
  _productsState createState() => _productsState();
}

class _productsState extends State<products> {
  var product_list = [
    {
      "name": "Sunflower",
      "picture": "images/sunflower.jpg",
      "old_price": 120,
      "price": 99,
    },
    {
      "name": "Rose",
      "picture": "images/rose.jpg",
      "old_price": 200,
      "price": 149,
    },
    {
      "name": "Red Rose",
      "picture": "images/redRose.jpg",
      "old_price": 200,
      "price": 149,
    },
    {
      "name": "Moth Orchid",
      "picture": "images/mothOrchid.jpg",
      "old_price": 200,
      "price": 149,
    },
    {
      "name": "Dahlias",
      "picture": "images/dahlias.jpg",
      "old_price": 200,
      "price": 149,
    },
    {
      "name": "Cardinal Climber",
      "picture": "images/cardinalClimber.jpg",
      "old_price": 200,
      "price": 149,
    },
    {
      "name": "Canna Lilly",
      "picture": "images/cannaLily.jpg",
      "old_price": 200,
      "price": 149,
    },
    {
      "name": "Cactus",
      "picture": "images/cactus.jpg",
      "old_price": 200,
      "price": 149,
    },
    {
      "name": "Begonia",
      "picture": "images/begonia.jpg",
      "old_price": 200,
      "price": 149,
    },
  ];
  @override
  Widget build(BuildContext context) {
    // AppBar(
    //   actions: <Widget>[Icon(Icons.search)],
    // );
    return GridView.builder(
      itemCount: product_list.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return single_prod(
          prod_name: product_list[index]['name'],
          prod_picture: product_list[index]['picture'],
          prod_old_price: product_list[index]['old_price'],
          prod_price: product_list[index]['price'],
        );
      },
    );
  }
}

class single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;
  single_prod(
      {this.prod_name,
      this.prod_picture,
      this.prod_old_price,
      this.prod_price});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: new Text('hero1'),
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new productDetails(
                      product_detail_name: prod_name,
                      product_detail_new_price: prod_price,
                      product_detail_old_price: prod_old_price,
                      product_detail_picture: prod_picture))),
              child: GridTile(
                  footer: Container(
                    color: Colors.white,
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                          child: new Text(
                            prod_name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ),
                        new Text(
                          "\$${prod_price}",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  child: Image.asset(
                    prod_picture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
