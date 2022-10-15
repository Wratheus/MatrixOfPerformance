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
                  width: ((data[0].keys.length-2) * data.length * 50).toDouble(),
                  child: SampleStyleContainer(
                    child: SfCartesianChart(
                      title: ChartTitle(
                        text: 'Overall performance',
                        textStyle: whiteTextColor,
                        alignment: ChartAlignment.near
                      ),
                      tooltipBehavior: TooltipBehavior(textStyle: whiteTextColor),
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(minimum: 0, maximum: 12, interval: 5),
                      legend: Legend(
                        isVisible: true,
                        textStyle: whiteTextColor,
                        position: LegendPosition.left
                      ),
                      series: data[0].keys.toList().sublist(2).map<ChartSeries<dynamic, dynamic>>((key) => ColumnSeries(
                        dataLabelSettings: const DataLabelSettings(textStyle: TextStyle(color: MyColors.mainBeige), isVisible: true),
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
            ),
            Row(
                children: [
                  Column(
                    children: data.map((e) {
                      return Row(
                        children: [
                          SizedBox(
                            height: 650,
                            width: 650,
                            child: SampleStyleContainer(
                              child: SfCartesianChart(
                                  title: ChartTitle(
                                    text: '${e['name']}\'s pie chart:',
                                    alignment: ChartAlignment.near,
                                    textStyle: whiteTextColor,
                                  ),
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(minimum: 0, maximum: 12, interval: 10),
                                  series: [
                                    ColumnSeries(
                                      dataSource: e.keys.toList().sublist(2),
                                      dataLabelSettings: const DataLabelSettings(textStyle: TextStyle(color: MyColors.mainBeige), isVisible: true),
                                      xValueMapper: (key, index) => key,
                                      yValueMapper: (key, index) => e[key],
                                      pointColorMapper: (data, _) => randomColors[_],
                                    ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 650,
                            width: 650,
                            child: SampleStyleContainer(
                              child: SfCircularChart(
                                title: ChartTitle(
                                  text: '${e['name']}\'s pie chart:',
                                  alignment: ChartAlignment.near,
                                  textStyle: whiteTextColor,
                                ),
                                legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll, textStyle: whiteTextColor),
                                series: [
                                  PieSeries(
                                    dataSource: e.keys.toList().sublist(2),
                                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                                    xValueMapper: (key, index) => key,
                                    yValueMapper: (key, index) => e[key],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 650,
                            width: 650,
                            child: SampleStyleContainer(
                              child: SfCircularChart(
                                title: ChartTitle(
                                  text: '${e['name']}\'s pie chart:',
                                  alignment: ChartAlignment.near,
                                  textStyle: whiteTextColor,
                                ),
                                legend: Legend(isVisible: true, textStyle: whiteTextColor),
                                  series: <CircularSeries>[
                                    RadialBarSeries(
                                      dataSource: e.keys.toList().sublist(2),
                                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                                      xValueMapper: (key, index) => key,
                                      yValueMapper: (key, index) => e[key],
                                      maximumValue: 10,
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
                ]
            ),
          ]
      ),
    );
  }
}
