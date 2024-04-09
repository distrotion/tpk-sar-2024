import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Material;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_officechart/officechart.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/2KPIItemCount/KPIItemCount.dart';
import 'Data/ManageChartData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;
//-----//
import 'package:path_provider/path_provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:image/image.dart' as img;

GlobalKey _chartKey = GlobalKey();

void showHistory(String _itemID, String _itemName, String _section, String _max,
    String _min, BuildContext context) {
  print("object");
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
                height: 700,
                width: 600,
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
              return Container(
                width: 600,
                height: 500,
                child: AspectRatio(
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
/*                             Text(
                              'HISTORY DATA',
                              style: TextStyle(
                                //color: Color(0xff827daa),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                              textAlign: TextAlign.center,
                            ), */
                            Text(
                              '${historyChartData[0].custFull}',
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
                                padding: const EdgeInsets.only(
                                    right: 30.0, left: 6.0),
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
      // swapAnimationDuration: const Duration(milliseconds: 250),
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
    print(minResult);
    print(maxResult);
    if (double.parse(historyChartData[0].stdMin) > 0 &&
        double.parse(historyChartData[0].stdMin) < minResult) {
      minY = (double.parse(historyChartData[0].stdMin) * 0.7);
    } else {
      minY = minResult * 0.7;
    }
    if (double.parse(historyChartData[0].stdMax) > 0 &&
        double.parse(historyChartData[0].stdMax) > maxResult) {
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
                    '${flSpot.y} ${historyChartData[flSpot.x.toInt()].resultApproveUnit}\nDate\n${historyChartData[flSpot.x.toInt()].samplingDate}',
                    TextStyle(
                      fontSize: 15,
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
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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

  AxisTitles get leftTitles => AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          //margin: 5,
          //interval: (maxY - minY) / 10,
          reservedSize: 35,
        ),
        /*  style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ), */

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

  AxisTitles get bottomTitles => AxisTitles(
        sideTitles: SideTitles(
          showTitles: showBottomTile,
          reservedSize: 80,
          //margin: 10,
          interval: 1,
          getTitlesWidget: (value, titleMeta) {
            return Padding(
              // You can use any widget here
              padding: EdgeInsets.only(
                top: 20,
                left: 50,
              ),
              child: Transform.rotate(
                angle: -45,
                child: Text(
                  historyChartData[value.toInt()].samplingDate,
/*                   style: TextStyle(color: Colors.red), */
                  style: TextStyle(fontSize: 14),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),

        /* getTextStyles: (context, value) => const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ), */
        /* getTitles: (value) {
          return historyChartData[value.toInt()].samplingDate;
        },
        rotateAngle: -45, */
      );

  FlGridData get gridData => FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Material.Border(
          bottom: BorderSide(color: Colors.black, width: 2),
          left: BorderSide(color: Colors.black, width: 2),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get upperLine => LineChartBarData(
        isCurved: true,
        /*  color: [const Color(0xFFFF6F00)], */
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        aboveBarData: BarAreaData(
          show: true,
          /* color:
              gradientColors.map((color) => color.withOpacity(0.3)).toList(), */
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
        /* colors: [const Color(0xFFFF6F00)], */
        color: Colors.amber,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        aboveBarData: BarAreaData(show: false),
        belowBarData: BarAreaData(
          show: true,
          /* colors:
              gradientColors.map((color) => color.withOpacity(0.3)).toList(), */
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
        /* colors: const [Color(0xff27b6fc)], */
        color: Colors.blue,
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

void downloadDataToCSV(
    String _itemID, String _itemName, String _max, String _min) {
  // Generate your data and convert it to a CSV format
  var value;
  List<List<dynamic>> data = [
    ['Item ID:', _itemID],
    ['Item Name:', _itemName],
    ['Max:', _max],
    ['Min:', _min],
    [], // Empty row for separation
    ['Sampling Date', 'Value'],
    [
      historyChartData[0].samplingDate,
      double.parse(historyChartData[0].resultApprove)
    ],
    [
      historyChartData[1].samplingDate,
      double.parse(historyChartData[1].resultApprove)
    ],
    [
      historyChartData[2].samplingDate,
      double.parse(historyChartData[2].resultApprove)
    ],
    [
      historyChartData[3].samplingDate,
      double.parse(historyChartData[3].resultApprove)
    ],
    [
      historyChartData[4].samplingDate,
      double.parse(historyChartData[4].resultApprove)
    ],
    [
      historyChartData[5].samplingDate,
      double.parse(historyChartData[5].resultApprove)
    ],
    [
      historyChartData[6].samplingDate,
      double.parse(historyChartData[6].resultApprove)
    ],
    [
      historyChartData[7].samplingDate,
      double.parse(historyChartData[7].resultApprove)
    ],
    [
      historyChartData[8].samplingDate,
      double.parse(historyChartData[8].resultApprove)
    ],
    [
      historyChartData[9].samplingDate,
      double.parse(historyChartData[9].resultApprove)
    ],
  ];
  String csvData = ListToCsvConverter().convert(data);

  // Prepare the data for download
  final url = 'data:text/csv;base64,' + base64Encode(utf8.encode(csvData));
  final name = 'data.csv';

  // Launch the download URL
  launch(url);
}

void downloadDataToExcel(
    String _itemID, String _itemName, String _max, String _min) async {
  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Sheet1'];

  sheetObject.merge(
      CellIndex.indexByString("C5"), CellIndex.indexByString("F5"));
  sheetObject.merge(
      CellIndex.indexByString("C6"), CellIndex.indexByString("D6"));
  sheetObject.merge(
      CellIndex.indexByString("C7"), CellIndex.indexByString("D7"));
  sheetObject.merge(
      CellIndex.indexByString("C8"), CellIndex.indexByString("D8"));
  sheetObject.merge(
      CellIndex.indexByString("C9"), CellIndex.indexByString("D9"));
  sheetObject.merge(
      CellIndex.indexByString("C9"), CellIndex.indexByString("D9"));
  sheetObject.merge(
      CellIndex.indexByString("C12"), CellIndex.indexByString("D12"));

  // Write headers and data
  sheetObject.cell(CellIndex.indexByString("C5")).value =
      historyChartData[0].custFull;
  sheetObject.cell(CellIndex.indexByString("C6")).value = "ItemID";
  sheetObject.cell(CellIndex.indexByString("C7")).value = "ItemName";
  sheetObject.cell(CellIndex.indexByString("C8")).value = "Max";
  sheetObject.cell(CellIndex.indexByString("C9")).value = "Min";
  sheetObject.cell(CellIndex.indexByString("C12")).value = "Date";
  sheetObject.cell(CellIndex.indexByString("E12")).value = "Volumes";

  // Write head data
  sheetObject.cell(CellIndex.indexByString("E6")).value = _itemID;
  sheetObject.cell(CellIndex.indexByString("E7")).value = _itemName;
  sheetObject.cell(CellIndex.indexByString("E8")).value = _max;
  sheetObject.cell(CellIndex.indexByString("E9")).value = _min;

  // Write date
  for (int i = 0; i < historyChartData.length; i++) {
    sheetObject.cell(CellIndex.indexByString("C${13 + i}")).value =
        historyChartData[i].samplingDate;
  }

  // Write data values
  for (int i = 0; i < historyChartData.length; i++) {
    sheetObject.cell(CellIndex.indexByString("E${13 + i}")).value =
        double.parse(historyChartData[i].resultApprove);
  }

  // Save Excel file
  dynamic bytes = excel.save();
  String dir = (await getExternalStorageDirectory())!.path;
  String filePath = '$dir/history_data.xlsx';
  await File(filePath).writeAsBytes(bytes);
}
