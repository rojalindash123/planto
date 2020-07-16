import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planto/updateProfileSeller.dart';
import 'package:firebase_auth/firebase_auth.dart';
class viewProfileSeller extends StatefulWidget {
  @override
  _viewProfileSellerState createState() => _viewProfileSellerState();
}

class _viewProfileSellerState extends State<viewProfileSeller> {
  // var firebaseUser = FirebaseAuth.instance.currentUser();
  // const viewProfileSeller({Key key,this.user}):super(key:key);
  // final FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title:new Text("Profile")
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('ProfileSeller').snapshots(),
        builder: (context,snapshot){
          //Text(snapshot.data.documents[0]['name']);
          if (!snapshot.hasData) return Text("loading...");
          return Column(
              
               children: <Widget>[
                 Padding(padding: EdgeInsets.only(top:30)),
                Row(children: <Widget>[
                  Padding(padding: EdgeInsets.only(left:100,top:50)),
                  Icon(Icons.account_circle,
                  color:Colors.white,size: 135,)
                  
                ],),


                 Row(children: <Widget>[
                   
                   Padding(padding: EdgeInsets.only(left:120,top:50)),
                   new Text('Name : ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                   Text(snapshot.data.documents[0]['name'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                 ],
                 ),
                 Row(children: <Widget>[
                   Padding(padding: EdgeInsets.only(left:120,top:50)),
                   new Text('Address : ',style: TextStyle(
                     fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                   Text(snapshot.data.documents[0]['address'],
                   style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                 ],),
                 Row(children: <Widget>[
                   Padding(padding: EdgeInsets.only(left:60,top:50)),
                   new Text('Mobile Number : ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                   Text(snapshot.data.documents[0]['mobile'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                 ],),
                 Row(children: <Widget>[
                   Padding(padding: EdgeInsets.only(left:100,top:50)),
                   new Text('Occupation : ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                   Text(snapshot.data.documents[0]['occupation'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                 ],),
                 RaisedButton(onPressed: NavigateToUpdateSeller,
                 child: Text('Update Profie'),),

               ],
               
            
          );
        },

      ),
      
    );
  }
  void NavigateToUpdateSeller(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>updateSeller()));
  }
}