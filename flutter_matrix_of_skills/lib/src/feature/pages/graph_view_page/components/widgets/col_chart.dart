// ignore_for_file: must_be_immutable
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ColumnChart extends StatelessWidget {
  List<dynamic> data;
  List<MaterialColor> randomColors = [];
  ColumnChart({super.key, required this.data}) {
    for(int i = 0; i < data[0].keys.toList().length - 2; i++){
      randomColors.add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.map((e) {
        return Row(
          children: [
            SizedBox(
              height: 650,
              width: 650,
              child: SampleStyleContainer(
                child: SfCartesianChart(
                    title: ChartTitle(
                      text: '${e['name']}\'s column chart:',
                      alignment: ChartAlignment.near,
                      textStyle: whiteTextColor,
                    ),
                    primaryXAxis: CategoryAxis(labelStyle: whiteTextColor),
                    primaryYAxis: NumericAxis(minimum: 0, maximum: 12, interval: 10, labelStyle: whiteTextColor, isVisible: false),
                    series: [
                      ColumnSeries(
                        dataSource: e.keys.toList().sublist(2),
                        dataLabelSettings: const DataLabelSettings(textStyle: TextStyle(color: MyColors.mainBeige, fontSize: 20), isVisible: true, showZeroValue: false),
                        xValueMapper: (key, index) => key,
                        yValueMapper: (key, index) => e[key],
                        pointColorMapper: (data, _) => randomColors[_],
                      ),
                    ]),
              ),
            ),
          ],
        );
      }
    ).toList());
  }
}
