import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_webservice/distance.dart';
import 'package:planto/loginuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planto/db/users.dart';
import 'package:planto/profileBuyer.dart';

class registeruser extends StatefulWidget {
  @override
  _registeruserState createState() => _registeruserState();
}

class _registeruserState extends State<registeruser> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  // UserServices _userServices = UserServices();
  String email, password, name, confirmpassword;
  bool hidepass = true;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmpasswordTextController =
      TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Image.asset(
            "images/back6.jpg",
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
          SingleChildScrollView(
            child: Container(
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
                            controller: _nameTextController,
                            decoration: InputDecoration(
                                hintText: 'Full name',
                                // fillColor: Colors.white,
                                icon: Icon(Icons.person),
                                border: InputBorder.none),
                            onSaved: (input) => name = input,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Name can not be blank";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 28.0, right: 28.0),
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
                                border: InputBorder.none
                                // border: OutlineInputBorder(),
                                ),
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
                          top: 20.0, left: 28.0, right: 28.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.5),
                        elevation: 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                              title: TextFormField(
                                controller: _passwordTextController,
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    // fillColor: Colors.white,
                                    icon: Icon(Icons.lock),
                                    border: InputBorder.none
                                    // border: OutlineInputBorder(),
                                    ),
                                // keyboardType: TextInputType.emailAddress,
                                onSaved: (input) => password = input,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Password can not be blank";
                                  } else if (value.length < 6) {
                                    return 'The password has to be at least 6 characters long';
                                  }
                                  return null;
                                },
                                obscureText: hidepass,
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    hidepass = false;
                                  });
                                },
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 28.0, right: 28.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.5),
                        elevation: 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            title: TextFormField(
                              controller: _confirmpasswordTextController,
                              decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  // fillColor: Colors.white,
                                  icon: Icon(Icons.lock),
                                  border: InputBorder.none),
                              onSaved: (input) => confirmpassword = input,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Password can not be blank";
                                } else if (value.length < 6) {
                                  return 'The password has to be at least 6 characters long';
                                } else if (_passwordTextController.text !=
                                    value) {
                                  return 'Password does not match';
                                }
                              },
                              obscureText: hidepass,
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    hidepass = false;
                                  });
                                }),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 60.0, right: 60.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.red,
                        elevation: 0.0,
                        child: MaterialButton(
                          onPressed: signUpBuyer,
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            'Register',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 25.0),
                    //   child: SizedBox(
                    //     width: 180.0,
                    //     height: 40,
                    //     child: FlatButton(
                    //       onPressed: signUpBuyer,
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(20)),
                    //       color: Colors.red,
                    //       textColor: Colors.white,
                    //       child: Text("Register"),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Future validateForm() async {
  //   FormState formState = _formkey.currentState;
  //   if (formState.validate()) {
  //     formState.reset();
  //     FirebaseUser user = await firebaseAuth.currentUser();
  //     if (user == null) {
  //       firebaseAuth
  //           .createUserWithEmailAndPassword(
  //               email: _emailTextController.text,
  //               password: _passwordTextController.text)
  //           .then((user) => {
  //                 _userServices.createUser({
  //                   "username": user.user.displayName,
  //                   "email": user.user.email,
  //                   "uid": user.user.uid
  //                 })
  //               });
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => profileBuyer()));
  //     }
  //   }
  // }

  void signUpBuyer() async {
    // final formState = _formKey.currentState;
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      // try {
      // FirebaseUser user = (await FirebaseAuth.instance
      //         .createUserWithEmailAndPassword(
      //             email: email, password: password))
      //     .user;
      // FirebaseUser user = await firebaseAuth.currentUser();

      firebaseAuth
          .createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((user1) => {
                //       _userServices.createUser({
                //         "username": _nameTextController.text,
                //         "email": user.user.email,
                //         "uid": user.user.uid
                //       })
                //     });
                Firestore.instance
                    .collection('users')
                    .document()
                    .setData({name: name, email: email, 'uid': user1.user.uid})
              });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => profileBuyer()));
    }
  }
}
