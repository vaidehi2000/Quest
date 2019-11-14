import 'package:flutter/material.dart';
import 'package:quest_app/Screens/paper_page.dart';
import 'package:quest_app/constants.dart';
import 'package:quest_app/makeBox.dart';
import 'paper_page_teacher.dart';

class YearScreen extends StatelessWidget {
  static const id = "year";
  int type;
  String subject;
  YearScreen({this.subject, this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Years"),
        backgroundColor: kMainColor,
      ),
      body: Column(
        children: <Widget>[
          MakeBox(
            title: "2019",
            icon: Icons.calendar_today,
            onTap: () {
              if (type == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaperScreen(
                      subject: subject,
                      year: "2019",
                    ),
                  ),
                );
              } else if (type == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaperScreen1(
                      subject: subject,
                      year: "2019",
                    ),
                  ),
                );
              }
            },
          ),
          MakeBox(
            title: "2018",
            icon: Icons.calendar_today,
            onTap: () {
              if (type == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaperScreen(
                      subject: subject,
                      year: "2018",
                    ),
                  ),
                );
              } else if (type == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaperScreen1(
                      subject: subject,
                      year: "2018",
                    ),
                  ),
                );
              }
            },
          ),
          MakeBox(
            title: "2017",
            icon: Icons.calendar_today,
            onTap: () {
              if (type == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaperScreen(
                      subject: subject,
                      year: "2017",
                    ),
                  ),
                );
              } else if (type == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaperScreen1(
                      subject: subject,
                      year: "2017",
                    ),
                  ),
                );
              }
            },
          ),
          MakeBox(
            title: "2016",
            icon: Icons.calendar_today,
            onTap: () {
              if (type == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaperScreen(
                      subject: subject,
                      year: "2016",
                    ),
                  ),
                );
              } else if (type == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaperScreen1(
                      subject: subject,
                      year: "2016",
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
