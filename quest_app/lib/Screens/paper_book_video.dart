import 'package:flutter/material.dart';
import 'package:quest_app/Screens/syllubuspage.dart';
import 'package:quest_app/Screens/year_page.dart';
import 'package:quest_app/constants.dart';
import 'package:quest_app/makeBox.dart';
import 'predictionpagr.dart';

class PBVScreen extends StatelessWidget {
  static const id = 'paper_book_video';
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
            MakeBox(title: "Books", icon: Icons.book, onTap: () {}),
            MakeBox(title: "Videos", icon: Icons.videocam, onTap: () {}),
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
            type == 0
                ? MakeBox(
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
                    })
                : Container(),
          ],
        ),
      ),
    );
  }
}
