import 'package:flutter/material.dart';
import 'package:planto/home.dart';
import 'package:planto/signUpSeller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginSeller extends StatefulWidget {
  @override
  _loginSellerState createState() => _loginSellerState();
}

class _loginSellerState extends State<loginSeller> {
  String email, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Sign In"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 50, right: 50, top: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // DecorationImage(image: AssetImage('images/planto1.jpg')),
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
                decoration: InputDecoration(
                    icon: Icon(Icons.email), labelText: "Email"),
              ),
              TextFormField(
                validator: (Input) {
                  // if(input.length<6){
                  //   return 'Please Enter Email';
                  // }
                },
                onSaved: (input) => password = input,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock), labelText: "Password"),
                obscureText: true,
              ),
              RaisedButton(
                onPressed: signInSeller,
                child: Text("Login"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.teal,
                textColor: Colors.white,
              ),
              // new Text('but this is',
              //         style: new TextStyle(color: Colors.blue),
              //       ),
              InkWell(
                  child: Text("Not an account?Register Now"),
                  onTap: NavigateToSignUpSeller)
            ],
          ),
        ),
      ),
    );
  }

  void NavigateToSignUpSeller() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => signUpSeller()));
  }
  // void NavigateToHome(){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
  // }

  Future<void> signInSeller() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password))
            .user;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => stock()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
