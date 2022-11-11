// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ColumnChart extends StatelessWidget {
  final Map<String, dynamic> data;
  final double maxValue;
  const ColumnChart({super.key, required this.data, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height: Platform.isWindows ? (data.keys.toList().length > 6) ? (MediaQuery.of(context).size.width * 0.3) : (MediaQuery.of(context).size.width * 0.25) : (MediaQuery.of(context).size.height * 0.25),
          width: Platform.isWindows ?  (data.keys.toList().length > 6) ? (MediaQuery.of(context).size.width * 0.3) : (MediaQuery.of(context).size.width * 0.25) : (MediaQuery.of(context).size.height * 0.25),
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(labelStyle: whiteTextColor),
              primaryYAxis: NumericAxis(minimum: 0, maximum: maxValue, interval: 10, labelStyle: whiteTextColor, isVisible: false),
              series: [
                ColumnSeries(
                  dataSource: data.keys.toList().sublist(2),
                  dataLabelSettings: const DataLabelSettings(isVisible: true, showZeroValue: false, textStyle: TextStyle(color: MyColors.mainBeige, fontWeight: FontWeight.bold, fontSize: 14)),
                  xValueMapper: (key, index) => key,
                  yValueMapper: (key, index) => data[key],
                  pointColorMapper: (key, index) => chartColors.elementAt(index % 10)
                ),
              ]
          ),
        );
  }
}
