import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:planto/signInBuyer.dart';

class signUpBuyer extends StatefulWidget {
  @override
  _signUpBuyerState createState() => _signUpBuyerState();
}

class _signUpBuyerState extends State<signUpBuyer> {
  String email, password, password2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text('Sign Up')),
      body: Container(
        margin: EdgeInsets.only(left: 50, right: 50, top: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              new Container(
                child: new Image(
                  image: AssetImage('images/logonn.jpg'),
                  width: 70,
                  height: 50,
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
                validator: (Input) {},
                onSaved: (input) => password = input,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              TextFormField(
                validator: (Input) {},
                onSaved: (input) => password2 = input,
                decoration: InputDecoration(labelText: "Confirm Password"),
                obscureText: true,
              ),
              SizedBox(height: 05),
              RaisedButton(
                onPressed: signUpBuyer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("Register"),
              ),
              InkWell(
                  child: Text("Already have an account?Login Now"),
                  onTap: NavigateToSignInBuyer)
            ],
          ),
        ),
      ),
    );
  }

  void signUpBuyer() async {
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
            context, MaterialPageRoute(builder: (context) => signInBuyer()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  void NavigateToSignInBuyer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => signInBuyer()));
  }
}
