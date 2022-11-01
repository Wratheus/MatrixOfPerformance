// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class PyramidChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const PyramidChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.0, top: 2.0),
      child: Column(
        children: data.map((e) {
          return Row(
            children: [
              SizedBox(
                height: (data[0].keys.toList().length > 6) ? (MediaQuery.of(context).size.width * 0.395) : (MediaQuery.of(context).size.width * 0.195),
                width: (data[0].keys.toList().length > 6) ? (MediaQuery.of(context).size.width * 0.395) : (MediaQuery.of(context).size.width * 0.195),
                child: SampleStyleContainer(
                  child: SfPyramidChart(
                      title: ChartTitle(
                        text: '${e['name']}\'s pyramid chart:',
                        alignment: ChartAlignment.near,
                        textStyle: whiteTextColor,
                      ),
                      legend: Legend(isVisible: true, textStyle: whiteTextColor),
                      series:PyramidSeries(
                          dataSource: e.keys.toList().sublist(2),
                          xValueMapper: (key, index) => key,
                          yValueMapper: (key, index) => e[key],
                          dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(color: MyColors.mainBeige, fontSize: 14, fontWeight: FontWeight.bold), showZeroValue: false),
                          gapRatio: 0.1
                      )
                  ),
                ),
              )
            ],
          );
        }
      ).toList()),
    );
  }
}
