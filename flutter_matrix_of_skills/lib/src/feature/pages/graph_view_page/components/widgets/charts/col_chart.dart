// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ColumnChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const ColumnChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 2.0),
      child: Column(
        children: data.map((e) {
          return Row(
            children: [
              SizedBox(
                height: (data[0].keys.toList().length > 6) ? (MediaQuery.of(context).size.width * 0.395) : (MediaQuery.of(context).size.width * 0.195),
                width: (data[0].keys.toList().length > 6) ? (MediaQuery.of(context).size.width * 0.395) : (MediaQuery.of(context).size.width * 0.195),
                child: SampleStyleContainer(
                  child: SfCartesianChart(
                      title: ChartTitle(
                        text: '${e['name']}\'s column chart:',
                        alignment: ChartAlignment.near,
                        textStyle: whiteTextColor,
                      ),
                      primaryXAxis: CategoryAxis(labelStyle: whiteTextColor),
                      primaryYAxis: NumericAxis(minimum: 0, maximum: maxValue(data), interval: 10, labelStyle: whiteTextColor, isVisible: false),
                      series: [
                        ColumnSeries(
                          dataSource: e.keys.toList().sublist(2),
                          dataLabelSettings: const DataLabelSettings(isVisible: true, showZeroValue: false, textStyle: TextStyle(color: MyColors.mainBeige, fontWeight: FontWeight.bold, fontSize: 14)),
                          xValueMapper: (key, index) => key,
                          yValueMapper: (key, index) => e[key],
                          pointColorMapper: (key, index) => chartColors.elementAt(index % 10)
                        ),
                      ]),
                ),
              ),
            ],
          );
        }
      ).toList()),
    );
  }
}
