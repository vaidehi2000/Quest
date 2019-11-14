import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quest_app/Screens/Resource_page.dart';
import 'package:quest_app/Screens/login_screen.dart';
import 'package:quest_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  static const id = "profile_page";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseUser loggedInUser;
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  void getEmail() async {
    final user = await _auth.currentUser();
    if (user != null) {
      loggedInUser = user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: kMainColor,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: _firestore.collection('signup').snapshots(),
              builder: (context, snapshot) {
                getEmail();
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final data = snapshot.data.documents;
                String name = "NOthing(name)";
                for (var d in data) {
                  if (loggedInUser.email.compareTo(d.data['email']) == 0) {
                    name = d.data['name'];
                  }
                }
                return Container(
                  width: 1000.0,
                  height: 300.0,
                  color: kMainColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Icon(
                        Icons.account_circle,
                        size: 150.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 14.0,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 23.0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 14.0,
                ),
                Icon(
                  Icons.power_settings_new,
                  size: 30.0,
                ),
                SizedBox(
                  width: 14.0,
                ),
                GestureDetector(
                  onTap: () async {
                    await _auth.signOut();
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName(LoginScreen.id),
                    );
                  },
                  child: Text(
                    "LogOut",
                    style: TextStyle(fontSize: 23.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50.0,
              child: RaisedButton(
                color: kMainColor2,
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50.0,
              child: RaisedButton(
                color: kMainColor2,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ResourceScreen.id);
                },
                child: Text(
                  "Resources",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
