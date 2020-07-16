import 'package:flutter/material.dart';
import 'package:planto/signInSeller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signUpSeller extends StatefulWidget {
  @override
  _signUpSellerState createState() => _signUpSellerState();
}

class _signUpSellerState extends State<signUpSeller> {
  String name, address, email, password, password2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.teal, title: new Text("Register now")),
      body: Container(
        margin: EdgeInsets.only(left: 50, right: 50),
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
                onSaved: (input) => name = input,
                decoration: InputDecoration(
                    icon: Icon(Icons.email), labelText: "Email"),
              ),
              TextFormField(
                validator: (Input) {},
                onSaved: (input) => password = input,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock), labelText: "Password"),
                obscureText: true,
              ),
              TextFormField(
                validator: (Input) {},
                onSaved: (input) => password2 = input,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline),
                    labelText: "Confirm Password"),
                obscureText: true,
              ),
              RaisedButton(
                onPressed: signUpSeller,
                child: Text("Register"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.teal,
                textColor: Colors.white,
              ),
              InkWell(
                  child: Text("Already have an account?Login Now"),
                  onTap: NavigateToSignInSeller)
            ],
          ),
        ),
      ),
    );
  }

  void NavigateToSignInSeller() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => loginSeller()));
  }

  void signUpSeller() async {
    // final formState = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: email, password: password))
            .user;
        //user.sendEmailVerification();
        //Navigator.of(context).pop();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => loginSeller()));
      } catch (e) {
        print(e.message);
      }
    }
    // else{
    //   new Container(child:text("Invalid credential"));
    // }
  }
}
