import 'package:flutter/material.dart';
import 'package:planto/placeOrder.dart';
class garden extends StatefulWidget {
  @override
  _gardenState createState() => _gardenState();
}

class _gardenState extends State<garden> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white70,
      appBar: AppBar(
        // title:new Text('Garden'),

        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),
          onPressed: (){},
          )
        ],
        backgroundColor: Colors.teal,
      ),
      body: ListView(
       
        controller: controller,
        children: <Widget>[
          //  Padding(padding: EdgeInsets.only(top:10)),
         Row(children: <Widget>[
           Expanded(
                        child: InkWell(
                          onTap: NavigateToPlaceOrder,
              child: Container(
                margin: EdgeInsets.only(left:10,top:20,bottom:10),
                child: Center(child: Text('Red Rose',style:TextStyle(color: Colors.white) ,),),
              width: 200.0,
              height: 180.0,
             decoration: BoxDecoration(image: DecorationImage(
               
               image:
               
               AssetImage('images/redRose.jpg',
               
               ),
               
               
               
               )
             )
         ),
                        ),
           ),
           Expanded(
             
                        child: InkWell(
                          
                          onTap: NavigateToPlaceOrder,
              child: Container(
                margin: EdgeInsets.only(top:20,bottom:10),
                child: Center(child: Text('Cactus',style:TextStyle(color: Colors.white) ,),),
              width: 200.0,
                      height: 180.0,
             decoration: BoxDecoration(image: DecorationImage(
               image:AssetImage('images/cactus.jpg',
               
               ),
               
               ),
             ),
         ),
                        ),
           ),

           ],
           ),

         Row(children: <Widget>[
           Expanded(
                        child: InkWell(
                          onTap: NavigateToPlaceOrder,
              child: Container(
                margin: EdgeInsets.only(left:10,top: 20,bottom: 10),
                child: Center(child: Text('Canna Lily',style:TextStyle(color: Colors.white) ,),),
              width: 200.0,
                      height: 180.0,
             decoration: BoxDecoration(image: DecorationImage(
               image:AssetImage('images/cannaLily.jpg',
               
               ),
               
               )
             )
         ),
                        ),
           ),
            SizedBox(height: 50),
           Expanded(
             
                        child: InkWell(
                          
                          onTap: NavigateToPlaceOrder,
              child: Container(
                margin: EdgeInsets.only(top: 20,bottom: 10),
                child: Center(child: Text('Red Rose',style:TextStyle(color: Colors.white) ,),),
               width: 200.0,
                       height: 180.0,
             decoration: BoxDecoration(image: DecorationImage(
               image:AssetImage('images/redRose.jpg',
               
               ),
               
               ),
             ),
         ),
                        ),
           ),
         ],),
         Row(children: <Widget>[
           Expanded(
                        child: InkWell(
                          onTap: NavigateToPlaceOrder,
              child: Container(
                margin: EdgeInsets.only(left:10,top: 20,bottom: 10),
                child: Center(child: Text('Cardinal Climber',style:TextStyle(color: Colors.white) ,),),
              width: 200.0,
                      height: 180.0,
             decoration: BoxDecoration(image: DecorationImage(
               image:AssetImage('images/cardinalClimber.jpg' ,
               
               ),
               
               )
             )
         ),
                        ),
           ),
            SizedBox(height: 50),
           Expanded(
             
                        child: InkWell(
                          
                          onTap: NavigateToPlaceOrder,
              child: Container(
                
                margin: EdgeInsets.only(left:10,top: 20,bottom: 10),
                child: Center(child: Text('Dahlias',style:TextStyle(color: Colors.white) ,),),
              width: 200.0,
                      height: 180.0,
             decoration: BoxDecoration(image: DecorationImage(
               image:AssetImage('images/dahlias.jpg',
               
               ),
               
               ),
             ),
         ),
                        ),
           ),
         ],),
         Row(children: <Widget>[
           Expanded(
                        child: InkWell(
                          onTap: NavigateToPlaceOrder,
              child: Container(
                margin: EdgeInsets.only(left:10,top: 20,bottom: 10),
                child: Center(child: Text('Moth Orchid',style:TextStyle(color: Colors.white) ,),),
              width: 200.0,
                      height: 180.0,
             decoration: BoxDecoration(image: DecorationImage(
               image:AssetImage('images/mothOrchid.jpg',
               
               ),
               
               )
             )
         ),
                        ),
           ),
            SizedBox(height: 50),
           Expanded(
             
                        child: InkWell(
                          
                          onTap: NavigateToPlaceOrder,
              child: Container(
                margin: EdgeInsets.only(top: 20,bottom: 10),
                child: Center(child: Text('Rose',style:TextStyle(color: Colors.white) ,),),
              width: 200.0,
                      height: 180.0,
             decoration: BoxDecoration(image: DecorationImage(
               image:AssetImage('images/rose.jpg',
               
               ),
               
               ),
             ),
         ),
                        ),
           ),
         ],),
         Row(children: <Widget>[
          
            SizedBox(height: 50),
           
         ],)
        ],
            
              
      ),
    );
  }
  void NavigateToPlaceOrder(){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>placeOrder()));
  }
}