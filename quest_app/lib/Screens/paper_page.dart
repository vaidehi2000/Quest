import 'package:flutter/material.dart';
import 'package:quest_app/constants.dart';
import 'package:quest_app/makeBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class PaperScreen extends StatefulWidget {
  static const id = 'paper';
  String year;
  String subject;
  PaperScreen({this.year, this.subject});
  @override
  _PaperScreenState createState() => _PaperScreenState();
}

class _PaperScreenState extends State<PaperScreen> {
  final _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paper'),
        backgroundColor: kMainColor,
      ),
      body: Column(
        children: <Widget>[
          MakeBox(
            title: 'In-Sem1',
            icon: Icons.file_download,
            onTap: () async {
              print(widget.subject);
              print(widget.year);
              final info = await _firestore
                  .collection('papers')
                  .where('subject', isEqualTo: widget.subject)
                  .where('year', isEqualTo: widget.year)
                  .where('sem', isEqualTo: '1')
                  .getDocuments();
              var url = info.documents[0].data['paper'];
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          MakeBox(
            title: 'In-Sem2',
            icon: Icons.file_download,
            onTap: () async {
              print(widget.subject);
              print(widget.year);
              final info = await _firestore
                  .collection('papers')
                  .where('subject', isEqualTo: widget.subject)
                  .where('year', isEqualTo: widget.year)
                  .where('sem', isEqualTo: '2')
                  .getDocuments();
              print(info.documents[0].data);
              var url = info.documents[0].data['paper'];
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          MakeBox(
            title: 'End-Sem',
            icon: Icons.file_download,
            onTap: () async {
              print(widget.subject);
              print(widget.year);
              final info = await _firestore
                  .collection('papers')
                  .where('subject', isEqualTo: widget.subject)
                  .where('year', isEqualTo: widget.year)
                  .where('sem', isEqualTo: '3')
                  .getDocuments();
              print(info.documents[0].data);
              var url = info.documents[0].data['paper'];
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
    );
  }
}
