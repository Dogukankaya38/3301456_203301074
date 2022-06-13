import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DrawPieChart extends StatefulWidget {

  double confvalue;
  double recvalue;
  double deaths;

  DrawPieChart(this.confvalue, this.recvalue, this.deaths);

  @override
  _DrawPieChartState createState() => _DrawPieChartState();
}

class _DrawPieChartState extends State<DrawPieChart> {


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
          color: const Color(0xff1b232f), borderRadius: BorderRadius.circular(10.0)),
      height: height * 0.45,
      child: PieChart(PieChartData(
          centerSpaceRadius: 25,
          borderData: FlBorderData(show: false),
          sections: [
            PieChartSectionData(
                value: (100*widget.confvalue/(widget.confvalue + widget.recvalue + widget.deaths)).roundToDouble(),
                color: Colors.blue,
                radius: 100),
            PieChartSectionData(
                value:(100*widget.recvalue/(widget.confvalue + widget.recvalue + widget.deaths)).roundToDouble(),
                color: Colors.green,
                radius: 110),
            PieChartSectionData(
                value:(100*widget.deaths/(widget.confvalue + widget.recvalue + widget.deaths)).roundToDouble(),
                color: Colors.red,
                radius: 120)
          ])),
    );
  }
}
