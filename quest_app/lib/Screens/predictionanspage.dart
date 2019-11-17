import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_app/constants.dart';
import 'package:pie_chart/pie_chart.dart';

class FinalAnswer extends StatelessWidget {
  static const id = 'Resultpredict';
  @override
  Map<String, double> result;
  FinalAnswer({this.result});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        backgroundColor: kMainColor,
      ),
      body: PieChart(
        dataMap: result,
        animationDuration: Duration(milliseconds: 2000),
      ),
    );
  }
}
