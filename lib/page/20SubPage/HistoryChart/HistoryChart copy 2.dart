/* import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'Data/ManageChartData.dart';

void showHistory(String _itemID, String _itemName, String _section,
    String _max, String _min, BuildContext context) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          //title: Text('HISTORY DATA'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 500,
                child: HistoryChart(
                  itemID: _itemID,
                  itemName: _itemName,
                  section: _section,
                  max: _max,
                  min: _min,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            )
          ],
        );
      });
}

// ignore: must_be_immutable
class HistoryChart extends StatefulWidget {
  String itemID = "";
  String itemName = "";
  String section = "";
  String max = "";
  String min = "";
  HistoryChart({
    required this.itemID,
    required this.itemName,
    required this.section,
    required this.max,
    required this.min,
  });

  @override
  State<StatefulWidget> createState() => HistoryChartState();
}

class HistoryChartState extends State<HistoryChart> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: searchHistoryChartData(widget.itemID, widget.itemName,
            widget.section, widget.max, widget.min),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != 0) {
              return AspectRatio(
                aspectRatio: 1.5,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    color: Color(0xFFE0F7FA),
                    /* gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(0, 56, 243, 247),
                      Color(0x03F6FB),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ), */
                  ),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'HISTORY DATA',
                            style: TextStyle(
                              //color: Color(0xff827daa),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'CUSTOMER : ${historyChartData[0].custFull}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'SAMPLE NAME : ${historyChartData[0].sampleName}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'ITEM : ${widget.itemName}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'POSITION : ${historyChartData[0].position}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'CONTROL RANGE',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' MIN : ${historyChartData[0].stdMin}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                ' MAX : ${historyChartData[0].stdMax}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 30.0, left: 6.0),
                              child: _LineChart(
                                  isShowingMainData: isShowingMainData),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.white
                              .withOpacity(isShowingMainData ? 1.0 : 0.5),
                        ),
                        onPressed: () {
                          setState(() {
                            isShowingMainData = !isShowingMainData;
                          });
                        },
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Text("NO HISTORY DATA");
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class _LineChart extends StatelessWidget {
  _LineChart({required this.isShowingMainData});
  final bool isShowingMainData;
  double maxX = 0;
  double minX = 0;
  double maxY = 0;
  double minY = 0;
  bool showBottomTile = true;

  final List<Color> gradientColors = [
    const Color(0xFFEF9A9A),
    const Color(0xFFFFEBEE),
  ];

  @override
  Widget build(BuildContext context) {
    manageData();
    return LineChart(
      chartData,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  void manageData() {
    print("In manage");
    minX = 0;
    if (historyChartData.length == 1 &&
        double.parse(historyChartData[0].resultApprove) > 0) {
      maxX = 2;
      showBottomTile = false;
    } else if (historyChartData.length == 1) {
      maxX = 1;
      showBottomTile = false;
    } else {
      maxX = historyChartData.length.toDouble() - 1;
    }
    double maxResult = 0;
    double minResult = 9999999;
    for (int i = 0; i < historyChartData.length; i++) {
      if (double.parse(historyChartData[i].resultApprove) < minResult) {
        minResult = double.parse(historyChartData[i].resultApprove);
      }
      if (double.parse(historyChartData[i].resultApprove) > maxResult) {
        maxResult = double.parse(historyChartData[i].resultApprove);
      }
    }
    if (double.parse(historyChartData[0].stdMin) > 0) {
      minY = (double.parse(historyChartData[0].stdMin) * 0.7);
    } else {
      minY = minResult * 0.7;
    }
    if (double.parse(historyChartData[0].stdMax) > 0) {
      maxY = (double.parse(historyChartData[0].stdMax) * 1.3);
    } else {
      maxY = maxResult * 1.3;
    }
    /* print("Minx:$minX");
    print("Maxx:$maxX");
    print("Miny:$minY");
    print("MaxY:$maxY");
    for (int i = 0; i < historyChartData.length; i++) {
      print((int.tryParse(historyChartData[i].resultApprove))!
          .toDouble()
          .toString());
    } */
  }

  LineChartData get chartData => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1(),
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                if (historyChartData.length == 1) {
                  return LineTooltipItem(
                    'RESULT : ${flSpot.y}',
                    TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return LineTooltipItem(
                    'RESULT : ${flSpot.y} ${historyChartData[flSpot.x.toInt()].resultApproveUnit} \nDate : ${historyChartData[flSpot.x.toInt()].samplingDate}',
                    TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              }).toList();
            }),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        leftTitles: leftTitles,
        bottomTitles: bottomTitles,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        /* leftTitles: SideTitles(
        showTitles: true,
        margin: 8,
        interval: 0.2,
        reservedSize: 100,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xFFD50000),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ) */
      );

  /* List<LineChartBarData> get lineBarsData1 => [
        upperLine,
        lowwerLine,
        lineData,
      ]; */
  List<LineChartBarData> lineBarsData1() {
    List<LineChartBarData> buff = [];
    if (double.parse(historyChartData[0].resultApprove) > 0) {
      buff.add(lineData);
    }
    if (double.parse(historyChartData[0].stdMin) > 0) {
      buff.add(lowwerLine);
    }
    if (double.parse(historyChartData[0].stdMax) > 0) {
      buff.add(upperLine);
    }
    return buff;
  }

  SideTitles get leftTitles => SideTitles(
        showTitles: true,
        margin: 5,
        //interval: (maxY - minY) / 10,
        reservedSize: 35,
        getTextStyles: (context, value) => const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        /* getTitles: (value) {
        switch (value.toInt()) {
          case 1:
            return '1m';
          case 2:
            return '2m';
          case 3:
            return '3m';
          case 4:
            return '5m';
          case 5:
            return '1m';
          case 6:
            return '2m';
          case 7:
            return '3m';
          case 8:
            return '5m';
          case 9:
            return '3m';
          case 10:
            return '5m';
        }
        return '';
      } */
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: showBottomTile,
        reservedSize: 50,
        margin: 10,
        interval: 1,
        getTextStyles: (context, value) => const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        getTitles: (value) {
          return historyChartData[value.toInt()].samplingDate;
        },
        rotateAngle: -45,
      );

  FlGridData get gridData => FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 2),
          left: BorderSide(color: Colors.black, width: 2),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get upperLine => LineChartBarData(
        isCurved: true,
        colors: [const Color(0xFFFF6F00)],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        aboveBarData: BarAreaData(
          show: true,
          colors:
              gradientColors.map((color) => color.withOpacity(0.3)).toList(),
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
        spots: upperLineData(),
      );

  List<FlSpot> upperLineData() {
    List<FlSpot> buff = [];
    if (historyChartData.length == 1 &&
        double.parse(historyChartData[0].resultApprove) > 0) {
      buff.add(FlSpot(0, double.parse(historyChartData[0].stdMax).toDouble()));
      buff.add(FlSpot(2, double.parse(historyChartData[0].stdMax).toDouble()));
    } else if (historyChartData.length == 1) {
      buff.add(FlSpot(0, double.parse(historyChartData[0].stdMax).toDouble()));
      buff.add(FlSpot(1, double.parse(historyChartData[0].stdMax).toDouble()));
    } else {
      buff.add(FlSpot(0, double.parse(historyChartData[0].stdMax).toDouble()));
      buff.add(FlSpot(historyChartData.length.toDouble() - 1,
          double.parse(historyChartData[0].stdMax).toDouble()));
    }
    return buff;
  }

  LineChartBarData get lowwerLine => LineChartBarData(
        isCurved: true,
        colors: [const Color(0xFFFF6F00)],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        aboveBarData: BarAreaData(show: false),
        belowBarData: BarAreaData(
          show: true,
          colors:
              gradientColors.map((color) => color.withOpacity(0.3)).toList(),
        ),
        spots: lowwerLineData(),
      );

  List<FlSpot> lowwerLineData() {
    List<FlSpot> buff = [];
    if (historyChartData.length == 1 &&
        double.parse(historyChartData[0].resultApprove) > 0) {
      buff.add(FlSpot(0, double.parse(historyChartData[0].stdMin).toDouble()));
      buff.add(FlSpot(2, double.parse(historyChartData[0].stdMin).toDouble()));
    } else if (historyChartData.length == 1) {
      buff.add(FlSpot(0, double.parse(historyChartData[0].stdMin).toDouble()));
      buff.add(FlSpot(1, double.parse(historyChartData[0].stdMin).toDouble()));
    } else {
      buff.add(FlSpot(0, double.parse(historyChartData[0].stdMin).toDouble()));
      buff.add(FlSpot(historyChartData.length.toDouble() - 1,
          double.parse(historyChartData[0].stdMin).toDouble()));
    }
    return buff;
  }

  LineChartBarData get lineData => LineChartBarData(
        isCurved: true,
        colors: const [Color(0xff27b6fc)],
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        /* spots: [for (final node in HistoryChartData) FlSpot(node.timestamp.toDouble(), node.rawValue)
        ], */
        spots: ((() {
          if (historyChartData.length == 1 &&
              double.parse(historyChartData[0].resultApprove) > 0) {
            //for (int i = 0; i < historyChartData.length; i++)
            print("addddddd");
            return [
              FlSpot(1, (double.parse(historyChartData[0].resultApprove)))
            ];
          } else {
            List<FlSpot> buff = [];
            for (int i = 0; i < historyChartData.length; i++) {
              buff.add(FlSpot(i.toDouble(),
                  (double.parse(historyChartData[i].resultApprove))));
            }
            return buff;
          }
        }())),
      );
}

 */