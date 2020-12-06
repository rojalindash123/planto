import 'package:flutter/material.dart';
import 'package:planto/crud.dart';

class feedback extends StatefulWidget {
  @override
  _feedbackState createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  String name, email, feedaback;
  crudMethods crudObj = new crudMethods();
  final ThemeData Theme = ThemeData(primarySwatch: Colors.teal);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: new Text('Feedback'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 35.0, bottom: 200, top: 35, right: 35),
        child: Card(
          margin: EdgeInsets.only(left: 10),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 15,
            ),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onSaved: (input) => name = input,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person), labelText: "Enter Name"),
                    onChanged: (value) {
                      this.name = value;
                    },
                  ),
                  TextFormField(
                    onSaved: (input) => email = input,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email), labelText: "Enter Email"),
                    onChanged: (value) {
                      this.email = value;
                    },
                  ),
                  TextFormField(
                    onSaved: (input) => feedaback = input,
                    decoration: InputDecoration(
                        icon: Icon(Icons.comment),
                        labelText: "Enter Your Comment"),
                    onChanged: (value) {
                      this.feedaback = value;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    // margin: EdgeInsets.all(15.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                        crudObj.addFeedback({
                          'name': this.name,
                          'email': this.email,
                          'feedback': this.feedaback
                        }).then((result) {
                          dialogTrigger(context);
                        }).catchError((e) {
                          print(e);
                        });
                      },
                      child: Text('Submit'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text('Thanks for Feedback ', style: TextStyle(fontSize: 15.0)),
            actions: <Widget>[
              Icon(Icons.done_all),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Alright"))
            ],
          );
        });
  }
}
