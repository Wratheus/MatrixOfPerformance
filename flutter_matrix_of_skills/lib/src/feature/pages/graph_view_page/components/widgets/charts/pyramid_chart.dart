// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class PyramidChart extends StatelessWidget {
  final Map<String, dynamic> data;
  const PyramidChart({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (data.keys.toList().length > 6) ? (MediaQuery.of(context).size.width * 0.3) : (MediaQuery.of(context).size.width * 0.25),
      width: (data.keys.toList().length > 6) ? (MediaQuery.of(context).size.width * 0.3) : (MediaQuery.of(context).size.width * 0.25),
      child: SfPyramidChart(
          legend: Legend(isVisible: true, textStyle: whiteTextColor, position: LegendPosition.left),
          series:PyramidSeries(
              dataSource: data.keys.toList().sublist(2),
              xValueMapper: (key, index) => key,
              yValueMapper: (key, index) => data[key],
              dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(color: MyColors.mainBeige, fontSize: 14, fontWeight: FontWeight.bold), showZeroValue: false),
              gapRatio: 0.1
          )
      ),
    );
  }
}
