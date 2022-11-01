import 'package:flutter/material.dart';
import 'package:flutter_matrix_of_skills/src/core/constants/constants.dart';
import 'package:flutter_matrix_of_skills/src/feature/components/sample_style_container.dart';
import 'package:fl_chart/fl_chart.dart';


class GroupRadarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final double angleValue = 0.0;

  const GroupRadarChart({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: SampleStyleContainer(
          child: Row(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                width:  MediaQuery.of(context).size.height * 0.45,
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
                    tickCount: 10,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: longestName(data) * 17 + 10,
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
                            Text(data[index]['name'], style: whiteTextColor),
                            Text(" - ${calculateSumOfSkills(personSkillValues: data[index].values.toList().sublist(2)) }", style: whiteTextColor,)
                          ],
                        ),
                      );
                    }
                ),
              ),
            ],
          )
      ),
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
        dataEntries: e.values.toList().sublist(2).map<RadarEntry>((value) => RadarEntry(value: value.toDouble())).toList(),
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