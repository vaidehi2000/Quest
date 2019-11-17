import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_app/Screens/paper_book_video.dart';
import 'package:quest_app/constants.dart';
import 'profile_page.dart';
import 'package:quest_app/makeBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResourceScreen2 extends StatefulWidget {
  static const id = "resourcePage_admin";

  @override
  _ResourceScreen2State createState() => _ResourceScreen2State();
}

class _ResourceScreen2State extends State<ResourceScreen2> {
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resources"),
        backgroundColor: kMainColor,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _firestore.collection('subject').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            List<Widget> names = List();
            final subjects = snapshot.data.documents;
            for (var subject in subjects) {
              //print(subject.data['name']);
              names.add(
                MakeBox(
                  title: subject.data['name'],
                  icon: Icons.insert_drive_file,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PBVScreen(
                          subject: subject.data['name'],
                          type: 2,
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            //print(names);
            return Column(
              children: names,
            );
          },
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50.0,
              child: RaisedButton(
                color: kMainColor2,
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
