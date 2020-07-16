import 'package:flutter/material.dart';
import 'package:planto/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planto/viewProfileSeller.dart';
class sellerProfile extends StatefulWidget {
  @override
  _sellerProfileState createState() => _sellerProfileState();
}

class _sellerProfileState extends State<sellerProfile> {
  String name,address,mobile,occupation;
  crudMethods crudObj=new crudMethods();
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title:new Text("Profile"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.verified_user),
            onPressed: NavigateToViewProfileSeller,
            )
        ],
      ),
      body:
        Container(
          
          margin: EdgeInsets.only(top:10),
          padding: EdgeInsets.only(left:20,right: 20),
                  child: Column(
            children: <Widget>[
          TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText:"Name"
                ),
                onChanged: (value) {
                    this.name = value;
                  },
          ),
          TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.location_on),
                  hintText:"Address"
                ),
                onChanged: (value) {
                    this.address = value;
                  },
          ),
          TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.phone_android),
                  hintText:"Mobile"
                ),
                onChanged: (value) {
                    this.mobile = value;
                  },
          ),
          TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.work),
                  hintText:"Occupation"
                ),
                onChanged: (value) {
                    this.occupation = value;
                  },
          ),
          new RaisedButton(
            onPressed: (){
              Navigator.of(context).pop();
              crudObj.addData({
                'name':this.name,
                'address':this.address,
                'mobile':this.mobile,
                'occupation':this.occupation
              }).then((result){
                dialogTrigger(context);
              }).catchError((e){
                print(e);
              });

            },
            child: Text("Set Profile"),
            ),
            RaisedButton(
              child: Text("View Profile"),
              onPressed: NavigateToViewProfileSeller,
        
            
            )

      ],
    ),
      ),
    );
  }
  Future<bool> dialogTrigger(BuildContext context) async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title:Text('Done',style:TextStyle(fontSize: 15.0)),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text("Alright")
              )
          ],
        );
      }
      );
  }
  void NavigateToViewProfileSeller(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>viewProfileSeller()));
  }
}