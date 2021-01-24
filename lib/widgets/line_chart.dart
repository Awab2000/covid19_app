import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class LineChartReport extends StatelessWidget {

  final Map historyData;
  final String title;

  const LineChartReport({Key key, this.historyData, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: LineChart
        (
        LineChartData
          (
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          lineBarsData:
          [
            LineChartBarData
              (
              spots: getSpots(),
              isCurved: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              colors: [Color(0xFF0d8E53)],
              barWidth: 4
            ),
          ],
        ),
      ),
    );
  }
  List<FlSpot> getSpots()
  {
    if(this.historyData == null) {
      return
        [
          FlSpot(0, .5),
          FlSpot(1, 1.5),
          FlSpot(2, .5),
          FlSpot(3, .7),
          FlSpot(4, .2),
          FlSpot(5, 2),
          FlSpot(6, 1.5),
          FlSpot(7, 1.7),
          FlSpot(8, 1),
          FlSpot(9, 2.8),
          FlSpot(10, 2.5),
          FlSpot(11, 2.65)

        ];
    } else
      {
        List<FlSpot> list = List<FlSpot>();
        var map = Map<String, dynamic>.from(historyData[getName()]);
        int i = 0;
        for(var item in map.values)
          {
            int dItem = item;
            list.add(FlSpot(i.toDouble(), dItem.toDouble()));
            i++;
          }
        return list;
      }
  }

  String getName()
  {
    switch(this.title)
    {
      case "CONFIRMED":
        return "cases";
        break;
      case "RECOVERED":
        return "recovered";
        break;
      case "DEATHS":
        return "deaths";
        break;
      default:
        return "";
    }
  }

}


