import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quest/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'predictionanspage.dart';

class PredictionPage extends StatefulWidget {
  static const id = 'predict';
  String subject;
  PredictionPage({this.subject});
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  List<String> inputs = List();
  Map<String, bool> bundle = Map();
  List<String> topic = List();
  String subject;
  String presubject;
  final _firestore = Firestore.instance;
  bool isbutton = true;
  @override
  void initState() {
    super.initState();
    if (widget.subject.compareTo('Database Management') == 0) {
      subject = 'dbms';
      presubject = 'dbms_predict';
    } else if (widget.subject.compareTo('Linear Algebra') == 0) {
      subject = 'la';
      presubject = 'la_predict';
    } else if (widget.subject.compareTo('Discrete Mathematics') == 0) {
      subject = 'dm';
      presubject = 'dm_predict';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predict Paper'),
        backgroundColor: kMainColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: isbutton
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 250.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          (18.0),
                        ),
                        side: BorderSide(color: Colors.black)),
                    child: Text(
                      'Start Prediction',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    onPressed: () async {
                      final data =
                          await _firestore.collection(subject).getDocuments();
                      final predict = await _firestore
                          .collection(presubject)
                          .getDocuments();
                      for (var pre in predict.documents) {
                        inputs.add(pre.data['topic']);
                      }
                      for (var d in data.documents) {
                        bundle[d.data['topic']] = false;
                        topic.add(d.data['topic']);
                      }
                      //print(bundle);
                      setState(() {
                        isbutton = false;
                      });
                    },
                  ),
                ),
              )
            : Column(
                children: <Widget>[
                  Text('Select Topis'),
                  Column(
                    children: topic
                        .map((t) => CheckboxListTile(
                              title: Text(t),
                              value: bundle[t],
                              onChanged: (val) {
                                setState(() {
                                  bundle[t] = val;
                                  //print(bundle);
                                });
                              },
                            ))
                        .toList(),
                  ),
                  RaisedButton(
                    onPressed: () {
                      print(inputs);
                      Random rand = Random();
                      List<String> tp = List();
                      Map<String, double> result = Map();
                      for (var d in bundle.keys) {
                        if (bundle[d]) {
                          tp.add(d);
                        }
                      }
                      int x;
                      if (tp.length == 0) {
                        for (int i = 0; i < inputs.length; i++) {
                          result[inputs[rand.nextInt(inputs.length)]] =
                              rand.nextDouble() * 10;
                          if (i == 5) break;
                        }
                      } else {
                        int c;
                        for (int i = 0; i < tp.length; i++) {
                          c = 0;
                          for (int j = 0; j < inputs.length; j++) {
                            if (inputs[j].compareTo(tp[i]) == 0) {
                              result[inputs[j]] = rand.nextDouble() * 5 + 10.0;
                              c = 1;
                              break;
                            }
                          }
                          if (c == 0) {
                            result[tp[i]] = rand.nextDouble() * 5;
                          }
                        }
                      }
                      print(result);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinalAnswer(
                            result: result,
                          ),
                        ),
                      );
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
      ),
    );
  }
}
