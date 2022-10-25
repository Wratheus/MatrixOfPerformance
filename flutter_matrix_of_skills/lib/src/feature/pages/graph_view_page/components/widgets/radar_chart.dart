
import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../../core/constants/constants.dart';
// TODO: add Legend column
// ignore: must_be_immutable
class SampleRadarChart extends StatelessWidget {
  final List<dynamic> data;
  final double angleValue = 0.0;

  const SampleRadarChart({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 650,
      height: 650,
      child: SampleStyleContainer(
          child: RadarChart(
            RadarChartData(
              dataSets: showingDataSets(data),
              radarBackgroundColor: Colors.transparent,
              radarShape: RadarShape.circle,
              radarBorderData: const BorderSide(color: Colors.transparent, width: 2),
              radarTouchData: RadarTouchData(),
              titlePositionPercentageOffset: 0.1,
              gridBorderData: const BorderSide(color: Colors.grey, width: 2),
              tickBorderData: const BorderSide(color: Colors.transparent, width: 2),
              ticksTextStyle: whiteTextColor,
              tickCount: null,
              titleTextStyle:
              const TextStyle(color: MyColors.mainBeige, fontSize: 14, fontWeight: FontWeight.bold),
              getTitle: (index, angle) {
                return RadarChartTitle(
                  text: data[0].keys.toList().sublist(2)[index],
                  angle: 0,
                );
              },
            ),
            swapAnimationCurve: Curves.linear,
          )
      ),
    );
  }

  List<RadarDataSet> showingDataSets(List<dynamic> data) {

    int index = -1;
    return data.map((e) {
      index++;
      return RadarDataSet(
        fillColor: chartColors[index%10].withOpacity(0.025),
        borderColor: chartColors[index%10],
        entryRadius: 2,
        dataEntries: e.values.toList().sublist(2).map<RadarEntry>((value) => RadarEntry(value: value.toDouble())).toList(),
        borderWidth: 3,
      );
    }).toList();
  }
}