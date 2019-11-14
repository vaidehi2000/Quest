import 'package:flutter/material.dart';
import 'package:quest_app/Screens/upload_paper.dart';
import 'package:quest_app/constants.dart';
import 'package:quest_app/makeBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'upload_paper.dart';

class PaperScreen1 extends StatefulWidget {
  static const id = 'paperteacher';
  String year;
  String subject;
  PaperScreen1({this.year, this.subject});
  @override
  _PaperScreen1State createState() => _PaperScreen1State();
}

class _PaperScreen1State extends State<PaperScreen1> {
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadScreen(
                subject: widget.subject,
                year: widget.year,
              ),
            ),
          );
        },
      ),
    );
  }
}
