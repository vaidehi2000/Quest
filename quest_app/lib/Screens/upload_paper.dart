import 'package:flutter/material.dart';
import 'package:quest_app/constants.dart';
import 'package:quest_app/main.dart';

class UploadScreen extends StatefulWidget {
  static const id = "upload";
  String subject;
  String year;
  UploadScreen({this.subject, this.year});
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String dropdownValue = "In-Sem1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Paper"),
        backgroundColor: kMainColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            TextField(
              enabled: false,
              decoration: kTextFieldDecoration.copyWith(
                hintText: widget.subject,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              enabled: false,
              decoration: kTextFieldDecoration.copyWith(
                hintText: widget.year,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  "Semester",
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  width: 20.0,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['In-Sem1', 'In-Sem2', 'End-Sem']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
