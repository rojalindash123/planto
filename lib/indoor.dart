import 'package:flutter/material.dart';
class indoor extends StatefulWidget {
  @override
  _indoorState createState() => _indoorState();
}

class _indoorState extends State<indoor> {
  @override
  Widget build(BuildContext context) {
    return Container(
        
        padding: EdgeInsets.only(right:120,top: 10),
        // Padding(padding:EdgeInsets.only(left: 20)),
              child: Column(
          children: 
        <Widget>[
          Row(
            children: [
            Expanded(child: Column(children: <Widget>[
              Image.asset('images/aloevera.jpg',width: 190,height: 150,),
              Text('Aloe Vera')
            ],
            ),
            )
          ],),
          Row(
            children: [
            Expanded(child: Column(children: <Widget>[
              Image.asset('images/aloevera.jpg',width: 190,height: 150,),
              Text('Aloe Vera')
            ],
            ),
            )
          ],)
          
        ],
        
        ),
      );
  }
}