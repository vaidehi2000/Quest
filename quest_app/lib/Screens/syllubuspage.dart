import 'package:flutter/material.dart';
import 'package:quest_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Syllubus extends StatefulWidget {
  static const id = 'syllubus';
  String subject;
  Syllubus({this.subject});
  @override
  _SyllubusState createState() => _SyllubusState();
}

class _SyllubusState extends State<Syllubus> {
  final _firestore = Firestore.instance;
  String subject = '';
  @override
  void initState() {
    super.initState();
    if (widget.subject.compareTo('Database Management') == 0)
      subject = 'dbms';
    else if (widget.subject.compareTo('Linear Algebra') == 0)
      subject = 'la';
    else if (widget.subject.compareTo('Discrete Mathematics') == 0)
      subject = 'dm';
    print(subject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text('Syllabus'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _firestore.collection(subject).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            List<Widget> names = List();
            final subjects = snapshot.data.documents;
            int i = 1;
            for (var subject in subjects) {
              //print(subject.data['topic']);
              names.add(
                Text(
                  "$i" + ")  " + subject.data['topic'],
                ),
              );
              i++;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: names,
            );
          },
        ),
      ),
    );
  }
}
