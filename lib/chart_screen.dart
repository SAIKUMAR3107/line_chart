import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LineChartSample9 extends StatefulWidget {
  LineChartSample9({super.key});

  @override
  State<LineChartSample9> createState() => _LineChartSample9State();
}

class _LineChartSample9State extends State<LineChartSample9> {
  var minYValue = TextEditingController();
  var maxYValue = TextEditingController();
  var minXValue = TextEditingController();
  var maxXValue = TextEditingController();
  bool helperText = false;

  // comment line added and about to change
  final spots = List.generate(101, (i) => (i - 50) / 10)
      .map((x) => FlSpot(x, cos(x)))
      .toList();

  //added a comment line changed
  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    if (value % 1 != 0) {
      return Container();
    }
    final style = TextStyle(
      color: Color(0xFF2196F3),
      fontWeight: FontWeight.bold,
      fontSize: min(18, 18 * chartWidth / 300),
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(meta.formattedValue, style: style),
    );
  }
  //comment line added
  Widget leftTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      color: Color(0xFFFFC300),
      fontWeight: FontWeight.bold,
      fontSize: min(18, 18 * chartWidth / 300),
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(meta.formattedValue, style: style),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Line Chart"),centerTitle: true,),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                  right: 20,
                  top: 10,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return LineChart(
                        LineChartData(
                          lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                              maxContentWidth: 100,
                              tooltipBgColor: Colors.black,
                              getTooltipItems: (touchedSpots) {
                                return touchedSpots.map((LineBarSpot touchedSpot) {
                                  final textStyle = TextStyle(
                                    color: touchedSpot.bar.gradient?.colors[0] ??
                                        touchedSpot.bar.color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  );
                                  return LineTooltipItem(
                                    '${touchedSpot.x}, ${touchedSpot.y.toStringAsFixed(2)}',
                                    textStyle,
                                  );
                                }).toList();
                              },
                            ),
                            handleBuiltInTouches: true,
                            getTouchLineStart: (data, index) => 0,
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              color: Color(0xFFFF3AF2),
                              spots: spots,
                              isCurved: true,
                              isStrokeCapRound: true,
                              barWidth: 6,
                              preventCurveOverShooting: true,
                              belowBarData: BarAreaData(
                                show: false,
                              ),
                              dotData: const FlDotData(show: false),
                            ),
                          ],
                          minY: double.tryParse(minYValue.text),
                          maxY: double.tryParse(maxYValue.text),
                          /*maxX: double.tryParse(maxXValue.text),
                          minX: double.tryParse(minXValue.text),*/
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) =>
                                    leftTitleWidgets(value, meta, constraints.maxWidth),
                                reservedSize: 56,
                              ),
                              drawBelowEverything: true,
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) =>
                                    bottomTitleWidgets(value, meta, constraints.maxWidth),
                                reservedSize: 36,
                                interval: 1,
                              ),
                              drawBelowEverything: true,
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawHorizontalLine: true,
                            drawVerticalLine: true,
                            horizontalInterval: 1.5,
                            verticalInterval: 5,
                            checkToShowHorizontalLine: (value) {
                              return value.toInt() == 0;
                            },
                            getDrawingHorizontalLine: (_) => FlLine(
                              color: Color(0xFF2196F3).withOpacity(1),
                              dashArray: [8, 2],
                              strokeWidth: 0.8,
                            ),
                            getDrawingVerticalLine: (_) => FlLine(
                              color: Color(0xFFFFC300).withOpacity(1),
                              dashArray: [8, 2],
                              strokeWidth: 0.8,
                            ),
                            checkToShowVerticalLine: (value) {
                              return value.toInt() == 0;
                            },
                          ),
                          borderData: FlBorderData(show: false),
                        ),
                      );
                    },
                  ),
                ),
                      ),
                SizedBox(height: 10,),
                Container(alignment: Alignment.topLeft,child: Text("Enter below values to change the Y-Axis values",style: TextStyle(fontSize: 20),)),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width/2.5,
                      child: TextFormField(
                        controller: minYValue,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Color(0xffF67952))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Color(0xffF67952))),
                            hintText: "Enter min Y value",
                            hintStyle: TextStyle(color: Colors.grey),
                            helperText: !helperText ? "" : "Field should not be empty",
                            helperStyle: TextStyle(color: Colors.red),
                            ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/2.5,
                      child: TextFormField(
                        controller: maxYValue,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Color(0xffF67952))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Color(0xffF67952))),
                            hintText: "Enter max Y Value",
                            hintStyle: TextStyle(color: Colors.grey),
                            helperText: !helperText ? "" : "Field should not be empty",
                            helperStyle: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Container(alignment: Alignment.topLeft,child: Text("Enter below values to change the X-Axis values",style: TextStyle(fontSize: 20),)),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width/2.5,
                      child: TextFormField(
                        controller: minXValue,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xffF67952))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xffF67952))),
                          hintText: "Enter min X value",
                          hintStyle: TextStyle(color: Colors.grey),
                          helperText: !helperText ? "" : "Field should not be empty",
                          helperStyle: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/2.5,
                      child: TextFormField(
                        controller: maxXValue,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xffF67952))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xffF67952))),
                          hintText: "Enter max X Value",
                          hintStyle: TextStyle(color: Colors.grey),
                          helperText: !helperText ? "" : "Field should not be empty",
                          helperStyle: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),

              ],
            ),
          ),
        ),
    );
  }
}
