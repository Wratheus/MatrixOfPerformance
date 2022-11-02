// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class CircularChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const CircularChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.0, top: 2.0),
      child: Column(
          children: data.map((e) {
            return Row(
              children: [
                SizedBox(
                  height: (data[0].keys.toList().length > 6) ? (MediaQuery.of(context).size.width * 0.5) : (MediaQuery.of(context).size.width * 0.195),
                  width: (data[0].keys.toList().length > 6) ? (MediaQuery.of(context).size.width * 0.5) : (MediaQuery.of(context).size.width * 0.195),
                  child: SampleStyleContainer(
                    child: SfCircularChart(
                      title: ChartTitle(
                        text: '${e['name']}\'s circular chart:',
                        alignment: ChartAlignment.near,
                        textStyle: whiteTextColor,
                      ),
                      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll, textStyle: whiteTextColor),
                      series: [
                        PieSeries(
                          explode: true,
                          explodeAll: true,
                          dataSource: e.keys.toList().sublist(2),
                          dataLabelSettings: const DataLabelSettings(isVisible: true, showZeroValue: false, textStyle: TextStyle(color: MyColors.mainBeige, fontWeight: FontWeight.bold, fontSize: 14)),
                          xValueMapper: (key, index) => key,
                          yValueMapper: (key, index) => e[key],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          ).toList()),
    );
  }
}
