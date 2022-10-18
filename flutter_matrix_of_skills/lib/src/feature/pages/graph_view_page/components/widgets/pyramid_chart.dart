// ignore_for_file: must_be_immutable
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class PyramidChart extends StatelessWidget {
  List<dynamic> data;
  List<MaterialColor> randomColors = [];
  PyramidChart({super.key, required this.data}) {
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
                        dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(color: MyColors.mainBeige, fontSize: 16), showZeroValue: false),
                        gapRatio: 0.1
                    )
                ),
              ),
            )
          ],
        );
      }
    ).toList());
  }
}
