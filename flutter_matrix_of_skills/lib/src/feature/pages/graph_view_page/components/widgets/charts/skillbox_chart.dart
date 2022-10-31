// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class SkillBoxChart extends StatelessWidget {
  List<dynamic> data;
  List<MaterialColor> randomColors = [];
  SkillBoxChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.0, top: 2.0),
      child: Column(
        children: data.map((e) {
          return Row(
            children: [
              SizedBox(
                height: (data[0].keys.toList().length > 5) ? (MediaQuery.of(context).size.width * 0.395) : (MediaQuery.of(context).size.width * 0.195),
                width: (data[0].keys.toList().length > 5) ? (MediaQuery.of(context).size.width * 0.395) : (MediaQuery.of(context).size.width * 0.195),
                child: SampleStyleContainer(
                  child: SfCircularChart(
                    title: ChartTitle(
                      text: '${e['name']}\'s skill box chart:',
                      alignment: ChartAlignment.near,
                      textStyle: whiteTextColor,
                    ),
                    legend: Legend(isVisible: true, textStyle: whiteTextColor),
                      series: <CircularSeries>[
                        RadialBarSeries(
                          useSeriesColor: true,
                          trackOpacity: 0.05,
                          cornerStyle: CornerStyle.bothCurve,
                          dataSource: e.keys.toList().sublist(2),
                          dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(color: MyColors.mainBeige, fontSize: 14, fontWeight: FontWeight.bold)),
                          xValueMapper: (key, index) => key,
                          yValueMapper: (key, index) => e[key],
                          maximumValue: maxValue(data),
                          trackColor: MyColors.mainInnerColor.withOpacity(0.1)
                        )
                      ],
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
