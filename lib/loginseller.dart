import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:planto/registerseller.dart';
import 'package:planto/db/sellerfunction.dart';

class loginseller extends StatefulWidget {
  @override
  _loginsellerState createState() => _loginsellerState();
}

class _loginsellerState extends State<loginseller> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  String email, password;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  bool loading = false;
  bool isLogedin = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    await firebaseAuth.currentUser().then((user) => {
          if (user != null) {setState(() => isLogedin = true)}
        });
    if (isLogedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => sellerfunction()));
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Image.asset(
            "images/back5.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            // width: double.infinity,
          ),
          Container(
            margin: new EdgeInsets.fromLTRB(120, 100, 20, 8),
            child: Icon(
              Icons.account_circle,
              size: 120.0,
              color: Colors.white70,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 250.0, left: 28.0, right: 28.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.5),
                      elevation: 0.5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                          controller: _emailTextController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            // fillColor: Colors.white,
                            icon: Icon(Icons.email),
                            border: InputBorder.none,
                          ),
                          // keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => email = input,
                          validator: (value) {
                            if (value.isEmpty) {
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = new RegExp(pattern);
                              if (!regex.hasMatch(value))
                                return "Please provid valid email id";
                              else
                                return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 28.0, right: 28.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.5),
                      elevation: 0.5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                          controller: _passwordTextController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            // fillColor: Colors.white,
                            icon: Icon(Icons.lock),
                            border: InputBorder.none,
                          ),
                          // keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => password = input,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please provid valid password";
                            } else if (value.length < 6) {
                              return 'The password has to be at least 6 characters long';
                            }
                          },
                          obscureText: true,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: SizedBox(
                      width: 180.0,
                      height: 40,
                      child: FlatButton(
                        onPressed: loginseller,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Login"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      child: Text(
                        "Create an account",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      onTap: NavigateToRegisteruser)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> loginseller() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password))
            .user;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => sellerfunction()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  void NavigateToRegisteruser() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => registerseller()));
  }
}
