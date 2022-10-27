// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class GroupColumnChart extends StatelessWidget {
  final List<dynamic> data;
  const GroupColumnChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SampleStyleContainer(
              height: MediaQuery.of(context).size.height * 0.45,
              width:  data[0].keys.toList().length >= 6 ? data.length * 300 : data.length * 100,
              child: SfCartesianChart(
                  tooltipBehavior: TooltipBehavior(textStyle: whiteTextColor),
                  primaryXAxis: CategoryAxis(labelStyle: whiteTextColor),
                  enableSideBySideSeriesPlacement: true,
                  primaryYAxis: NumericAxis(minimum: 0, maximum: maxValue(data), interval: 3, labelStyle: whiteTextColor, isVisible: false),
                  legend: Legend(
                      isVisible: true,
                      textStyle: whiteTextColor,
                      position: LegendPosition.left
                  ),
                  series: data[0].keys.toList().sublist(2).map<ChartSeries<dynamic, dynamic>>((key) => ColumnSeries(
                    opacity: 0.9,
                    width: 0.7,
                    dataLabelSettings: const DataLabelSettings(textStyle: TextStyle(color: MyColors.mainBeige, fontSize: 16, fontWeight: FontWeight.bold), isVisible: true, showZeroValue: false),
                    dataSource: data,
                    legendItemText: key,
                    xValueMapper: (data, index) => data['name'],
                    yValueMapper: (data, index) => data[key],
                    enableTooltip: true,
                  )).toList()
              ),
            ),
          ],
        ),
      ],
    );
  }
}
