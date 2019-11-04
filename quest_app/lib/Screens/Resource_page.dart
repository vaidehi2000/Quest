import 'package:flutter/material.dart';
import 'package:quest_app/constants.dart';
import 'profile_page.dart';

class ResourceScreen extends StatefulWidget {
  static const id = "resourcePage";
  @override
  _ResourceScreenState createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resources"),
        backgroundColor: kMainColor,
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50.0,
              child: RaisedButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ProfileScreen.id);
                },
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
                color: Colors.blueAccent,
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
