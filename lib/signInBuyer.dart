import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:planto/searchOrder.dart';
import 'package:planto/signUpBuyer.dart';

class signInBuyer extends StatefulWidget {
  @override
  _signInBuyerState createState() => _signInBuyerState();
}

class _signInBuyerState extends State<signInBuyer> {
  String email, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('SignIn'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 50, right: 50, top: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              new Container(
                child: new Image(
                  image: AssetImage('images/logonn.jpg'),
                  width: 70,
                  height: 70,
                ),
              ),
              TextFormField(
                validator: (Input) {
                  // if(input.isEmpty){
                  //   return 'Please Enter Email';
                  // }
                },
                onSaved: (input) => email = input,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                validator: (Input) {
                  // if(input.length<6){
                  //   return 'Please Enter Email';
                  // }
                },
                onSaved: (input) => password = input,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              SizedBox(height: 10),
              RaisedButton(
                onPressed: signInBuyer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("Login"),
              ),
              InkWell(
                  child: Text("Not an account?Register Now"),
                  onTap: NavigateToSignUpBuyer)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signInBuyer() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password))
            .user;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => searchOrder()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  void NavigateToSignUpBuyer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => signUpBuyer()));
  }
}
