// ignore_for_file: must_be_immutable
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class CircularChart extends StatelessWidget {
  List<dynamic> data;
  List<MaterialColor> randomColors = [];
  CircularChart({super.key, required this.data}) {
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
                        dataLabelSettings: const DataLabelSettings(isVisible: true, showZeroValue: false, textStyle: TextStyle(color: MyColors.mainBeige, fontSize: 16)),
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
        ).toList());
  }
}
