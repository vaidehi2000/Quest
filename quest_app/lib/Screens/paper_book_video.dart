import 'package:flutter/material.dart';
import 'package:quest/Screens/syllubuspage.dart';
import 'package:quest/Screens/year_page.dart';
import 'package:quest/constants.dart';
import 'package:quest/makeBox.dart';
import 'predictionpagr.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PBVScreen extends StatelessWidget {
  static const id = 'paper_book_video';
  final _firestore = Firestore.instance;
  PBVScreen({this.subject, this.type});
  String subject;
  int type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
        backgroundColor: kMainColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MakeBox(
              title: "Paper",
              icon: Icons.file_download,
              onTap: () {
                print(type);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => YearScreen(
                      subject: subject,
                      type: type,
                    ),
                  ),
                );
              },
            ),
            MakeBox(
              title: "Books",
              icon: Icons.book,
              onTap: () async {
                final data = await _firestore
                    .collection('book')
                    .where('subject', isEqualTo: subject)
                    .getDocuments();
                var url = data.documents[0].data['link'];
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            MakeBox(
              title: "Assignments",
              icon: Icons.subject,
              onTap: () {},
            ),
            MakeBox(
              title: "Videos",
              icon: Icons.videocam,
              onTap: () async {
                final data = await _firestore
                    .collection('video')
                    .where('subject', isEqualTo: subject)
                    .getDocuments();
                var url = data.documents[0].data['link'];
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            MakeBox(
                title: "Syllabus",
                icon: Icons.insert_drive_file,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Syllubus(subject: subject),
                    ),
                  );
                }),
            type == 1
                ? Container()
                : MakeBox(
                    title: "Predict Paper",
                    icon: Icons.graphic_eq,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PredictionPage(
                            subject: subject,
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
