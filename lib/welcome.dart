import 'package:flutter/material.dart';
import 'package:planto/about.dart';
import 'package:planto/feedback.dart';
import 'package:planto/signInBuyer.dart';
import 'package:planto/signInSeller.dart';
class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
        appBar: AppBar(
          title: Text("welcome"),
          backgroundColor: Colors.teal,
        ),
        drawer: new Drawer(
          child:new ListView(children: <Widget>[
            new DrawerHeader(child: new Text('header'),

            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/planto1.jpg')),
              color:Colors.green,
              // AssetImage assetImage=AssetImage('images/planto1.jpg'),
            ),),
            new ListTile(
              leading: Icon(Icons.account_circle),
              title: new Text('Seller',style: TextStyle(fontSize: 18),),
              onTap: NavigateToSignInSeller,
          ),
          new ListTile(
            leading:Icon(Icons.account_circle),
            title: new Text('Buyer',style: TextStyle(fontSize:18),),
            onTap: NavigateToSignInBuyer,
          ),
          new ListTile(
            leading:Icon(Icons.info),
            title: new Text('About',style: TextStyle(fontSize:18),),
            onTap: NavigateToAbout,
          ),
          new ListTile(
            leading:Icon(Icons.feedback),
            title: new Text('Feedback',style: TextStyle(fontSize:18),),
            onTap: NavigateToFeedback,
          ),
          
          ],
        ),


        ),


        body: Container(
          margin: EdgeInsets.only(top:180,left:120),
                  child: new ClipRRect(
          
      borderRadius: BorderRadius.circular(100),
      child:  Image.asset(
          'images/logonn.jpg',width: 110.0, height: 110.0,
      ),
    ),
        )
        
       

      );
  }
  void NavigateToSignInSeller(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>loginSeller()));
  }
  void NavigateToSignInBuyer(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>signInBuyer()));
  }
  void NavigateToAbout(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>about()));
  }
  void NavigateToFeedback(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>feedback()));
  }
}