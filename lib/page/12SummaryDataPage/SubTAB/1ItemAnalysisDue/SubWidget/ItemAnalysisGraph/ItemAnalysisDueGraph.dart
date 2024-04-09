import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tpk_login_arsa_01/Global/dataTime.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/1ItemAnalysisDue/SubWidget/ItemAnalysisGraph/data/ItemAnalysisDueGraphStructure.dart';
import 'package:tpk_login_arsa_01/page/12SummaryDataPage/SubTAB/1ItemAnalysisDue/SubWidget/ItemAnalysisGraph/data/ItemAnalysisDueGraph_bloc.dart';

class ItemAnalysisDueGrpah extends StatefulWidget {
  String branch = "";
  ItemAnalysisDueGrpah({Key? key, required this.branch}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ItemAnalysisDueGrpahState();
}

class ItemAnalysisDueGrpahState extends State<ItemAnalysisDueGrpah> {
  static const double barWidth = 22;
  static const shadowOpacity = 0.2;
  static const receiveColor = Color.fromARGB(255, 221, 211, 22);
  static const waitAnalysisColor = Color.fromARGB(255, 246, 148, 0);
  static const waitRecheckColor = Color.fromARGB(255, 97, 240, 26);
  static const waitReconfirmColor = Color.fromARGB(255, 7, 239, 173);
  static const waitApproveColor = Color.fromARGB(255, 0, 191, 255);
  static const approveColor = Color.fromARGB(255, 206, 4, 233);

  static const mainItems = <int, List<double>>{
    0: [2, 3, 2.5, 8],
    1: [1.8, 2.7, 3, 6.5],
    2: [1.5, 2, 3.5, 6],
    3: [1.5, 1.5, 4, 6.5],
    4: [2, 2, 5, 9],
    5: [1.2, 1.5, 4.3, 10],
    6: [1.2, 4.8, 5, 5],
  };
  int touchedIndex = -1;

  @override
  void initState() {
    print('initial ${widget.branch}');
    super.initState();
  }

  /* BarChartGroupData generateGroup(
    int x,
    double value1,
    double value2,
    double value3,
    double value4,
  ) {
    bool isTop = value1 > 0;
    final sum = value1 + value2 + value3 + value4;
    final isTouched = touchedIndex == x;
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      showingTooltipIndicators: [
        0,
      ],
      //showingTooltipIndicators: isTouched ? [0] : [],
      barRods: [
        BarChartRodData(
          toY: sum,
          width: barWidth,
          borderRadius: isTop
              ? const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                )
              : const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
          rodStackItems: [
            BarChartRodStackItem(
              0,
              value1,
              const Color(0xff2bdb90),
              BorderSide(
                color: Colors.white,
                width: isTouched ? 2 : 0,
              ),
            ),
            BarChartRodStackItem(
              value1,
              value1 + value2,
              const Color(0xffffdd80),
              BorderSide(
                color: Colors.white,
                width: isTouched ? 2 : 0,
              ),
            ),
            BarChartRodStackItem(
              value1 + value2,
              value1 + value2 + value3,
              const Color(0xffff4d94),
              BorderSide(
                color: Colors.white,
                width: isTouched ? 2 : 0,
              ),
            ),
            BarChartRodStackItem(
              value1 + value2 + value3,
              value1 + value2 + value3 + value4,
              Color.fromARGB(255, 103, 131, 143),
              BorderSide(
                color: Colors.white,
                width: isTouched ? 2 : 0,
              ),
            ),
          ],
        ),
        /* BarChartRodData(
          toY: -sum,
          width: barWidth,
          colors: [Colors.transparent],
          borderRadius: isTop
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
          rodStackItems: [
            BarChartRodStackItem(
                0,
                -value1,
                const Color(0xff2bdb90)
                    .withOpacity(isTouched ? shadowOpacity * 2 : shadowOpacity),
                const BorderSide(color: Colors.transparent)),
            BarChartRodStackItem(
                -value1,
                -(value1 + value2),
                const Color(0xffffdd80)
                    .withOpacity(isTouched ? shadowOpacity * 2 : shadowOpacity),
                const BorderSide(color: Colors.transparent)),
            BarChartRodStackItem(
                -(value1 + value2),
                -(value1 + value2 + value3),
                const Color(0xffff4d94)
                    .withOpacity(isTouched ? shadowOpacity * 2 : shadowOpacity),
                const BorderSide(color: Colors.transparent)),
            BarChartRodStackItem(
                -(value1 + value2 + value3),
                -(value1 + value2 + value3 + value4),
                const Color(0xff19bfff)
                    .withOpacity(isTouched ? shadowOpacity * 2 : shadowOpacity),
                const BorderSide(color: Colors.transparent)),
          ],
        ), */
      ],
    );
  } */
  double sumDataCount(int i) {
    return ItemAnalysisDueGrpah[i].countReceive +
        ItemAnalysisDueGrpah[i].countWaitAnalysis +
        ItemAnalysisDueGrpah[i].countWaitRecheck +
        ItemAnalysisDueGrpah[i].countWaitReconfirm +
        ItemAnalysisDueGrpah[i].countWaitApprove;
    //ItemAnalysisDueGrpah[i].countApprove;
  }

  double findMaxY() {
    double buffMax = 0;
    for (int i = 0; i < ItemAnalysisDueGrpah.length; i++) {
      if (sumDataCount(i) > buffMax) {
        buffMax = sumDataCount(i);
      }
    }
    return buffMax;
  }

  List<BarChartGroupData> generateDataGroup() {
    List<BarChartGroupData> dataChart = [];
    double widthBar = 30;
    for (int i = 0; i < ItemAnalysisDueGrpah.length; i++) {
      double sum = sumDataCount(i);
      dataChart.add(BarChartGroupData(
        x: i,
        groupVertically: true,
        showingTooltipIndicators: [
          0,
        ],
        barRods: [
          BarChartRodData(
            toY: sum,
            width: widthBar,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            rodStackItems: [
              BarChartRodStackItem(
                  0, ItemAnalysisDueGrpah[i].countReceive, receiveColor
                  /* BorderSide(
                  color: receiveColor,
                  width: widthBar,
                ), */
                  ),
              BarChartRodStackItem(
                ItemAnalysisDueGrpah[i].countReceive,
                ItemAnalysisDueGrpah[i].countReceive +
                    ItemAnalysisDueGrpah[i].countWaitAnalysis,
                waitAnalysisColor,
                /* BorderSide(
                  color: waitAnalysisColor,
                  width: widthBar,
                ), */
              ),
              BarChartRodStackItem(
                ItemAnalysisDueGrpah[i].countReceive +
                    ItemAnalysisDueGrpah[i].countWaitAnalysis,
                ItemAnalysisDueGrpah[i].countReceive +
                    ItemAnalysisDueGrpah[i].countWaitAnalysis +
                    ItemAnalysisDueGrpah[i].countWaitRecheck,
                waitRecheckColor,
                /* BorderSide(
                  color: waitApproveColor,
                  width: widthBar,
                ), */
              ),
              BarChartRodStackItem(
                ItemAnalysisDueGrpah[i].countReceive +
                    ItemAnalysisDueGrpah[i].countWaitAnalysis +
                    ItemAnalysisDueGrpah[i].countWaitRecheck,
                ItemAnalysisDueGrpah[i].countReceive +
                    ItemAnalysisDueGrpah[i].countWaitAnalysis +
                    ItemAnalysisDueGrpah[i].countWaitRecheck +
                    ItemAnalysisDueGrpah[i].countWaitReconfirm,
                waitReconfirmColor,
                /* BorderSide(
                  color: Colors.white,
                  width: widthBar,
                ), */
              ),
              BarChartRodStackItem(
                ItemAnalysisDueGrpah[i].countReceive +
                    ItemAnalysisDueGrpah[i].countWaitAnalysis +
                    ItemAnalysisDueGrpah[i].countWaitRecheck +
                    ItemAnalysisDueGrpah[i].countWaitReconfirm,
                ItemAnalysisDueGrpah[i].countReceive +
                    ItemAnalysisDueGrpah[i].countWaitAnalysis +
                    ItemAnalysisDueGrpah[i].countWaitRecheck +
                    ItemAnalysisDueGrpah[i].countWaitReconfirm +
                    ItemAnalysisDueGrpah[i].countWaitApprove,
                waitApproveColor,
                /* BorderSide(
                  color: Colors.white,
                  width: widthBar,
                ), */
              ),
            ],
          ),
        ],
      ));
    }
    return dataChart;
  }

  List<ModelItemAnalysisDueGrpah> ItemAnalysisDueGrpah = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /* BlocBuilder<ManageDataItemAnalysisDueGrpah, int>(builder: (context, state) { */
        FutureBuilder(
            future: fetchItemAnalysisDueGrpah(widget.branch),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != 2) {
                return Container();
              } else {
                if (widget.branch == "BANGPOO") {
                  ItemAnalysisDueGrpah = ItemAnalysisDueGrpahBuffBP;
                } else {
                  ItemAnalysisDueGrpah = ItemAnalysisDueGrpahBuffRY;
                }
                return Card(
                    color: Colors.white,
                    elevation: 4,
                    child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SUMMARY ITEM DATA ${widget.branch} (By Duedate)',
                                style: TextStyle(
                                  color: Color(0xff171547),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              LegendsListWidget(
                                legends: [
                                  Legend("RECEIVE", receiveColor),
                                  Legend("WAIT ANALYSIS", waitAnalysisColor),
                                  Legend("WAIT RECHECK", waitRecheckColor),
                                  Legend("WAIT RECONFIRM", waitReconfirmColor),
                                  Legend("WAIT APPROVE", waitApproveColor),
                                ],
                              ),
                              const SizedBox(height: 14),
                              AspectRatio(
                                aspectRatio: 2,
                                child: BarChart(
                                  BarChartData(
                                    alignment: BarChartAlignment.center,
                                    maxY: findMaxY() + 50,
                                    //minY: -20,
                                    groupsSpace: 60,
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    barGroups: generateDataGroup(),
                                    /* mainItems.entries
                                    .map((e) => generateGroup(e.key, e.value[0],
                                        e.value[1], e.value[2], e.value[3]))
                                    .toList(), */
                                    barTouchData: BarTouchData(
                                        enabled: true,
                                        touchTooltipData: BarTouchTooltipData(
                                            maxContentWidth: 50,
                                            getTooltipItem: (group, groupIndex,
                                                rod, rodIndex) {
                                              return BarTooltipItem(
                                                toDateOnly(ItemAnalysisDueGrpah[
                                                            groupIndex]
                                                        .analysisDuedate) +
                                                    '\n' +
                                                    ' (' +
                                                    sumDataCount(groupIndex)
                                                        .toString() +
                                                    ')' +
                                                    '\n',
                                                const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 8,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: "RECEIVE" +
                                                        '\n' +
                                                        (ItemAnalysisDueGrpah[
                                                                    groupIndex]
                                                                .countReceive)
                                                            .toString() +
                                                        '\n',
                                                    style: const TextStyle(
                                                      color: receiveColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "WAIT ANALYSIS" +
                                                        '\n' +
                                                        (ItemAnalysisDueGrpah[
                                                                    groupIndex]
                                                                .countWaitAnalysis)
                                                            .toString() +
                                                        '\n',
                                                    style: const TextStyle(
                                                      color: waitAnalysisColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "WAIT RECHECK" +
                                                        '\n' +
                                                        (ItemAnalysisDueGrpah[
                                                                    groupIndex]
                                                                .countWaitRecheck)
                                                            .toString() +
                                                        '\n',
                                                    style: const TextStyle(
                                                      color: waitRecheckColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "WAIT RECONFIRM" +
                                                        '\n' +
                                                        (ItemAnalysisDueGrpah[
                                                                    groupIndex]
                                                                .countWaitReconfirm)
                                                            .toString() +
                                                        '\n',
                                                    style: const TextStyle(
                                                      color: waitReconfirmColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "WAIT APPROVE" +
                                                        '\n' +
                                                        (ItemAnalysisDueGrpah[
                                                                    groupIndex]
                                                                .countWaitApprove)
                                                            .toString() +
                                                        '\n',
                                                    style: const TextStyle(
                                                      color: waitApproveColor,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            })),

                                    titlesData: FlTitlesData(
                                      show: true,
                                      topTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 80,
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
                                                  toDateOnly(
                                                      ItemAnalysisDueGrpah[
                                                              value.toInt()]
                                                          .analysisDuedate),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          },

                                          /*   getTextStyles: (context, value) =>
                                              const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10),
                                          //margin: 10,
                                          rotateAngle: -45,
                                          getTitles: (value) {
                                            return toDateOnly(
                                                ItemAnalysisDueGrpah[
                                                        value.toInt()]
                                                    .analysisDuedate);
                                          }, */
                                        ),
                                      ),
                                      /* leftTitles: SideTitles(
                                          showTitles: true,
                                          getTextStyles: (context, value) =>
                                              const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                          //rotateAngle: 45,
                                          /* getTitles: (double value) {
                                        if (value == 0) {
                                          return '0';
                                        }
                                        return '${value.toInt()}0k';
                                      }, */
                                          interval: 20,
                                          margin: 5,
                                          //reservedSize: 20,
                                        ),
                                        rightTitles:
                                            SideTitles(showTitles: false)*/
                                    ),
                                    /* gridData: FlGridData(
                                  show: true,
                                  checkToShowHorizontalLine: (value) =>
                                      value % 5 == 0,
                                  getDrawingHorizontalLine: (value) {
                                    if (value == 0) {
                                      return FlLine(
                                          color: const Color(0xff363753),
                                          strokeWidth: 3);
                                    }
                                    return FlLine(
                                      color: const Color(0xff2a2747),
                                      strokeWidth: 0.8,
                                    );
                                  },
                                ), */
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ])));
              }
            }),
      ],
    );
  }
}

class LegendWidget extends StatelessWidget {
  final String name;
  final Color color;

  const LegendWidget({
    Key? key,
    required this.name,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          name,
          style: const TextStyle(
            color: Color(0xff757391),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

/* class ItemAnalysisDueGrpah2 extends StatelessWidget {
  const ItemAnalysisDueGrpah2({Key? key}) : super(key: key);

  static const pilateColor = Color(0xff632af2);
  static const cyclingColor = Color(0xffffb3ba);
  static const quickWorkoutColor = Color(0xff578eff);
  static const betweenSpace = 0;

  BarChartGroupData generateGroupData(
      int x, double pilates, double quickWorkout, double cycling) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      showingTooltipIndicators: [0, 1, 2],
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: pilates,
          colors: [pilateColor],
          width: 10,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout,
          colors: [quickWorkoutColor],
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace + quickWorkout + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout + betweenSpace + cycling,
          colors: [cyclingColor],
          width: 5,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Activity',
              style: TextStyle(
                color: Color(0xff171547),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LegendsListWidget(
              legends: [
                Legend("Pilates", pilateColor),
                Legend("Quick workouts", quickWorkoutColor),
                Legend("Cycling", cyclingColor),
              ],
            ),
            const SizedBox(height: 14),
            AspectRatio(
              aspectRatio: 2,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: false),
                    rightTitles: SideTitles(showTitles: false),
                    topTitles: SideTitles(showTitles: false),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (context, value) => const TextStyle(
                        color: Color(0xff787694),
                        fontSize: 10,
                      ),
                      reservedSize: 8,
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case 0:
                            return "JAN";
                          case 1:
                            return "FEB";
                          case 2:
                            return "MAR";
                          case 3:
                            return "APR";
                          case 4:
                            return "MAY";
                          case 5:
                            return "JUN";
                          case 6:
                            return "JUL";
                          case 7:
                            return "AUG";
                          case 8:
                            return "SEP";
                          case 9:
                            return "OCT";
                          case 10:
                            return "NOV";
                          case 11:
                            return "DEC";
                        }
                        return value.toString();
                      },
                    ),
                  ),
                  barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        String weekDay;
                        switch (group.x.toInt()) {
                          case 0:
                            weekDay = 'Monday';
                            break;
                          case 1:
                            weekDay = 'Tuesday';
                            break;
                          case 2:
                            weekDay = 'Wednesday';
                            break;
                          case 3:
                            weekDay = 'Thursday';
                            break;
                          case 4:
                            weekDay = 'Friday';
                            break;
                          case 5:
                            weekDay = 'Saturday';
                            break;
                          case 6:
                            weekDay = 'Sunday';
                            break;
                          default:
                            throw Error();
                        }
                        return BarTooltipItem(
                          weekDay + '\n',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 8,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: (rod.toY - 1).toString(),
                              style: const TextStyle(
                                color: Colors.yellow,
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      })),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barGroups: [
                    generateGroupData(0, 2, 3, 2),
                    generateGroupData(1, 2, 5, 1.7),
                    generateGroupData(2, 1.3, 3.1, 2.8),
                    generateGroupData(3, 3.1, 4, 3.1),
                    generateGroupData(4, 0.8, 3.3, 3.4),
                    generateGroupData(5, 2, 5.6, 1.8),
                    generateGroupData(6, 1.3, 3.2, 2),
                    generateGroupData(7, 2.3, 3.2, 3),
                    generateGroupData(8, 2, 4.8, 2.5),
                    generateGroupData(9, 1.2, 3.2, 2.5),
                    generateGroupData(10, 1, 4.8, 3),
                    generateGroupData(11, 2, 4.4, 2.8),
                  ],
                  maxY: 10 + (betweenSpace * 3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */
class LegendsListWidget extends StatelessWidget {
  final List<Legend> legends;

  const LegendsListWidget({
    Key? key,
    required this.legends,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: legends
          .map(
            (e) => LegendWidget(
              name: e.name,
              color: e.color,
            ),
          )
          .toList(),
    );
  }
}

class Legend {
  final String name;
  final Color color;

  Legend(this.name, this.color);
}
