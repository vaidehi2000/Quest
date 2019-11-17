import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:quest_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final _firestore = Firestore.instance;
  String sem;
//  var docPaths;
  void getPdfAndUpload() async {
    try {
      var rng = new Random();
      String randomName="";
      for (var i = 0; i < 20; i++) {
        print(rng.nextInt(100));
        randomName += rng.nextInt(100).toString();
      }
      File file = await FilePicker.getFile(type: FileType.CUSTOM, fileExtension: 'pdf');
      String fileName = '${randomName}.pdf';
      print(fileName);
      print('${file.readAsBytesSync()}');
      
      //savePdf(file.readAsBytesSync(), fileName);
    } catch (e) {
      print(e);
    }
    // savePdf(file.readAsBytesSync(), fileName);
  }

  Future savePdf(List<int> asset, String name) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(name);
    StorageUploadTask uploadTask = reference.putData(asset);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    print(url);
    //documentFileUpload(url);
    return url;
  }

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
                    setState(
                      () {
                        dropdownValue = newValue;
                        if (dropdownValue.compareTo('In-Sem1') == 0) {
                          sem = "1";
                        } else if (dropdownValue.compareTo('In-Sem2') == 0) {
                          sem = "2";
                        } else if (dropdownValue.compareTo('End-Sem') == 0) {
                          sem = "3";
                        }
                      },
                    );
                  },
                  items: <String>['In-Sem1', 'In-Sem2', 'End-Sem']
                      .map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
              onPressed: getPdfAndUpload,
              child: Icon(
                Icons.cloud_upload,
                size: 200.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
