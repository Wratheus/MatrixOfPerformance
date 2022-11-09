// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class GroupColumnChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const GroupColumnChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SampleStyleContainer(
          height: MediaQuery.of(context).size.height * 0.35,
          width:  data[0].keys.toList().length >= 12 ? data.length * 500 : data[0].keys.toList().length >= 9 ? data.length * 250 : data[0].keys.toList().length >= 6 ? data.length * 200 : MediaQuery.of(context).size.width,
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
                width: 0.75,
                dataLabelSettings: const DataLabelSettings(textStyle: TextStyle(color: MyColors.mainBeige, fontSize: 14, fontWeight: FontWeight.bold), isVisible: true, showZeroValue: false),
                dataSource: data,
                legendItemText: key,
                xValueMapper: (data, index) => data['name'],
                yValueMapper: (data, index) => data[key],
                enableTooltip: true,
              )).toList()
          ),
        ),
      ],
    );
  }
}
