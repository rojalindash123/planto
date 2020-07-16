import 'package:flutter/material.dart';
class herbal extends StatefulWidget {
  @override
  _herbalState createState() => _herbalState();
}

class _herbalState extends State<herbal> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:Text('Herbal Plants'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        controller: controller,
        
        children: [
          Padding(padding: EdgeInsets.only(top:20,left:10,right:10)),
        
            Expanded(child: InkWell(
              onTap: (){},
              child: Padding(
            padding: const EdgeInsets.only(left:15.0),
            child:  ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.asset(
                    'images/cactus.jpg',
                    width: 310.0,
                      height: 150.0,
                ),
            ),
        ),
                    )
                    ),
                      Container(
                        padding: EdgeInsets.only(left:150),
                        child: Text("cactus",style: TextStyle(fontSize:18),),
                      
                      ),
                    SizedBox(height: 10),
                    
                    Expanded(child: InkWell(
              onTap: (){},
              child: Padding(
            padding: const EdgeInsets.only(left:5.0),
            child:  ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.asset(
                    'images/cactus.jpg',
                    width: 210.0,
                      height: 150.0,
                      fit: BoxFit.cover,
                ),
            ),
        ),
                    )
                    ),
                    SizedBox(height: 10),
                    Expanded(child: Image.asset(
                      'images/cactus.jpg',      
                      width: 110.0,
                      height: 100.0,
                    ),
                    ),
                    SizedBox(height: 10),
                    Expanded(child: Image.asset(
                      'images/cactus.jpg',      
                      width: 110.0,
                      height: 100.0,
                    ),
                    ),
                    SizedBox(height: 10),
                    Expanded(child: Image.asset(
                      'images/cactus.jpg',      
                      width: 110.0,
                      height: 100.0,
                    ),
                    ),Expanded(child: Image.asset(
                      'images/cactus.jpg',      
                      width: 110.0,
                      height: 100.0,
                    ),
                    ),
                    SizedBox(height: 10),
                    Expanded(child: Image.asset(
                      'images/cactus.jpg',      
                      width: 110.0,
                      height: 100.0,
                    ),
                    ),
                    SizedBox(height: 10),
                    Expanded(child: Image.asset(
                      'images/cactus.jpg',      
                      width: 110.0,
                      height: 100.0,
                    ),
                    ),
                    SizedBox(height: 10),
                    Expanded(child: Image.asset(
                      'images/cactus.jpg',      
                      width: 110.0,
                      height: 100.0,
                    ),
                    ),
                    
                    
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(onTap: _onTap, items: [
      //   BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
      //   BottomNavigationBarItem(
      //       icon: Icon(Icons.person_outline), title: Text("My Page")),
      // ]),
    );
    
  }
  void _onTap(int i) {
    controller.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}