import 'package:flutter/material.dart';
class decoration extends StatefulWidget {
  @override
  _decorationState createState() => _decorationState();
}

class _decorationState extends State<decoration> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title:new Text('Garden')
      ),
      body: ListView(
       
        controller: controller,
        children: <Widget>[
           Padding(padding: EdgeInsets.only(top:20)),
          Row(children: [
            
             Expanded(child: InkWell(
                      onTap: (){},
                    child:ClipRRect(
                      borderRadius:BorderRadius.all(Radius.circular(10.0)),
                      child:Image.asset(
                      'images/cactus.jpg',
                      width: 200.0,
                      height: 180.0,
                      
                    ),
                    )
                  ),
                    
                    
                    
                  ),
                  // Container(child: Text("cactus"),),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                    child:ClipRRect(
                      borderRadius:BorderRadius.all(Radius.circular(5.0)),
                      child:Image.asset(
                      'images/cactus.jpg',
                      width: 200.0,
                      height: 180.0,
                      
                    ),
                    )
                  ),
                  ),
                  // Container(child: Text("cactus"),),
          ],),
          SizedBox(height: 20),

          Row(children: [
            
             Expanded(child: InkWell(
                      onTap: (){},
                    child:ClipRRect(
                      borderRadius:BorderRadius.all(Radius.circular(10.0)),
                      child:Image.asset(
                      'images/cactus.jpg',
                      width: 200.0,
                      height: 180.0,
                      
                    ),
                    )
                  ),
                    
                    
                    
                  ),
                  // Container(child: Text("cactus"),),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                    child:ClipRRect(
                      borderRadius:BorderRadius.all(Radius.circular(5.0)),
                      child:Image.asset(
                      'images/cactus.jpg',
                      width: 200.0,
                      height: 180.0,
                      
                    ),
                    )
                  ),
                  ),
                  // Container(child: Text("cactus"),),
          ],),
           SizedBox(height: 20),
          Row(children: [
            
             Expanded(child: InkWell(
                      onTap: (){},
                    child:ClipRRect(
                      borderRadius:BorderRadius.all(Radius.circular(10.0)),
                      child:Image.asset(
                      'images/cactus.jpg',
                      width: 200.0,
                      height: 180.0,
                      
                    ),
                    )
                  ),
                    
                    
                    
                  ),
                  // Container(child: Text("cactus"),),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                    child:ClipRRect(
                      borderRadius:BorderRadius.all(Radius.circular(5.0)),
                      child:Image.asset(
                      'images/cactus.jpg',
                      width: 200.0,
                      height: 180.0,
                      
                    ),
                    )
                  ),
                  ),
                  // Container(child: Text("cactus"),),
          ],),
           SizedBox(height: 20),
          Row(children: [
            
             Expanded(child: InkWell(
                      onTap: (){},
                    child:ClipRRect(
                      borderRadius:BorderRadius.all(Radius.circular(10.0)),
                      child:Image.asset(
                      'images/cactus.jpg',
                      width: 200.0,
                      height: 180.0,
                      
                    ),
                    )
                  ),
                    
                    
                    
                  ),
                  // Container(child: Text("cactus"),),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                    child:ClipRRect(
                      borderRadius:BorderRadius.all(Radius.circular(5.0)),
                      child:Image.asset(
                      'images/cactus.jpg',
                      width: 200.0,
                      height: 180.0,
                      
                    ),
                    )
                  ),
                  ),
                  // Container(child: Text("cactus"),),
          ],),
          
        ],
            
              
      ),
    );
  }
}