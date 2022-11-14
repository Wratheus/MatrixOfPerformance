import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../../../core/services/app_ui_disable_glow_effect.dart';


class GroupRadarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final double angleValue = 0.0;
  final int maxValue;
  final double height;
  const GroupRadarChart({super.key, required this.data, required this.maxValue, required this.height});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height,
              width: height,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: RadarChart(
                  RadarChartData(
                    dataSets: showingDataSets(data: data),
                    radarBackgroundColor: Colors.transparent,
                    radarShape: RadarShape.circle,
                    radarBorderData: const BorderSide(color: Colors.transparent, width: 2),
                    radarTouchData: RadarTouchData(),
                    titlePositionPercentageOffset: 0.1,
                    gridBorderData: BorderSide(color: Colors.grey.withOpacity(0.4), width: 2),
                    tickBorderData: BorderSide(color: Colors.grey.withOpacity(0.09), width: 2),
                    ticksTextStyle: const TextStyle(color: MyColors.mainBeige, fontSize: 14, fontWeight: FontWeight.bold),
                    tickCount: maxValue,
                    titleTextStyle: const TextStyle(color: MyColors.mainBeige, fontSize: 14, fontWeight: FontWeight.bold),
                    getTitle: (index, angle) {
                      return RadarChartTitle(
                        text: data[0].keys.toList().sublist(2)[index],
                        angle: 0,
                      );
                    },
                  ),
                  swapAnimationCurve: Curves.linearToEaseOut,
                ),
              ),
            ),
            Platform.isWindows ? SizedBox(
              height: height * 0.7,
              width: 200,
              child: DisableGlowEffect(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 15,
                              width: 15,
                              child: CircleAvatar(
                                backgroundColor: chartColors[index % 21],
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(data[index]['name'].length >= 10 ? '${(data[index]['name'] as String).substring(0, 10)}.' : data[index]['name'], style: whiteTextColor),
                            Text(" - ${calculateSumOfSkills(personSkillValues: data[index].values.toList().sublist(2)) }", style: whiteTextColor,)
                          ],
                        ),
                      );
                    }
                ),
              ),
            ) :
            Container(),
          ],
        ),
        (Platform.isIOS || Platform.isAndroid) ?
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: MyColors.customBlack.withOpacity(0.35),
                blurRadius: 4,
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: MyColors.mainOuterColor,
          ),
          height: height * 0.59,
          child: RawScrollbar(
            trackColor: MyColors.mainBeige,
            trackVisibility: true,
            timeToFade: const Duration(minutes: 5),
            thickness: 4,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 17,
                          width: 17,
                          child: CircleAvatar(
                            backgroundColor: chartColors[index % 21],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(data[index]['name'].length >= 30 ? '${(data[index]['name'] as String).substring(0, 30)}.' : data[index]['name'], style: const TextStyle(fontSize: 22, color: MyColors.mainBeige)),
                        Text(" - ${calculateSumOfSkills(personSkillValues: data[index].values.toList().sublist(2)) }", style: whiteTextColor,)
                      ],
                    ),
                  );
                }
            ),
          ),
        ) :
        const SizedBox(),
      ],
    );
  }

  List<RadarDataSet> showingDataSets({required List<Map<String, dynamic>> data}) {
    int index = -1;
    return data.map((e) {
      index++;
      return RadarDataSet(
        fillColor: chartColors[index%21].withOpacity(0.025),
        borderColor: chartColors[index%21],
        entryRadius: 2,
        dataEntries: e.values.toList().sublist(2).map<RadarEntry>((value) => RadarEntry(value: (value).toDouble())).toList(),
        borderWidth: 3,
      );
    }).toList();
  }
  String calculateSumOfSkills({required List<dynamic> personSkillValues}){
    num sum = 0;
    String strSum;
    for(int i = 0; i < personSkillValues.length; i++) {sum = sum + personSkillValues[i];}
    strSum = sum.toString();
    return strSum;
  }
}