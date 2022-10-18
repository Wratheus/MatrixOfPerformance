// ignore_for_file: must_be_immutable
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class GroupColumnChart extends StatelessWidget {
  List<dynamic> data;
  List<MaterialColor> randomColors = [];
  GroupColumnChart({super.key, required this.data}) {
    for(int i = 0; i < data[0].keys.toList().length - 2; i++){
      randomColors.add(Colors.primaries[Random().nextInt(Colors.primaries.length)]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      scrollDirection: Axis.horizontal,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: ((data[0].keys.length-2) * data.length * 35).toDouble(),
                  child: SampleStyleContainer(
                    child: SfCartesianChart(
                        title: ChartTitle(
                            text: 'Overall performance',
                            textStyle: whiteTextColor,
                            alignment: ChartAlignment.near
                        ),
                        tooltipBehavior: TooltipBehavior(textStyle: whiteTextColor),
                        primaryXAxis: CategoryAxis(labelStyle: whiteTextColor, isVisible: false),
                        enableSideBySideSeriesPlacement: true,
                        primaryYAxis: NumericAxis(minimum: 0, maximum: 12, interval: 5, labelStyle: whiteTextColor, isVisible: false),
                        legend: Legend(
                            isVisible: true,
                            textStyle: whiteTextColor,
                            position: LegendPosition.left
                        ),
                        series: data[0].keys.toList().sublist(2).map<ChartSeries<dynamic, dynamic>>((key) => ColumnSeries(
                          opacity: 0.9,
                          width: 0.7,
                          dataLabelSettings: const DataLabelSettings(textStyle: TextStyle(color: MyColors.mainBeige, fontSize: 20), isVisible: true, showZeroValue: false),
                          dataSource: data,
                          legendItemText: key,

                          xValueMapper: (data, index) => data['name'],
                          yValueMapper: (data, index) => data[key],
                          enableTooltip: true,
                        )).toList()
                    ),
                  ),
                ),
              ],
            ),]
      ),
    );
  }
}
