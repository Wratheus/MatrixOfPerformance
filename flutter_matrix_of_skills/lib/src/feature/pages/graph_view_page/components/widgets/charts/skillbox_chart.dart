// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class SkillBoxChart extends StatelessWidget {
  Map<String, dynamic> data;
  List<MaterialColor> randomColors = [];
  double maxValue;
  SkillBoxChart({super.key, required this.data, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (data.keys.toList().length > 6) ? (MediaQuery.of(context).size.width * 0.3) : (MediaQuery.of(context).size.width * 0.25),
      width: (data.keys.toList().length > 6) ? (MediaQuery.of(context).size.width * 0.3) : (MediaQuery.of(context).size.width * 0.25),
      child: SfCircularChart(
        legend: Legend(isVisible: true, textStyle: whiteTextColor, position: LegendPosition.bottom),
        series: <CircularSeries>[
          RadialBarSeries(
              useSeriesColor: true,
              trackOpacity: 0.05,
              cornerStyle: CornerStyle.bothCurve,
              dataSource: data.keys.toList().sublist(2),
              dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(color: MyColors.mainBeige, fontSize: 12, fontWeight: FontWeight.bold)),
              xValueMapper: (key, index) => key,
              yValueMapper: (key, index) => data[key],
              maximumValue: maxValue,
              trackColor: MyColors.mainInnerColor.withOpacity(0.1)
          )
        ],
      ),
    );
  }
}
