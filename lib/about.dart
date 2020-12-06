import 'package:flutter/material.dart';
import 'package:planto/loginuser.dart';
import 'package:planto/loginSeller.dart';
import 'package:planto/welcome.dart';
import 'package:planto/feedback.dart';

class about extends StatefulWidget {
  @override
  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text("welcome"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.home), onPressed: NavigateToHome)
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new DrawerHeader(
              child: new Text('header'),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/planto1.jpg')),
                color: Colors.green,
                // AssetImage assetImage=AssetImage('images/planto1.jpg'),
              ),
            ),
            new ListTile(
              leading: Icon(Icons.account_circle),
              title: new Text(
                'Seller',
                style: TextStyle(fontSize: 18),
              ),
              onTap: NavigateToSignInSeller,
            ),
            new ListTile(
              leading: Icon(Icons.account_circle),
              title: new Text(
                'Buyer',
                style: TextStyle(fontSize: 18),
              ),
              onTap: NavigateToSignInBuyer,
            ),
            new ListTile(
              leading: Icon(Icons.info),
              title: new Text(
                'About',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {},
            ),
            new ListTile(
              leading: Icon(Icons.feedback),
              title: new Text(
                'Feedback',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {},
            )
          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 12.0, left: 5.0, right: 5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    child: Image.asset(
                      'images/images.jpg',
                      width: 600,
                      height: 180,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 130),
            title: new Text('About Us',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white)),
            // subtitle: new Text(
            //   "Hello"
            // ),
          ),
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
                text:
                    " Gardening is also associated with promoting emotional and environmental benefits for living and working. It gives many day-to-day benefits, like mood-boosting, air purifying, anti depressing and memory-enhancing effects.Here we have different attractive plant packs for gardening .With increasing pollution, the ecosystem is being burdened day by day. So we are not being able to breathe in fresh air which is the sole reason behind growing rate of illness",
                style: TextStyle(fontSize: 15.0))
          ]))
        ],
      ),
    );
  }

  void NavigateToSignInSeller() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => loginseller()));
  }

  void NavigateToSignInBuyer() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => loginuser()));
  }

  void NavigateToHome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => welcome()));
  }

  void NavigateToFeedback() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => feedback()));
  }
}
